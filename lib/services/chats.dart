// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class MessageHelper {
  static void printMessageList(List list)
  {
    for(int i=0; i<list.length; i++)
    {
      debugPrint("Content: ${list[i].get('content')}");
      debugPrint("FromID: ${list[i].get('FromID')}");
      debugPrint("ToID: ${list[i].get('ToID')}");
      debugPrint("Timestamp: ${list[i].get('timestamp'.toString())}");
    }
  }
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

    debugPrint("One");
    MessageHelper.printMessageList(docsOne);
    debugPrint("Two");
    MessageHelper.printMessageList(docsTwo);

    List finalList = List.empty(growable: true);

    while(i < docsOne.length && j < docsTwo.length)
    {
      DateTime timeOne = docsOne[i].get('timestamp').toDate();
      DateTime timeTwo = docsTwo[j].get('timestamp').toDate();
      if(timeOne.compareTo(timeTwo)>0)
      {
        finalList.add(docsOne[i]);
        i++;
      }
      else if(timeOne.compareTo(timeTwo)<0)
      {
        finalList.add(docsTwo[j]);
        j++;
      }
      else
      {
        finalList.add(docsOne[i]);
        i++;
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

    debugPrint("Final");
    MessageHelper.printMessageList(finalList);

    return finalList;
  }
}
