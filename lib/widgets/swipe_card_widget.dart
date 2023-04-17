import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:perfect_flatmate/util/theme.dart';

class SwipeCardWidget extends StatefulWidget 
{
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
      child: Column(
              children: [
                Text(widget.userData.get("name",), style: CustomTheme.h1,)
              ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: CustomTheme.body,),
          const SizedBox(height: 4,),
          Text(value, style: CustomTheme.h1,)
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
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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