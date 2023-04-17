import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfect_flatmate/services/auth.dart';
import 'package:perfect_flatmate/util/data_model.dart';

// TODO error handling in updates
// TODO firebase security rules
// !!! Hide Access Tokens!!!
class DataHelper
{
  static Future<String> markEntry(DataModel userData)async
  {
    var docId = userData.docRef!.reference.id;
    try
    {
      await FirebaseFirestore.instance.collection('users').doc(docId).update({'did_check_in': true});
    }
    catch(error)
    {
      debugPrint(error.toString());
      return "Error marking user entry!";
    }
    return "";
  }

  static Future<dynamic> getUserDataFromEmail(String email)async
  {
    QuerySnapshot<Map<String, dynamic>> docs;

    try
    {
      docs = await FirebaseFirestore.instance.collection('users').where("email", isEqualTo: email).get();
    }
    catch(error)
    {
      debugPrint(error.toString());
      return "Error getting user data from email!";
    }

    if(docs.size == 0)
    {
      return null;
    }
    return docs.docs[0];
  }

  static Future<dynamic> getListings()async
  {
    
  }

  static Future<dynamic> submitLike(String email)async
  {

  }


  static Future emailExists(String email) async
  {
    var data = await getUserDataFromEmail(email);
    if(data is String)
    {
      return "Error checking for user email record!\n$data";
    }
    return (data==null) ? false:true;
  }


  

  static Future<String> addUser(Map<String, dynamic> userData, context) async
  {
    var emailExistsResult = await emailExists(userData['email']);
    if(emailExistsResult is String)
    {
      return emailExistsResult;
    }
    if(emailExistsResult == true)
    {
      // * email already exists in record
      // display message
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This email already exists in the database!')),
          );
      return "This email already exists in the database!"; 
    }

    var db = FirebaseFirestore.instance;
    

    bool firestoreError = false;

    await db.collection('users').add(userData).then((DocumentReference doc) =>
      debugPrint('DocumentSnapshot added with ID: ${doc.id}')).catchError((error)
      {
        firestoreError = true;
        debugPrint(error.toString());
      });
    if(firestoreError)
    {
      debugPrint("Error while submitting the user record!");
      ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Error while submitting the user record!")),
    );
      return "Error while submitting the user record!";
    }

    debugPrint('$userData added');
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Record Submitted!')),
    );
    
    return "";
  }
}