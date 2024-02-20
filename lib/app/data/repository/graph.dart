import 'dart:convert';
import '../../config/config.dart';
import '../../services/http_services.dart';

class GraphRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> getGraph({params, id}) async {
    var response = await helper.get(
        url: "${AppConfig.baseUrl}coins/$id/market_chart?$params");
    var res = jsonDecode(response);
    return res;
  }
}
