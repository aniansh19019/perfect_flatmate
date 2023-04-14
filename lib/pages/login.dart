import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, 
    child: Scaffold(
      appBar: AppBar(),
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
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
                Icon(Icons.directions_bike),]
        ),
      ),
      
    )
    );
  }
}

Widget menu()
{
  return TabBar(
          tabs: [
            Tab(
              text: "Car",
              icon: Icon(Icons.directions_car)),
            Tab(
              text: "Transit",
              icon: Icon(Icons.directions_transit)),
            Tab(
              text: "Bike",
              icon: Icon(Icons.directions_bike)),
          ]);
}