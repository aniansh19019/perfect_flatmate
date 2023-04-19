import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_flatmate/pages/messaging.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:perfect_flatmate/widgets/image_avatar.dart';
import '../services/data.dart';
import 'package:perfect_flatmate/services/auth.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  Future<List<Map<String, dynamic>>>? matches;

  String? currentUser;
  @override
  void initState() {
    // TODO: implement initState
    matches = DataHelper.getMatches();
    currentUser = Auth.getCurrentUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Matches"),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: matches,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  thickness: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final item = snapshot.data[index];
                  return ListTile(
                    leading: ImageAvatar(imageUri: item['image']),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: CustomTheme.h1,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Messaging(
                            otherEmail: item['email'],
                            otherName: item['title'],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
