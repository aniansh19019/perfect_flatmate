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
import 'package:perfect_flatmate/pages/view_profile.dart';
import 'package:perfect_flatmate/pages/edit_preferences.dart';
import 'package:perfect_flatmate/widgets/image_avatar.dart';

import '../widgets/swipe_card_widget.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  dynamic data = DataHelper.getUserDataFromEmail(Auth.getCurrentUser()!);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Settings"),
            ),
            body: FutureBuilder<QuerySnapshot<Object?>?>(
                future: data,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object?>?> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final name = snapshot.data!.docs.first.get('name');
                    final age = snapshot.data!.docs.first.get('age');
                    final url = snapshot.data!.docs.first.get('image');
                    return CardHolder(
                      color: Color(0xFFFFF8F9),
                      elevation: 0,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100.0, vertical: 30.0),
                              child: ImageAvatar(imageUri: url, radius: 80),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                name,
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                age,
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                child: Text(
                                  "View Profile",
                                  style: CustomTheme.h3,
                                  // style: TextStyle(fontSize: 20.0),
                                ),
                                // style: OutlinedButton.styleFrom(
                                //     primary: CustomTheme.primaryPink,
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius:
                                //             BorderRadius.all(Radius.circular(10)))),
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => View_Profile(),
                                    ),
                                  )
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                child: Text(
                                  "Edit Preferences",
                                  style: CustomTheme.h3,
                                  // style: TextStyle(fontSize: 20.0),
                                ),
                                // style: OutlinedButton.styleFrom(
                                //     primary: CustomTheme.primaryPink,
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius:
                                //             BorderRadius.all(Radius.circular(10)))),
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditPreferences(),
                                    ),
                                  )
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                child: Text(
                                  "Log Out",
                                  style: CustomTheme.h3,
                                  // style: TextStyle(fontSize: 20.0),
                                ),
                                // style: OutlinedButton.styleFrom(
                                //     primary: CustomTheme.primaryPink,
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius:
                                //             BorderRadius.all(Radius.circular(10)))),
                                onPressed: () => {Auth.logout(context)},
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                })));
  }
}
