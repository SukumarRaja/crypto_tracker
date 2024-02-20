import 'package:crypto_app/app/controllers/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../data/repository/coins.dart';

class CoinController extends GetxController {
  static CoinController get to => Get.put(CoinController());

  final coinRepository = CoinRepository();

  final _coinsData = <dynamic>[].obs;

  get coinsData => _coinsData.value;

  set coinsData(value) {
    _coinsData.value = value;
  }

  final _loading = false.obs;

  get loading => _loading.value;

  set loading(value) {
    _loading.value = value;
  }

  final _cryptoDetail = {}.obs;

  get cryptoDetail => _cryptoDetail.value;

  set cryptoDetail(value) {
    _cryptoDetail.value = value;
  }

  getCoinsMarket() async {
    loading = true;
    var params =
        "vs_currency=inr&order=market_cap_desc&per_page=30&page=1&sparkline=false&locale=en";
    try {
      var res = await coinRepository.getCoinsMarket(params: params);
      if (statusCode == 200) {
        debugPrint("Successfully get coins $statusCode");
        debugPrint("data is $res");
        loading = false;
        coinsData = res;
      } else {
        debugPrint("Failed get coins $statusCode");
        loading = false;
        coinsData = [];
      }
    } catch (e) {
      loading = false;
      debugPrint("Error on get coins market\n $e");
    }
  }

  fetchCryptoById({id}) {
    cryptoDetail = coinsData.where((e) => e['id'] == id).toList()[0];
    debugPrint("fetch data is $cryptoDetail");
  }
}
