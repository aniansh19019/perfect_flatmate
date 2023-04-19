import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:perfect_flatmate/widgets/list_tile.dart';

class MainListView extends StatefulWidget {
  final List<dynamic> swipeItems;
  const MainListView({super.key, required this.swipeItems});

  @override
  State<MainListView> createState() => _ListViewState();
}

class _ListViewState extends State<MainListView> {
  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder(itemBuilder: (context, i)
    {
      ListTile(
     
      );
    });
  }
}