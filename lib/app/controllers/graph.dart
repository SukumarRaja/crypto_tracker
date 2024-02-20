import 'package:crypto_app/app/data/models/graph.dart';
import 'package:crypto_app/app/data/repository/graph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main.dart';

class GraphController extends GetxController {
  static GraphController get to => Get.put(GraphController());
  final graphRepository = GraphRepository();

  final _graphData = <GraphModel>[].obs;

  get graphData => _graphData.value;

  set graphData(value) {
    _graphData.value = value;
  }

  final _loading = false.obs;

  get loading => _loading.value;

  set loading(value) {
    _loading.value = value;
  }

  final _selectedTimePeriodIndex = 0.obs;

  get selectedTimePeriodIndex => _selectedTimePeriodIndex.value;

  set selectedTimePeriodIndex(value) {
    _selectedTimePeriodIndex.value = value;
  }

  final _timePeriod = "1".obs;

  get timePeriod => _timePeriod.value;

  set timePeriod(value) {
    _timePeriod.value = value;
  }

  getGraphData({id}) async {
    loading = true;
    var params = "vs_currency=inr&days=$timePeriod";
    try {
      var res = await graphRepository.getGraph(params: params, id: id);
      if (statusCode == 200) {
        debugPrint("Successfully get graph $statusCode");
        loading = false;
        List<GraphModel> temp = [];
        for (var sep in res['prices']) {
          GraphModel model = GraphModel.fromList(sep);
          temp.add(model);
        }
        graphData = temp;
      } else {
        debugPrint("Failed get graph $statusCode");
        loading = false;
        graphData = [];
      }
    } catch (e) {
      loading = false;
      debugPrint("Error on get coins market\n $e");
    }
  }
}
