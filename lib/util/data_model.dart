import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfect_flatmate/pages/likes.dart';

// class Preferences
// {
//   String state;
//   String city;
//   bool has_place;
//   bool smoking;
//   bool alcohol;
//   bool pets;
//   bool introvert;
//   int min_age;
//   int max_age;
//   String gender; // male, female, everyone
//   String employment; // student, employed, everyone
//   String diet; // veg, non_veg, vegan

// }

class DataModel
{
  // static String app_version = "1.0";
  late List<dynamic> images;
  String name;
  String email;
  String phone;
  DateTime dob;
  String state;
  String city;
  bool has_place;
  bool smoking;
  bool alcohol;
  bool pets;
  bool introvert;
  String diet; // veg, non_veg, vegan
  String about;
  String gender; // male, female, other
  String employment; // student, employed, unemployed
  late List<String> likes; // people who like your entry
  late List<String> matches;
  Map preferences;

  String app_version = "1.0";

  QueryDocumentSnapshot ?docRef;

  DataModel({
  required this.name, 
  required this.email, 
  required this.phone,
  required this.dob,
  required this.state,
  required this.city,
  required this.has_place,
  required this.smoking,
  required this.alcohol,
  required this.pets,
  required this.introvert,
  required this.diet,
  required this.about,
  required this.gender,
  required this.employment,
  required this.preferences,
  });

 DataModel.fromQuerySnapshot(QuerySnapshot snapshot):
  name = snapshot.docs[0].get("name"),
  email = snapshot.docs[0].get("email"),
  phone = snapshot.docs[0].get("phone"),
  dob = snapshot.docs[0].get("dob").toDate(),
  state = snapshot.docs[0].get("state"),
  city = snapshot.docs[0].get("city"),
  has_place = snapshot.docs[0].get("has_place"),
  smoking = snapshot.docs[0].get("smoking"),
  alcohol = snapshot.docs[0].get("alcohol"),
  pets = snapshot.docs[0].get("pets"),
  introvert = snapshot.docs[0].get("introvert"),
  diet = snapshot.docs[0].get("diet"),
  about = snapshot.docs[0].get("about"),
  gender = snapshot.docs[0].get("gender"),
  employment = snapshot.docs[0].get("employment"),
  // TODO preferences constructor
  preferences = snapshot.docs[0].get("preferences"),
  app_version = snapshot.docs[0].get("app_version"),
  docRef =  snapshot.docs[0];


}