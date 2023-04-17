import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:perfect_flatmate/services/data.dart';
import 'package:perfect_flatmate/util/swipe_item_builder.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:perfect_flatmate/widgets/swipe_card_widget.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeView extends StatefulWidget {
  const SwipeView({super.key});

  @override
  State<SwipeView> createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> 
{
  MatchEngine? matchEngine;
  Future<QuerySnapshot?>? queryRef;


  void doStuff()async
  {
    
    // debugPrint(queryRef.docs[0].get('name'));
    // var swipeItems = SwipeItemBuilder.userListToSwipeItems(queryRef.docs);
    // matchEngine = MatchEngine(swipeItems: swipeItems);
  }

  @override
  void initState()
  {
    // TODO: implement initState
    // doStuff();
    queryRef = DataHelper.getUserDataFromField("city", "Mumbai");
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
      
      return FutureBuilder(
        future: queryRef,
        builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot)
        {
          if(snapshot.hasData)
          {
            var swipeItems = SwipeItemBuilder.userListToSwipeItems(snapshot.data!.docs);
            matchEngine = MatchEngine(swipeItems: swipeItems);
            return Stack(
              children: [
                SwipeCards(
                matchEngine: matchEngine!,
                onStackFinished: () {},
                likeTag: Container(
                  child: Icon(
                    Icons.favorite, 
                    color: Colors.pinkAccent,
                    size: 50,
                    )),
                nopeTag: Container(
                  child: Icon(
                    Icons.cancel_outlined, 
                    color: Colors.black,
                    size: 50,
                    )),
                itemBuilder: (context, index) 
                {
                  var userData = swipeItems[index].content;
                  return Center(child: SwipeCardWidget(userData: userData,));
                },
                ),
                Align(
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
                              matchEngine!.currentItem?.nopeAction!();
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
                              matchEngine!.currentItem?.likeAction!();
                            },
                            ),
                        ],
                      ),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),
              ],
            );
          }
          else if(snapshot.hasError)
          {
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