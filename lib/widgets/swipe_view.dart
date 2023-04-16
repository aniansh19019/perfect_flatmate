import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeView extends StatefulWidget {
  const SwipeView({super.key});

  @override
  State<SwipeView> createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> 
{
  MatchEngine? matchEngine;

  @override
  Widget build(BuildContext context) {
    return SwipeCards(
      matchEngine: matchEngine!,
      onStackFinished: () {},
      itemBuilder: (context, index) 
      {
        return Text("Card $index");
      },
    );
  }
}