import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../services/storage.dart';
import '../services/auth.dart';
import '../services/data.dart';
import '../widgets/swipe_view.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:perfect_flatmate/widgets/forms.dart';
import '../services/storage.dart';
import 'dart:io' as io;
import 'package:perfect_flatmate/pages/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:perfect_flatmate/widgets/forms.dart';
import '../services/auth.dart';
import '../services/data.dart';

import '../services/storage.dart';

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {

  TextEditingController _aboutmeController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _professionController = TextEditingController();

  Map<String, dynamic> _newUserDetails = {};
  String? imagePath;
  String errorMessage = "";

  
   dynamic data= DataHelper.getUserDataFromEmail(Auth.getCurrentUser()!);

  
  // @override
  // void dispose() {
  //   _aboutmeController.dispose();
  //   _dobController .dispose();
  //   _dobController.dispose();
  //   _genderController.dispose();
  //   _professionController.dispose();
  //   super.dispose();
  // }

  void _saveDetails(dynamic email) {

    debugPrint("in savedetail function");
    String imageUri = "";
    if (imagePath != null) {
      imageUri = Storage.uploadFile(imagePath!);
    } else {
      errorMessage = "Please select an image!";
      setState(() {});
      return;
    }
    print(imageUri);
    _newUserDetails['about'] = _aboutmeController.text;
    _newUserDetails['dob'] = _dobController.text;
    _newUserDetails['gender'] = _genderController.text;
    _newUserDetails['employment'] = _professionController.text;
    _newUserDetails['image'] = imageUri;

    DataHelper.updateUserProfile(_newUserDetails);

    //Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    //

    Navigator.of(context).pushNamedAndRemoveUntil("/settings", (route) => false);

    // Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => Settings(),
    //               ),
    //             );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Settings"),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color:  Colors.red.shade800,),
          onPressed: () {},),
        ),
      body: FutureBuilder<QuerySnapshot<Object?>?>
      (
        future: data,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>?> snapshot)
        {
          if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else
            {
              final email= snapshot.data!.docs.first.get('email');
              return 
              Container(
        child: ListView(
            children: [
              SizedBox(
                height: 15,
        
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: Colors.red.shade800
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:NetworkImage('https://cdn.pixabay.com/photo/2013/05/11/08/28/sunset-110305_1280.jpg') 
                          )
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: Colors.red.shade800
                        ),
                        color: Colors.red.shade800
                      ),
                      child: IconButton  (icon:Icon(Icons.edit,color: Colors.white),
                      onPressed: () async{
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          // File file = File(result.files.single.path!);

                          setState(() {
                            imagePath = result.files.single.path!;
                          });
                          // Storage.uploadFile(filePath)
                        } else {
                          // User canceled the picker
                        }
                      }),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Abou Me", _aboutmeController),
              buildTextField("Date of Birth", _dobController),
              buildTextField("Gender", _genderController),
              buildTextField("Profession", _professionController),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                onPressed: ()async => {
                  _saveDetails(email)
                },
                child: Text('Save'),
              )
                    
                  ],
                ),
              )

            ],
          ),
      );
            }
        }
        
      )
      
    );
  }

  // Container(
                    //   margin: EdgeInsets.all(10),  
                    //   child: OutlinedButton( 
                    //     child: Text("Save", style: TextStyle(fontSize: 20.0),),  
                    //     style: OutlinedButton.styleFrom( 
                    //       primary: Colors.red.shade800,
                    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                    //     onPressed: () => {_saveDetails()}, 
                    //   ),
                    // ),


  Widget buildTextField(String lt,  TextEditingController ct) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0, left: 10.0),
      child: EasyFormField(
                label: lt,
                textEditingController: ct,
              ),
    );
  }





}