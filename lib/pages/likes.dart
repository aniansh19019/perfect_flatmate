import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text("Likes"),
        ElevatedButton(onPressed: (){}, child: Text("Show Likes"))

      ]),
    );
  }
}