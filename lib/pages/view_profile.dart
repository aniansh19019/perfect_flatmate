import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_flatmate/pages/edit_profile.dart';
import '../services/data.dart';
import '../services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfect_flatmate/widgets/image_avatar.dart';

class View_Profile extends StatefulWidget {
  const View_Profile({super.key});

  @override
  State<View_Profile> createState() => _View_ProfileState();
}

class _View_ProfileState extends State<View_Profile> {

  dynamic data= DataHelper.getUserDataFromEmail(Auth.getCurrentUser()!);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Scaffold(
      appBar: AppBar(
        title: const Text("View Settings"),
      ),
      body: FutureBuilder<QuerySnapshot<Object?>?>(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>?> snapshot)
        {
          if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else
            {
              final name= snapshot.data!.docs.first.get('name');
              final about= snapshot.data!.docs.first.get('about');
              final age= snapshot.data!.docs.first.get('age');
              final gender= snapshot.data!.docs.first.get('gender');
              final employment= snapshot.data!.docs.first.get('employment');
              final url= snapshot.data!.docs.first.get('image');
              final state= snapshot.data!.docs.first.get('state');
              final has_place= snapshot.data!.docs.first.get('has_place')? "yes":"no";
              final alcohol= snapshot.data!.docs.first.get('alcohol')? "yes":"no";
              final smoking= snapshot.data!.docs.first.get('smoking')? "yes":"no";
              final diet= snapshot.data!.docs.first.get('diet');
              final introvert =snapshot.data!.docs.first.get('introvert')? "introvert":"exptrovert";
              final hasPet= snapshot.data!.docs.first.get('introvert')? "yes":"no";
             return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
            child:ImageAvatar(imageUri: url, radius: 80)
          ),
          Container(
              margin: EdgeInsets.all(10),  
              child: Text(name, style: TextStyle(fontSize: 30.0),),  
          ),
          buildLabelField("About Me"),
          buildDataField(about),
          buildLabelField("Age"),
          buildDataField(age),
          buildLabelField("Location"),
          buildDataField(state),
          buildLabelField("Has Place"),
          buildDataField(has_place),
          buildLabelField("Gender"),
          buildDataField(gender),
          buildLabelField("Employment Status"),
          buildDataField(employment),
          buildLabelField("Alcohol"),
          buildDataField(alcohol),
          buildLabelField("Smoking"),
          buildDataField(smoking),
          buildLabelField("Dietary Preferences"),
          buildDataField(diet),
          buildLabelField("Personality Type"),
          buildDataField(introvert),
          buildLabelField("Pets"),
          buildDataField(hasPet),
          Container(
              margin: EdgeInsets.all(10),  
              child: OutlinedButton( 
                child: Text("Edit Profile", style: TextStyle(fontSize: 20.0),),  
                style: OutlinedButton.styleFrom( 
                    primary: Colors.red.shade800,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () => {Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Edit_Profile(),
                  ),
                )}, 
              ),
          )
        ],
      ),
      );
            }
        }
      )
      )
    );
  }


  Widget buildLabelField(String lt) {
    return Container(
              margin: const EdgeInsets.only(top: 20,left: 10),  
              width: 320,
              child: Text(lt, 
                          style: TextStyle(fontSize: 12.0 ,color: Colors.red.shade800),
                          textAlign: TextAlign.left,),  
          );
  }

  Widget buildDataField(String lt) {
    return Container(
              margin: const EdgeInsets.only(top: 5, left: 10),  
              width: 320,
              child: Text(lt,
               style: TextStyle(fontSize: 20.0 ,color: Color.fromARGB(255, 0, 0, 0)),),  
          );
  }
}
