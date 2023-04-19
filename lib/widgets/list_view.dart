import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:perfect_flatmate/util/timestamp_to_age.dart';
import 'package:perfect_flatmate/widgets/image_avatar.dart';
import 'package:perfect_flatmate/widgets/list_tile.dart';
import 'package:perfect_flatmate/widgets/swipe_card_widget.dart';

class MainListView extends StatefulWidget {
  final List<dynamic> swipeItems;
  const MainListView({super.key, required this.swipeItems});

  @override
  State<MainListView> createState() => _MainListViewState();
}

class _MainListViewState extends State<MainListView> {
  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder(
      itemCount: widget.swipeItems.length,
      itemBuilder: (context, i)
    {
      var currentItem = widget.swipeItems[i].content;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          
          leading: ImageAvatar(
            imageUri: currentItem.get('image'),
            radius: 22,
          ),
          title: Text(currentItem.get('name')),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextLabelView(label: "Own Place", value: currentItem.get('has_place')?"Yes":"No"),
              VerticalDivider(width: 2, thickness: 2,),
              TextLabelView(label: "Age", value: AgeHelper.timestampToAge(currentItem.get('dob')),),

            ],
          ),
          subtitle: Text(currentItem.get('city')),
          shape:RoundedRectangleBorder(
            
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                width: 2
              )
            ),
          tileColor: Color(0xFFFFF8F9),
          selectedTileColor: CustomTheme.primaryPink,
        
          onTap: ()
          {
        
          },
        ),
      );
    });
  }
}