import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfect_flatmate/services/data.dart';

import '../services/auth.dart';

class EditPreferences extends StatefulWidget {
  @override
  _EditPreferencesState createState() => _EditPreferencesState();
}

class _EditPreferencesState extends State<EditPreferences> {
  RangeValues _ageRangeValues = RangeValues(18, 60);
  String gender = 'everyone';
  String personality_type = 'introvert';
  String employment = 'student';
  String diet = 'veg';
  bool smoking = false;
  bool alcohol = false;
  bool pets = false;
  bool has_place = false;
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  dynamic preferences =
      DataHelper.getUserDataFromField('email', Auth.getCurrentUser()!);

  @override
  void dispose() {
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Preferences'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: preferences,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Object?>?> snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.docs.first.get('preferences')
                    as Map<String, dynamic>;

                // _ageRangeValues = RangeValues(data['min_age'] as double? ?? 18,
                //     data['max_age'] as double? ?? 60);
                gender = data['gender'] as String? ?? 'everyone';
                personality_type =
                    data['personality_type'] as String? ?? 'introvert';
                employment = data['employment'] as String? ?? 'student';
                diet = data['dietary_preferance'] as String? ?? 'veg';
                smoking = data['smoking'] as bool? ?? false;
                alcohol = data['drinking'] as bool? ?? false;
                pets = data['pets'] as bool? ?? false;
                has_place = data['has_place'] as bool? ?? false;
                _cityController.text = data['city'] as String? ?? '';
                _stateController.text = data['state'] as String? ?? '';
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Age Range:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  RangeSlider(
                    values: _ageRangeValues,
                    min: 18,
                    max: 100,
                    divisions: 82,
                    labels: RangeLabels(
                      _ageRangeValues.start.round().toString(),
                      _ageRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _ageRangeValues = values;
                      });
                    },
                  ),
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
                  Text(
                    'Flatmate should already have a place:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: Text('Yes'),
                        selected: has_place,
                        onSelected: (bool selected) {
                          setState(() {
                            has_place = selected;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('No'),
                        selected: !has_place,
                        onSelected: (bool selected) {
                          setState(() {
                            has_place = !selected;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Gender Preference:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: Text('Male'),
                        selected: gender == 'male',
                        onSelected: (bool selected) {
                          setState(() {
                            gender = 'male';
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('Female'),
                        selected: gender == 'female',
                        onSelected: (bool selected) {
                          setState(() {
                            gender = 'female';
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('Everyone'),
                        selected: gender == 'everyone',
                        onSelected: (bool selected) {
                          setState(() {
                            gender = 'everyone';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Personality Preference:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: Text('Extrovert'),
                        selected: personality_type == 'extrovert',
                        onSelected: (bool selected) {
                          setState(() {
                            personality_type = 'extrovert';
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('Introvert'),
                        selected: personality_type == 'introvert',
                        onSelected: (bool selected) {
                          setState(() {
                            personality_type = 'introvert';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Smoking Allowed:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: Text('Yes'),
                        selected: smoking == true,
                        onSelected: (bool selected) {
                          setState(() {
                            smoking = selected;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('No'),
                        selected: smoking == false,
                        onSelected: (bool selected) {
                          setState(() {
                            smoking = !selected;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Drinking Preferences:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: Text('Yes'),
                        selected: alcohol == true,
                        onSelected: (bool selected) {
                          setState(() {
                            alcohol = selected;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('No'),
                        selected: alcohol == false,
                        onSelected: (bool selected) {
                          setState(() {
                            alcohol = !selected;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Pets Preferences:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: Text('Yes'),
                        selected: pets == true,
                        onSelected: (bool selected) {
                          setState(() {
                            pets = selected;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('No'),
                        selected: pets == false,
                        onSelected: (bool selected) {
                          setState(() {
                            pets = !selected;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Employment Preference:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: Text('Student'),
                        selected: employment == 'student',
                        onSelected: (bool selected) {
                          setState(() {
                            employment = 'student';
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('Employed'),
                        selected: employment == 'employed',
                        onSelected: (bool selected) {
                          setState(() {
                            employment = 'employed';
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('Unemployed'),
                        selected: employment == 'unemployed',
                        onSelected: (bool selected) {
                          setState(() {
                            employment = 'unemployed';
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Dietary Preference:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: Text('veg'),
                        selected: diet == 'veg',
                        onSelected: (bool selected) {
                          setState(() {
                            diet = 'veg';
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('non_veg'),
                        selected: diet == 'non_veg',
                        onSelected: (bool selected) {
                          setState(() {
                            diet = 'non_veg';
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text('vegan'),
                        selected: diet == 'vegan',
                        onSelected: (bool selected) {
                          setState(() {
                            diet = 'vegan';
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save preferences to Firebase

                      await DataHelper.updateUserPreferences({
                        'min_age': _ageRangeValues.start.round(),
                        'max_age': _ageRangeValues.end.round(),
                        'gender': gender,
                        'personality_type': personality_type,
                        'employment': employment,
                        'dietary_preference': diet,
                        'smoking': smoking,
                        'alcohol': alcohol,
                        'pets': pets,
                        'has_place': has_place,
                        'city': _cityController.text,
                        'state': _stateController.text
                      }, Auth.getCurrentUser() as String);

                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/home", (route) => false);
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
