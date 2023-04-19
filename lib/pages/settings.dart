import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../services/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:perfect_flatmate/util/theme.dart';


import 'package:flutter/src/widgets/placeholder.dart';
import 'package:perfect_flatmate/services/data.dart';

import 'package:perfect_flatmate/util/theme.dart';


import '../services/auth.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

   @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: DataHelper.getUserDataFromEmail(Auth.getCurrentUser().toString()),
      builder: (context,  AsyncSnapshot<QuerySnapshot?> snapshot) {

        if(snapshot.hasData)
        {
          debugPrint( snapshot.data.toString());
        
          return Text('Data is printed on colsole');
        }
        else if(snapshot.hasError)
        {
          return Text('Error in fetching data');
        }
        else
        {
          return Center(child: CircularProgressIndicator());
        }
        

      });
    // return Container(
    //   child:  Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Settings"),
    //   ),
    //   body: Column(
    //     children: [
    //       Container(
    //         padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 30.0),
    //         child: CircleAvatar(
    //           backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2013/05/11/08/28/sunset-110305_1280.jpg'),
    //           backgroundColor: Colors.red.shade800,
    //           radius: 80),
    //       ),
    //       Container(
    //           margin: EdgeInsets.all(10), 
    //           child: Text("Nayesha Sikka", style: TextStyle(fontSize: 30.0),),  
    //       ),
    //       Container(
    //           margin: EdgeInsets.all(10),  
    //           child: Text("22", style: TextStyle(fontSize: 30.0),),  
    //       ),
    //       Container(
    //           margin: EdgeInsets.all(10),  
    //           child: OutlinedButton( 
    //             child: Text("View Profile", style: TextStyle(fontSize: 20.0),),  
    //             style: OutlinedButton.styleFrom( 
    //                 primary: Colors.red.shade800,
    //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
    //             onPressed: () => {}, 
    //           ),
    //       ),
    //       Container(
    //           margin: EdgeInsets.all(10),  
    //           child: OutlinedButton( 
    //             child: Text("Edit Preferences", style: TextStyle(fontSize: 20.0),),  
    //             style: OutlinedButton.styleFrom( 
    //                 primary: Colors.red.shade800,
    //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
    //             onPressed: () => {}, 
    //           ),
    //       ),
    //       Container(
    //           margin: EdgeInsets.all(10),  
    //           child: OutlinedButton( 
    //             child: Text("Log Out", style: TextStyle(fontSize: 20.0),),  
    //             style: OutlinedButton.styleFrom( 
    //                 primary: Colors.red.shade800,
    //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
    //             onPressed: () => Auth.logout(context), 
    //           ),
    //       )
    //     ],
    //   ),
    // )
    // );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: ElevatedButton(child: Text("Logout"),onPressed: () => Auth.logout(context)),
  //   );
  // }
}