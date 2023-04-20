import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_flatmate/pages/messaging.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:perfect_flatmate/widgets/image_avatar.dart';
import '../services/data.dart';
import 'package:perfect_flatmate/services/auth.dart';

import '../util/timestamp_to_age.dart';
import '../widgets/swipe_card_widget.dart';

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
          centerTitle: true,
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
              if(snapshot.data.length == 0)
              {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          Icon(Icons.people,
                          size: 80,
                          ),
                          Text("Go to the explore page to find more matches!", style: CustomTheme.h2,)
                      ],
                    ),
                  ),
                );
              }
              return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  thickness: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final item = snapshot.data[index];
                   var currentItem = snapshot.data[index];
                   debugPrint(currentItem.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          
          leading: ImageAvatar(
            imageUri: currentItem['image'],
            radius: 22,
          ),
          title: Text(currentItem['title']),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextLabelView(label: "Own Place", value: currentItem['has_place']?"Yes":"No"),
              VerticalDivider(width: 2, thickness: 2,),
              TextLabelView(label: "Age", value: AgeHelper.timestampToAge(currentItem['dob']),),

            ],
          ),
          subtitle: Text(currentItem['city']),
          shape:RoundedRectangleBorder(
            
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                width: 2,
                color: Colors.grey[300]!
              )
            ),
          tileColor: Color(0xFFFFF8F9),
          selectedTileColor: CustomTheme.primaryPink,
        
          onTap: ()
          {
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
        ),
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
