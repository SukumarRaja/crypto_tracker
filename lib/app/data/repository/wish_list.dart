import 'package:shared_preferences/shared_preferences.dart';

class WishListRepository {
  addWishList({id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> wishList = pref.getStringList("wishlist") ?? [];
    wishList.add(id);
    return await pref.setStringList("wishlist", wishList);
  }

  removeWishList({id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> wishList = pref.getStringList("wishlist") ?? [];
    wishList.remove(id);
    return await pref.setStringList("wishlist", wishList);
  }

  getWishList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList("wishlist") ?? [];
  }
}
