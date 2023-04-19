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

  dynamic preferences = DataHelper.getUserDataFromField(
          'preferences', Auth.getCurrentUser()!);
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
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data != null) {
                  final data =
                      snapshot.data!.docs.first.data() as Map<String, dynamic>;
                  _ageRangeValues = RangeValues(
                      data['minAge'] as double, data['maxAge'] as double);
                  gender = data['gender'] as String;
                  personality_type = data['personality_type'] as String;
                  employment = data['employment'] as String;
                  diet = data['dietary_preferance'] as String;
                  smoking = data['smoking'] as bool;
                  alcohol = data['drinking'] as bool;
                  pets = data['pets'] as bool;
                  has_place = data['has_place'] as bool;
                  _cityController.text = data['city'] as String;
                  _stateController.text = data['state'] as String;
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
                          selected: has_place == true,
                          onSelected: (bool selected) {
                            setState(() {
                              has_place = selected;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Pet Preferences:',
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
                    ElevatedButton(
                      onPressed: () async {
                        // Save preferences to Firebase
                        await DataHelper.updateUserPreferences({
                          'preferences': {
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
                          }
                        }, Auth.getCurrentUser() as String);
                        // Navigate back to profile
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("/home", (route) => false);
                      },
                      child: Text('Save'),
                    ),
                  ],
                );
              }
              return Container();
            }),
      ),
    );
  }
}
