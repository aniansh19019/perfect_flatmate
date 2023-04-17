import 'package:swipe_cards/swipe_cards.dart';

class SwipeItemBuilder
{
  static List<SwipeItem> userListToSwipeItems(List<dynamic>  userList)
  {
    List<SwipeItem> swipeItems = List.empty(growable: true);
    for (dynamic userData in userList)
    {
      swipeItems.add(
        SwipeItem(
          content: userData,
          likeAction: (){},
          nopeAction: (){},
          superlikeAction: (){},

        )
      );
    }
    return swipeItems;
  }
}