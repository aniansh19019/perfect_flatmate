import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ListView extends StatefulWidget {
  final List<dynamic> swipeItems;
  const ListView({super.key, required this.swipeItems});

  @override
  State<ListView> createState() => _ListViewState();
}

class _ListViewState extends State<ListView> {
  @override
  Widget build(BuildContext context) 
  {
    return Column();
  }
}