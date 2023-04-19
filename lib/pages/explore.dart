import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_flatmate/services/data.dart';
import 'package:perfect_flatmate/test_pages/main.dart';
import 'package:perfect_flatmate/widgets/swipe_view.dart';
import 'package:swipe_cards/swipe_cards.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();

  
}

class _ExploreState extends State<Explore> 
{
  Future<List<SwipeItem>?>? swipeItemsFuture;

  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    swipeItemsFuture = DataHelper.getListings();
    return Container(
      child: SwipeView(swipeItemsFuture: swipeItemsFuture!,)
    );
  }
}