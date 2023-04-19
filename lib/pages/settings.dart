import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../services/auth.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text("Edit"),
            onPressed: () => Navigator.of(context)
                .pushNamed("/edit"),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text("Logout"),
            onPressed: () {
              Auth.logout(context);
            },
          ),
        ],
      ),
    );
  }
}
