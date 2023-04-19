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
  Widget build(BuildContext context) {
    swipeItemsFuture = DataHelper.getLikes();
    return Scaffold(
      appBar: AppBar(title: Text("Likes")),
      body: Container(
      child: SwipeView(swipeItemsFuture: swipeItemsFuture!,)
    ),
    );
  }
}