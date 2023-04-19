import 'package:perfect_flatmate/services/data.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeItemBuilder
{
  

  static List<SwipeItem> userListToSwipeItems(List<dynamic>  userList, context)
  {
    List<SwipeItem> swipeItems = List.empty(growable: true);
    for (dynamic userData in userList)
    {
      swipeItems.add(
        SwipeItem(
          content: userData,
          likeAction: ()
          {
            DataHelper.submitLike(userData.get('email'), context);
          },
          nopeAction: ()
          {
            DataHelper.submitDislike(userData.get('email'));
          },
          superlikeAction: (){},

        )
      );
    }
    return swipeItems;
  }
}