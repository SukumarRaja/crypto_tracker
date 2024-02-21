import 'package:crypto_app/app/controllers/coin.dart';
import 'package:crypto_app/app/controllers/graph.dart';
import 'package:crypto_app/app/controllers/main.dart';
import 'package:crypto_app/app/data/models/graph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoDetail extends StatelessWidget {
  CryptoDetail({super.key, required this.id});

  final String id;

  List<dynamic> timePeriod = [
    {"unique_id": 1, "name": "1D"},
    {"unique_id": 5, "name": "5D"},
    {"unique_id": 30, "name": "1M"},
    {"unique_id": 364, "name": "1Y"},
  ];

  List<dynamic> title = [
    {"unique_id": 1, "name": "% change 24HR"},
    {"unique_id": 2, "name": "\u20B9 change 24HR"},
    {"unique_id": 3, "name": "Price"},
    {"unique_id": 4, "name": "Market Cap"},
    {"unique_id": 5, "name": "24HR Low"},
    {"unique_id": 6, "name": "24HR High"},
    {"unique_id": 7, "name": "ATL"},
    {"unique_id": 8, "name": "ATH"},
  ];

  TrackballBehavior trackballBehavior = TrackballBehavior(enable: true);
  CrosshairBehavior crosshairBehavior = CrosshairBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CoinController(),
        initState: (_) {
          CoinController.to.fetchCryptoById(id: id);
          GraphController.to.getGraphData(id: id);
        },
        builder: (controller) {
          List<dynamic> data = [
            {
              "unique_id": 1,
              "name":
                  "${controller.cryptoDetail['price_change_percentage_24h'].toStringAsFixed(2)}"
            },
            {
              "unique_id": 2,
              "name":
                  "\u20B9 ${controller.cryptoDetail['price_change_24h'].toStringAsFixed(2)}"
            },
            {
              "unique_id": 3,
              "name":
                  "${controller.cryptoDetail['current_price'].toStringAsFixed(2)}"
            },
            {
              "unique_id": 4,
              "name":
                  "${controller.cryptoDetail['market_cap'].toStringAsFixed(2)}"
            },
            {
              "unique_id": 5,
              "name": "${controller.cryptoDetail['low_24h'].toStringAsFixed(2)}"
            },
            {
              "unique_id": 6,
              "name":
                  "${controller.cryptoDetail['high_24h'].toStringAsFixed(2)}"
            },
            {
              "unique_id": 7,
              "name": "${controller.cryptoDetail['atl'].toStringAsFixed(2)}"
            },
            {
              "unique_id": 8,
              "name": "${controller.cryptoDetail['ath'].toStringAsFixed(2)}"
            },
          ];
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                actions: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      MainController.to.updateWishList(id: id);
                    },
                    icon: Obx(() => Icon(MainController.to.wishList
                            .where((element) => element['id'] == id)
                            .isNotEmpty
                        ? Icons.bookmark
                        : Icons.bookmark_border)),
                  ),
                ],
                title: Row(
                  children: [
                    CircleAvatar(
                      child: Image.network(controller.cryptoDetail['image']),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      controller.cryptoDetail['id'],
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              body: Obx(
                () => controller.loading
                    ? SizedBox(
                        height: 3.h,
                        width: 3.h,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ))
                    : ListView(
                        children: [
                          buildChart(context),
                          SizedBox(height: 2.h),
                          GridView.builder(
                              itemCount: 8,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 2.h),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 2.h,
                                      childAspectRatio: 2.8,
                                      crossAxisSpacing: 2.h),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: index % 2 == 0
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${title[index]['name']}",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      "${data[index]['name']}",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.white38,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                );
                              })
                        ],
                      ),
              ));
        });
  }

  buildChart(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25.h,
          width: MediaQuery.of(context).size.width,
          child: SfCartesianChart(
            trackballBehavior: trackballBehavior,
            crosshairBehavior: crosshairBehavior,
            primaryXAxis: const DateTimeAxis(
              isVisible: true,
              borderColor: Colors.transparent,
            ),
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.compact(),
              isVisible: true,
            ),
            plotAreaBorderWidth: 0,
            series: [
              AreaSeries<GraphModel, dynamic>(
                dataSource: GraphController.to.graphData,
                xValueMapper: (GraphModel model, index) => model.date,
                yValueMapper: (GraphModel model, index) => model.price,
                enableTooltip: true,
                color: Colors.transparent,
                borderColor: const Color(0xff1ab7c3),
              )
            ],
          ),
        ),
        SizedBox(height: 3.h),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 5.h,
            child: ListView.builder(
                itemCount: timePeriod.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return buildDays(index);
                }),
          ),
        )
      ],
    );
  }

  buildDays(int index) {
    return Obx(() => GestureDetector(
          onTap: () {
            GraphController.to.selectedTimePeriodIndex = index;
            GraphController.to.timePeriod = "${timePeriod[index]['unique_id']}";
            GraphController.to.getGraphData(id: id);
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: GraphController.to.selectedTimePeriodIndex == index
                    ? Colors.grey.shade800
                    : Colors.transparent,
                border: Border.all(
                    color: GraphController.to.selectedTimePeriodIndex == index
                        ? Colors.grey.shade200
                        : Colors.grey.shade700)),
            child: Text(
              "${timePeriod[index]['name']}",
              style: TextStyle(
                  color: GraphController.to.selectedTimePeriodIndex == index
                      ? Colors.white
                      : Colors.grey.shade600,
                  letterSpacing: 1,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }
}
