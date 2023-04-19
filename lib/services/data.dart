import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfect_flatmate/services/auth.dart';
import 'package:perfect_flatmate/util/data_model.dart';
import 'package:perfect_flatmate/util/swipe_item_builder.dart';
import 'package:swipe_cards/swipe_cards.dart';

// TODO error handling in updates
// TODO firebase security rules
// TODO handle my_likes, my_dislikes
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

  static Future<QuerySnapshot?> getUserDataFromField(String field, String value) async
  {
    QuerySnapshot<Map<String, dynamic>> docs;

    try
    {
      docs = await FirebaseFirestore.instance.collection('users').where(field, isEqualTo: value).get();
    }
    catch(error)
    {
      debugPrint(error.toString());
      // return "Error getting user data from $field!";
      return null;
    }

    if(docs.size == 0)
    {
      return null;
    }
    return docs;
  }

  static Future<QuerySnapshot?> getUserDataFromEmail(String email)async
  {
    return await getUserDataFromField('email', email);
  }

  static Future<List<SwipeItem>?> getListings()async
  {
    QuerySnapshot<Map<String, dynamic>> docs;

    try
    {
      docs = await FirebaseFirestore.instance.collection('users').get();
    }
    catch(error)
    {
      debugPrint(error.toString());
      // return "Error getting user data from $field!";
      return null;
    }
    var swipeItems = SwipeItemBuilder.userListToSwipeItems(docs.docs);
    return swipeItems;
  }

  static Future<List<SwipeItem>> getLikes()async
  {
    // TODO: error handling
    List<dynamic> userList = List.empty(growable: true);
    var userRecord = (await getUserDataFromEmail(Auth.getCurrentUser()!))!.docs[0];
    var userLikes = userRecord.get('likes');
    for (var like in userLikes)
    {
      var otherRecord = (await getUserDataFromEmail(like))!.docs[0];
      userList.add(otherRecord);
    }
    var swipeItems = SwipeItemBuilder.userListToSwipeItems(userList);
    return swipeItems;
  }


  static Future<dynamic> submitDislike(String email)async
  {
    // TODO implement
    // 
  }

  static Future<dynamic> submitLike(String email)async
  {
    // TODO error handling
    var otherRecord = (await getUserDataFromEmail(email))?.docs[0];
    var selfRecord = (await getUserDataFromEmail(Auth.getCurrentUser()!))?.docs[0];
    if(otherRecord == null)
    {
      debugPrint("Error getting other Record!");
      return;
    }
    if(selfRecord == null)
    {
      debugPrint("Error getting self Record!");
      return;
    }
    // check if it is match
    List selfLikes = selfRecord.get('likes');
    List otherLikes = otherRecord.get('likes');
    // check if the email exists in your own likes
    bool didMatch = false;
    for(var otherEmail in selfLikes)
    {
      if(otherEmail == email)
      {
        didMatch = true;
        break;
      }
    }
   
    var otherDocId = otherRecord!.reference.id;
    var selfDocId = selfRecord!.reference.id;

    List otherMatches = otherRecord.get('matches');
    List selfMatches = selfRecord.get('matches');

     // add to eachother's matches
    if(didMatch)
    {
      // Remove email from self likes
      selfLikes.remove(email);
      
      try
      {
        // update self likes
        await FirebaseFirestore.instance.collection('users').doc(selfDocId).update({'likes': selfLikes});
        // update matches for both
        selfMatches.add(email);
        otherMatches.add(Auth.getCurrentUser());
        await FirebaseFirestore.instance.collection('users').doc(selfDocId).update({'matches': selfMatches});
        await FirebaseFirestore.instance.collection('users').doc(otherDocId).update({'matches': otherMatches});
      }
      catch(error)
      {
        debugPrint(error.toString());
        return "Error liking";
      }
    }
    else
    {
      try
      {
        // update likes for the other person
        otherLikes.add(Auth.getCurrentUser());
        await FirebaseFirestore.instance.collection('users').doc(otherDocId).update({'likes': otherLikes});
      }
      catch(error)
      {
        debugPrint(error.toString());
        return "Error liking";
      }
    }
    
    return "";
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