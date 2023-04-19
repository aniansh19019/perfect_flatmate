import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class View_Profile extends StatefulWidget {
  const View_Profile({super.key});

  @override
  State<View_Profile> createState() => _View_ProfileState();
}

class _View_ProfileState extends State<View_Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Scaffold(
      appBar: AppBar(
        title: const Text("View Settings"),
      ),
      body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2013/05/11/08/28/sunset-110305_1280.jpg'),
              backgroundColor: Colors.red.shade800,
              radius: 80),
          ),
          Container(
              margin: EdgeInsets.all(10),  
              child: Text("Nayesha Sikka", style: TextStyle(fontSize: 30.0),),  
          ),
          Container(
              margin: const EdgeInsets.only(top: 20,left: 10),  
              width: 320,
              child: Text("About Me", 
                          style: TextStyle(fontSize: 12.0 ,color: Colors.red.shade800),
                          textAlign: TextAlign.left,),  
          ),
          Container(
              margin: const EdgeInsets.only(top: 5, left: 10),  
              width: 320,
              child: Text("I am moving to Banglore for my new job. I am looking for a flatmate with whom I can enjoy the experience of moving to new city.",
               style: TextStyle(fontSize: 20.0 ,color: Color.fromARGB(255, 0, 0, 0)),),  
          ),
          Container(
              margin: const EdgeInsets.only(top: 20, left: 10),
              width: 320,  
              child: Text("Age", style: TextStyle(fontSize: 12.0 ,color: Colors.red.shade800),),  
          ),
          Container(
              margin: const EdgeInsets.only(top: 5, left: 10),
              width: 320,  
              child: Text("22",
               style: TextStyle(fontSize: 20.0 ,color: Color.fromARGB(255, 0, 0, 0)),),  
          ),
          Container(
              margin: const EdgeInsets.only(top: 20, left: 10), 
              width: 320, 
              child: Text("Gender", style: TextStyle(fontSize: 12.0 ,color: Colors.red.shade800),),  
          ),
          Container(
              margin: const EdgeInsets.only(top: 5, left: 10),  
              width: 320,
              child: Text("Female",
               style: TextStyle(fontSize: 20.0 ,color: Color.fromARGB(255, 0, 0, 0)),),  
          ),
          Container(
              margin: const EdgeInsets.only(top: 20, left:10), 
              width: 320, 
              child: Text("Profession", style: TextStyle(fontSize: 12.0 ,color: Colors.red.shade800),),  
          ),
          Container(
              margin: const EdgeInsets.only(top: 5, left: 10),  
              width: 320,
              child: Text("Software Engineer",
               style: TextStyle(fontSize: 20.0 ,color: Color.fromARGB(255, 0, 0, 0)),),  
          ),
          Container(
              margin: EdgeInsets.all(10),  
              child: OutlinedButton( 
                child: Text("Edit Profile", style: TextStyle(fontSize: 20.0),),  
                style: OutlinedButton.styleFrom( 
                    primary: Colors.red.shade800,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () => {}, 
              ),
          )
        ],
      ),
      ))
    );
  }
}
