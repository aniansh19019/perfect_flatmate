import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../services/auth.dart';
import '../services/data.dart';
import '../widgets/swipe_view.dart';

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {

  TextEditingController _aboutmeController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _professionController = TextEditingController();

  Map<String, dynamic> _newUserDetails = {};
  String? imagePath;
  String errorMessage = "";

  // not sure if i have to use it or not
  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _emailController.dispose();
  //   _dobController.dispose();
  //   _cityController.dispose();
  //   _phoneController.dispose();
  //   _stateController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Likes"),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color:  Colors.red.shade800,),
          onPressed: () {},),
        ),
      body: Container(
        child: GestureDetector(
          onTap: () { FocusScope.of(context).unfocus();
          },
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
                      child: Icon(Icons.edit,color: Colors.red.shade800,),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Abou Me", "Need a new flatmate"),
              buildTextField("Age", "22"),
              buildTextField("Gender", "Female"),
              buildTextField("Profession", "Software Engineer"),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                  onPressed: (){},
                  child: Text("Cancel", style: TextStyle(fontSize: 14,letterSpacing: 2.2,color: Colors.red.shade800),)
                  ),
                  OutlinedButton(
                  onPressed: (){},
                  child: Text("Save", style: TextStyle(fontSize: 14,letterSpacing: 2.2,color: Colors.red.shade800),)
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: Colors.red.shade800
                  ),
                  hintText: "John Doe",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  )
        
                ),
              ),
    );
  }




}