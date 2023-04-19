import 'package:flutter/gestures.dart';
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
    // if(!Auth.isUserLogin())
    // {
    //   Future.delayed(const Duration(milliseconds: 100), () {Auth.checkLogin(context);});
    //   return const SafeArea(child: Scaffold(body: Center(child: CircularProgressIndicator())));
    // }

    return DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Scaffold(
          // appBar: AppBar(),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TabBar(tabs: [
                Tab(
                    // text: "Car",
                    icon: Icon(Icons.favorite_border)),
                Tab(
                    // text: "Transit",
                    icon: Icon(Icons.search)),
                Tab(
                    // text: "Transit",
                    icon: Icon(Icons.chat_bubble_outline_rounded)),
                Tab(
                    // text: "Bike",
                    icon: Icon(Icons.account_circle_outlined)),
              ]),
            ),
          ),

          body: SafeArea(
            child:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              Likes(),
              Explore(),
              Matches(),
              Settings(),
            ]),
          ),
        ));
  }
}
