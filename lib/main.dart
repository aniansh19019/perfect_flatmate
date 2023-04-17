import 'package:flutter/material.dart';
import 'package:perfect_flatmate/pages/account_setup.dart';
import 'package:perfect_flatmate/pages/home.dart';
import 'package:perfect_flatmate/pages/loading.dart';
import 'package:perfect_flatmate/pages/login.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      // debugPaintSizeEnabled = true;
      
      
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
          )
        ),
        tabBarTheme: TabBarTheme(
          splashFactory: NoSplash.splashFactory,
          indicator: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300]
          ),
          labelColor: Color(0xFFF65E7E),
          unselectedLabelColor: Colors.grey,
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      initialRoute: "/",
      routes: {
        "/" :(context) => Loading(),
        "/login" : (context) => Login(),
        "/login/account_setup" : (context) => AccountSetup(),
        "/home":(context) => Home()
      },
    );
  }
}

