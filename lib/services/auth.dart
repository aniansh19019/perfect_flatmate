import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perfect_flatmate/util/route_args.dart';
// Simple class to handle all the firebase authentication
// TODO handle errors
class Auth 
{

  static void signUpWithGoogle()
  {

  }

  static void signUpWithFacebook()
  {
    
  }


  static void signUp(String email, String Password, context) async
  {

  } 

  static bool isUserLogin()
  {
    User ? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  static void checkLogin(context, {doesEmailExist = true, isPasswordCorrect = true}){
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) 
    {
      debugPrint("User not logged in!");
      Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false ,arguments: LoginArgs(doesEmailExist: doesEmailExist, isPasswordCorrect: isPasswordCorrect));
    } 
    else 
    {
      debugPrint("User Logged In!");
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    }
  }

  static void logout(context) async {
    debugPrint("Logging Out!");
    await FirebaseAuth.instance.signOut();
    checkLogin(context);
  }

  static void login(String email, String password, context) async {
    debugPrint("Logging In!");
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found with this email!')),
          );
          checkLogin(context, doesEmailExist: false);
        debugPrint('No user found for that email.');
        return;
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Password!')),
          );
          checkLogin(context, doesEmailExist: true, isPasswordCorrect: false);
        debugPrint('Wrong password provided for that user.');
        return;
      }
    }
    checkLogin(context);
  }

  static String ? getCurrentUser()
  {
    return FirebaseAuth.instance.currentUser!.email;
  }
}
