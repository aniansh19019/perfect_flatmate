import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:perfect_flatmate/util/theme.dart';

class SwipeCardWidget extends StatefulWidget 
{
  static const double spacing = 8;
  static const Map<String, dynamic> dietMap = {
    "veg" : "Vegetarian",
    "non_veg" : "Non Vegetarian",
    "vegan" : "Vegan"
  };
  final QueryDocumentSnapshot userData;
  const SwipeCardWidget({super.key, required this.userData});

  @override
  State<SwipeCardWidget> createState() => _SwipeCardWidgetState();
}

class _SwipeCardWidgetState extends State<SwipeCardWidget> 
{
  @override
  Widget build(BuildContext context) {
    return CardHolder(
      color: Color(0xFFFFF8F9) ,
      child: SingleChildScrollView(
        child: Column(
                children: [
                  SizedBox(height: 20,),
                  CircleAvatar(radius: 70,),
                  SizedBox(height: 12,),
                  Text(widget.userData.get("name",), style: CustomTheme.h1,),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "Location", value: widget.userData.get('city')),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "Age", value: widget.userData.get('dob')),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "Has Place", value: widget.userData.get('has_place')?"Yes":"No"),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "Gender", value: widget.userData.get('gender')),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "About", value: widget.userData.get('about')),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "Employment", value: widget.userData.get('employment')),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "Alcohol", value: widget.userData.get('alcohol')?"Yes":"No"),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "Smoking", value: widget.userData.get('smoking')?"Yes":"No"),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "Dietary Preferences", value: SwipeCardWidget.dietMap[widget.userData.get('diet')]),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "Personality Type", value: widget.userData.get('introvert')?"Introvert":"Extrovert"),
                  SizedBox(height: SwipeCardWidget.spacing,),
                  TextLabelView(label: "Pets", value: widget.userData.get('pets')?"Yes":"No"),
                  SizedBox(height: 70,),
                  
                  

      
                ],
              ),
      ),
      );
  }
}

class TextLabelView extends StatelessWidget 
{
  final String label;
  final String value;
  const TextLabelView({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: CustomTheme.body, textAlign: TextAlign.center,),
          const SizedBox(height: 4,),
          Text(value, style: CustomTheme.h3,)
        ],
      ),
    );
  }
}


class CardHolder extends StatelessWidget 
{
  final Widget child;
  final Color color;
  const CardHolder({super.key, required this.child, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Card(
          elevation: 10,
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child
          ),
        ),
      ),
    );
  }
}