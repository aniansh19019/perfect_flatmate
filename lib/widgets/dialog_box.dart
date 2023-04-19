import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:perfect_flatmate/widgets/image_avatar.dart';

class TimedDialog extends StatelessWidget 
{
  const TimedDialog({super.key, required this.icon, required this.title, required this.content});

  final Widget icon;
  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) 
  {
    Future.delayed(Duration(milliseconds: 2500), (){Navigator.of(context).pop();});
    return AlertDialog(

      icon: icon,
      title: title,
      content: content,
    );
  }
}

class MatchDialog extends StatelessWidget 
{
  final QueryDocumentSnapshot userData;
  const MatchDialog({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return TimedDialog(icon:ImageAvatar(imageUri: userData.get('image'), radius: 40,) , title: Icon(Icons.accessibility_new, color: CustomTheme.primaryPink, size: 40,), content:Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("You matched with ${userData.get('name')}!", style: CustomTheme.h2,),
        Text(userData.get('about'), style: CustomTheme.body,),
      ],
    ) );
  }
}