import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class MessageHelper {
  // static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages() {
  //   return FirebaseFirestore.instance.collection('messages').snapshots();
  // }
  static Future<List> getChats(String otherEmail)async
  {
    var docsOne = (await FirebaseFirestore.instance
        .collection('messages')
        .where('FromID', isEqualTo: otherEmail)
        .where('ToID', isEqualTo: Auth.getCurrentUser()).orderBy('timestamp', descending: true)
        .get()).docs;
    
    var docsTwo = (await FirebaseFirestore.instance
        .collection('messages')
        .where('ToID', isEqualTo: otherEmail)
        .where('FromID', isEqualTo: Auth.getCurrentUser()).orderBy('timestamp', descending: true)
        .get()).docs;
    
    // var sortedOne = sort

    int i = 0;
    int j = 0;
    // int k = 0;

    List finalList = List.empty(growable: true);

    while(i < docsOne.length && j < docsTwo.length)
    {
      var timeOne = docsOne[i].get('timestamp');
      var timeTwo = docsTwo[j].get('timestamp');
      if(timeOne > timeTwo)
      {
        finalList.add(docsOne[i]);
        i++;
      }
      else
      {
        finalList.add(docsOne[i]);
        j++;
      }
    }
    while(i<docsOne.length)
    {
      finalList.add(docsOne[i]);
      i++;
    }
    while(j<docsTwo.length)
    {
      finalList.add(docsTwo[j]);
      j++;
    }

    return finalList;
  }
}
