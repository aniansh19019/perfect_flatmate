import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_flatmate/pages/messaging.dart';
import 'package:perfect_flatmate/util/theme.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> arrMatches = [
      {
        'title': 'Mansi',
        'image': 'https://picsum.photos/id/1/200/200',
      },
      {
        'title': 'Shanaya',
        'image': 'https://picsum.photos/id/2/200/200',
      },
      {
        'title': 'Naira',
        'image': 'https://picsum.photos/id/3/200/200',
      },
    ];
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Matches"),
        ),
        body: ListView.separated(
          itemCount: arrMatches.length,
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 2,
            );
          },
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(arrMatches[index]['image']),
              ),
              title: Text(
                arrMatches[index]['title'],
                style: CustomTheme.h1,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Messaging(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
