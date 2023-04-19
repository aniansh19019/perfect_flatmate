import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:perfect_flatmate/widgets/forms.dart';
import '../services/auth.dart';
import '../services/data.dart';

import '../services/storage.dart';
import 'dart:io' as io;

class AccountSetup extends StatefulWidget {
  @override
  _AccountSetupState createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  Map<String, dynamic> _newUserDetails = {};
  String? imagePath;
  String errorMessage = "";

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _saveDetails(additionalDetails) 
  {
    
    if(imagePath != null)
    {
      String imageUri = Storage.uploadFile(imagePath!);
    }
    else
    {
      errorMessage = "Please select an image!";
      setState(() {
        
      });
      return;
    }
    
    _newUserDetails['name'] = _nameController.text;
    _newUserDetails['age'] = int.tryParse(_ageController.text);
    _newUserDetails['email'] = Auth.getCurrentUser();
    _newUserDetails['dob'] = _dobController.text;
    _newUserDetails.addAll(additionalDetails);
    print(_newUserDetails); // Print the details for debugging purposes
    DataHelper.addUser(_newUserDetails, context);

    Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
  }

  void _navigateToAdditionalDetails() async {
    final additionalDetails =
        await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AdditionalDetailsPage(),
    ));

    _saveDetails(additionalDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New User Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12,),
              Center(child: ElevatedButton(
                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(CircleBorder()),
                                  // backgroundColor: MaterialStateProperty.all(Colors.white)
                                ),
                onPressed: ()async
                {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                
                  if (result != null) 
                  {
                    // File file = File(result.files.single.path!);
                    
                    setState(() {
                      imagePath = result.files.single.path!;
                    });
                    // Storage.uploadFile(filePath)
                  } 
                  else 
                  {
                    // User canceled the picker
                  }
                }, child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.image_outlined,
                    size: 60,
                    ),
                ))),
              SizedBox(height: 12,),
              Center(child: Text(errorMessage, style: CustomTheme.error,),),
              Center(child: Text((imagePath == null)?"Select Image":"Image selected:$imagePath", style: CustomTheme.body,)),
              SizedBox(height: 16,),
              EasyFormField(
                label: "Name",
                textEditingController: _nameController,
                required: true,
              ),
             
              SizedBox(height: 16.0),
              EasyFormField(
                label: 'Date of Birth (dd/mm/yyyy)',
                textEditingController: _dobController,
              ),
              SizedBox(height: 16.0),
              EasyFormField(
                label: "Phone",
                textEditingController: _phoneController,
              ),
              SizedBox(height: 16.0),
              EasyFormField(
                label: "State",
                textEditingController: _stateController,
              ),
              SizedBox(height: 16.0),
              EasyFormField(
                label: "City",
                textEditingController: _cityController,
              ),
              
              ElevatedButton(
                onPressed: () {
                  _navigateToAdditionalDetails();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdditionalDetailsPage extends StatefulWidget {
  @override
  _AdditionalDetailsPageState createState() => _AdditionalDetailsPageState();
}

class _AdditionalDetailsPageState extends State<AdditionalDetailsPage> {
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  @override
  void dispose() {
    _cityController.dispose();
    _phoneController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _saveDetails(a) {
    Map<String, dynamic> additionalDetails = {};
    additionalDetails['city'] = _cityController.text;
    additionalDetails['phone'] = _phoneController.text;
    additionalDetails['state'] = _stateController.text;
    additionalDetails.addAll(a);
    Navigator.of(context).pop(additionalDetails);
  }

  void _navigateToAdditionalDetails_2() async {
    final additionalDetails =
        await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AdditionalDetailsPage_2(),
    ));

    _saveDetails(additionalDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'City',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _stateController,
              decoration: InputDecoration(
                hintText: 'State',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _navigateToAdditionalDetails_2();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class AdditionalDetailsPage_2 extends StatefulWidget {
  @override
  _AdditionalDetailsPageState_2 createState() =>
      _AdditionalDetailsPageState_2();
}

class _AdditionalDetailsPageState_2 extends State<AdditionalDetailsPage_2> {
  bool? has_place;
  bool? smoking;
  bool? _hasPet;
  bool? alcohol;
  bool? introvert;
  String diet = 'veg';
  String gender = 'other';
  String employment = 'student';
  String about = '';

  @override
  void initState() {
    super.initState();
    has_place = false;
    smoking = false;
    _hasPet = false;
    alcohol = false;
    introvert = false;
  }

  void _saveDetails() {
    Map<String, dynamic> additionalDetails = {};
    additionalDetails['has_place'] = has_place;
    additionalDetails['smoking'] = smoking;
    additionalDetails['hasPet'] = _hasPet;
    additionalDetails['alcohol'] = alcohol;
    additionalDetails['introvert'] = introvert;
    additionalDetails['diet'] = diet;
    additionalDetails['gender'] = gender;
    additionalDetails['employment'] = employment;

    Navigator.of(context).pop(additionalDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              TextField(
                maxLines: 5,
                onChanged: (value) {
                  setState(() {
                    about = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter summary',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Do you have a house?',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: true,
                    groupValue: has_place,
                    onChanged: (value) {
                      setState(() {
                        has_place = value;
                      });
                    },
                  ),
                  Text('Yes'),
                  SizedBox(width: 16.0),
                  Radio(
                    value: false,
                    groupValue: has_place,
                    onChanged: (value) {
                      setState(() {
                        has_place = value;
                      });
                    },
                  ),
                  Text('No'),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Are you a smoker?',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: true,
                    groupValue: smoking,
                    onChanged: (value) {
                      setState(() {
                        smoking = value;
                      });
                    },
                  ),
                  Text('Yes'),
                  SizedBox(width: 16.0),
                  Radio(
                    value: false,
                    groupValue: smoking,
                    onChanged: (value) {
                      setState(() {
                        smoking = value;
                      });
                    },
                  ),
                  Text('No'),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Do you drink alcohol?',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: true,
                    groupValue: alcohol,
                    onChanged: (value) {
                      setState(() {
                        alcohol = value;
                      });
                    },
                  ),
                  Text('Yes'),
                  SizedBox(width: 16.0),
                  Radio(
                    value: false,
                    groupValue: alcohol,
                    onChanged: (value) {
                      setState(() {
                        alcohol = value;
                      });
                    },
                  ),
                  Text('No'),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Do you have a pet?',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: true,
                    groupValue: _hasPet,
                    onChanged: (value) {
                      setState(() {
                        _hasPet = value;
                      });
                    },
                  ),
                  Text('Yes'),
                  SizedBox(width: 16.0),
                  Radio(
                    value: false,
                    groupValue: _hasPet,
                    onChanged: (value) {
                      setState(() {
                        _hasPet = value;
                      });
                    },
                  ),
                  Text('No'),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Personality type',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: true,
                    groupValue: introvert,
                    onChanged: (value) {
                      setState(() {
                        introvert = value;
                      });
                    },
                  ),
                  Text('Introvert'),
                  SizedBox(width: 16.0),
                  Radio(
                    value: false,
                    groupValue: introvert,
                    onChanged: (value) {
                      setState(() {
                        introvert = value;
                      });
                    },
                  ),
                  Text('Extrovert'),
                ],
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: diet,
                items: ['veg', 'non_veg', 'vegan']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    diet = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Food Preference',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Gender',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 'male',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value ?? 'male';
                      });
                    },
                  ),
                  Text('Male'),
                  SizedBox(width: 16.0),
                  Radio(
                    value: 'female',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value ?? 'female';
                      });
                    },
                  ),
                  Text('Female'),
                  SizedBox(width: 16.0),
                  Radio(
                    value: 'other',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value ?? 'other';
                      });
                    },
                  ),
                  Text('Other'),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Employment Status',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 'student',
                    groupValue: employment,
                    onChanged: (value) {
                      setState(() {
                        employment = 'student';
                      });
                    },
                  ),
                  Text('Student'),
                  SizedBox(width: 16.0),
                  Radio(
                    value: 'employed',
                    groupValue: employment,
                    onChanged: (value) {
                      setState(() {
                        employment = 'employed';
                      });
                    },
                  ),
                  Text('Employed'),
                  Radio(
                    value: 'unemployed',
                    groupValue: employment,
                    onChanged: (value) {
                      setState(() {
                        employment = 'unemployed';
                      });
                    },
                  ),
                  Text('Unmployed'),
                ],
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  _saveDetails();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
