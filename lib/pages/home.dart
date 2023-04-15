import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_flatmate/pages/explore.dart';
import 'package:perfect_flatmate/pages/likes.dart';
import 'package:perfect_flatmate/pages/matches.dart';
import 'package:perfect_flatmate/pages/settings.dart';

import '../services/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {

    if(!Auth.isUserLogin())
    {
      Future.delayed(Duration(milliseconds: 100), () {Auth.checkLogin(context);});
      return SafeArea(child: Scaffold(body: Center(child: CircularProgressIndicator())));
    }

    return DefaultTabController(
      length: 4, 
    child: Scaffold(
      // appBar: AppBar(),
      bottomNavigationBar: SafeArea(
        child: TabBar(
          tabs: [
            Tab(
              // text: "Car",
              icon: Icon(Icons.heart_broken_outlined)),
            Tab(
              // text: "Transit",
              icon: Icon(Icons.search)),
              Tab(
              // text: "Transit",
              icon: Icon(Icons.chat_bubble_outline_rounded)),
            Tab(
              // text: "Bike",
              icon: Icon(Icons.bike_scooter)),
          ]),
      ),
        
      body: SafeArea(
        child: TabBarView(
          children: [
                Likes(),
                Explore(),
                Matches(),
                Settings(),]
        ),
      ),
      
    )
    );
  }
}
