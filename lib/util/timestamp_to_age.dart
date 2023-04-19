import 'package:cloud_firestore/cloud_firestore.dart';

class AgeHelper
{
  static String timestampToAge(dynamic timestamp)
  {
    DateTime birthDate = timestamp.toDate();
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(birthDate);
    int age = (difference.inDays / 365).floor();
    return age.toString();
  }
}