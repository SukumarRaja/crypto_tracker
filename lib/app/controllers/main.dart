import 'package:crypto_app/app/controllers/coin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../data/repository/wish_list.dart';

int statusCode = 0;

class MainController extends GetxController {
  static MainController get to => Get.put(MainController());

  final wishListRepository = WishListRepository();

  final _wishList = <dynamic>[].obs;

  get wishList => _wishList.value;

  set wishList(value) {
    _wishList.value = value;
  }

  getWishList() async {
    try {
      wishList = await wishListRepository.getWishList();
      if (wishList.isEmpty) {
        debugPrint("Wishlist is empty");
      } else {
        debugPrint("Wishlist is $wishList");
      }
    } catch (e) {
      debugPrint("Error or get wish list");
    }
  }

  updateWishList({id}) async {
    var wishList = await wishListRepository.getWishList();
    if (wishList.contains(id)) {
      wishList.remove(id);
      await wishListRepository.removeWishList(id: id);
      Get.back();
      Fluttertoast.showToast(
          msg: "Removed from wishlist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      fetchWishList();
      debugPrint("Removed wish list $id");
    } else {
      wishList.add(id);
      await wishListRepository.addWishList(id: id);
      Get.back();
      Fluttertoast.showToast(
          msg: "Added to wishlist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      fetchWishList();
      debugPrint("Added wish list $id");
    }
  }

  fetchWishList() async {
    List<dynamic> data = CoinController.to.coinsData;
    var coinIds = await wishListRepository.getWishList();
    debugPrint("Coin ids: $coinIds");
    List<dynamic> temp = [];
    for (var i = 0; i < coinIds.length; i++) {
      temp.addAll(data.where((row) => (row["id"].contains("${coinIds[i]}"))));
    }
    debugPrint("Wishlist is: ${temp.length}");
    wishList = temp;
  }
}
