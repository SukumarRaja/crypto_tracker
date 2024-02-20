import 'dart:convert';

import '../../config/config.dart';
import '../../services/api.dart';
import '../../services/http_services.dart';

class CoinRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> getCoinsMarket({params}) async {
    var response = await helper.get(
        url: "${AppConfig.baseUrl}${ApiService.gteCoinsMarket}?$params");
    var res = jsonDecode(response);
    return res;
  }
}
