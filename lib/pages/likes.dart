import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../services/auth.dart';
import '../services/data.dart';
import '../widgets/swipe_view.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  Future<List<SwipeItem>?>? swipeItemsFuture;

  @override
  void initState() {
    // TODO: implement initState
    swipeItemsFuture = DataHelper.getLikes(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Likes")),
      body: Container(
      child: SwipeView(swipeItemsFuture: swipeItemsFuture!,)
    ),
    );
  }
}