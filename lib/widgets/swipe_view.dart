import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:perfect_flatmate/services/data.dart';
import 'package:perfect_flatmate/util/swipe_item_builder.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:perfect_flatmate/widgets/list_view.dart';
import 'package:perfect_flatmate/widgets/swipe_card_widget.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeView extends StatefulWidget 
{
  final Future<List<SwipeItem>?> swipeItemsFuture;
  const SwipeView({super.key, required this.swipeItemsFuture});

  @override
  State<SwipeView> createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> 
{
  MatchEngine? matchEngine;
  bool listView = false;


  void switchToListView()
  {
    setState(() {
      listView = true;
      // var swipeItems = matchEng
    });
  }

  void switchToSwipeView(int index)
  {
    setState(() {
      listView = false;
    });
  }

  @override
  Widget build(BuildContext context) 
  {
      
      return FutureBuilder(
        future: widget.swipeItemsFuture,
        builder: (context, AsyncSnapshot<List<SwipeItem>?> snapshot)
        {
          if(snapshot.hasData)
          {
            var swipeItems = snapshot.data!;
            matchEngine = MatchEngine(swipeItems: swipeItems);
            return Stack(
              children: [
                Visibility(
                  visible: listView,
                  child: MainListView(swipeItems: swipeItems, viewToggleCallback: switchToSwipeView,)),
                Visibility(
                  visible: !listView,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.no_accounts_outlined, size: 40,),
                        SizedBox(height: 12,),
                        Text("No More Entries Left!", style:CustomTheme.h1),
                      ],
                    )),
                ),
                Visibility(
                  visible: !listView,
                  child: SwipeCards(
                    upSwipeAllowed: false,
                  matchEngine: matchEngine!,
                  onStackFinished: () 
                  {
                    // isStackEmpty
                  },
                  likeTag: Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.favorite, 
                      color: Colors.pinkAccent.withAlpha(128),
                      size: 160,
                      )),
                  nopeTag: Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.cancel_rounded, 
                      color: Colors.black.withAlpha(128),
                      size: 160,
                      )),
                  itemBuilder: (context, index) 
                  {
                    var userData = swipeItems[index].content;
                    return Center(child: SwipeCardWidget(userData: userData,));
                  },
                  ),
                ),
                Visibility(
                  visible: !listView,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(CircleBorder()),
                                  backgroundColor: MaterialStateProperty.all(Colors.white)
                                ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(Icons.cancel, size: 30, color: Color(0xFF8E8E93),),
                              ),
                              onPressed: () {
                                matchEngine!.currentItem?.nope();
                              },
                              ),
                              SizedBox(width: 20,),
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(CircleBorder()),
                                  backgroundColor: MaterialStateProperty.all(Colors.white)
                                ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(Icons.favorite, size: 30, color: Color(0xFFFF375F),),
                              ),
                              onPressed: () {
                                matchEngine!.currentItem?.like();
                              },
                              ),
                          ],
                        ),
                        SizedBox(height: 50,),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !listView,
                  child: Align(
                    alignment: Alignment.bottomCenter ,
                    // widthFactor: 0.2,
                    child: GestureDetector(
                      onVerticalDragStart: (details) 
                      {
                        debugPrint(details.globalPosition.toString());
                      },
                      onVerticalDragUpdate: (details)
                      {
                        debugPrint(details.delta.direction.toString());
                      },
                      onVerticalDragEnd: (details) 
                      {
                        debugPrint(details.primaryVelocity?.sign.toString());
                        if(details.primaryVelocity!.sign < 0)
                        {
                          setState(() {
                            switchToListView();
                          });
                        }
                      },
                      child: SizedBox(
                        width: 60,
                        child: Divider(thickness: 7, )),
                    ),
                  ),
                )
              ],
            );
          }
          else if(snapshot.hasError)
          {
            debugPrint(snapshot.error.toString());
            return Center(child:Text("Error"));
          }
          else
          {
            return Center(child: CircularProgressIndicator());
          }
        }
      );
    
    
  }
}