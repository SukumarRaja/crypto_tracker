import 'package:crypto_app/app/controllers/coin.dart';
import 'package:crypto_app/app/controllers/main.dart';
import 'package:crypto_app/app/ui/pages/crypto_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/graph.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MainController(),
        initState: (_) {
          MainController.to.fetchWishList();
        },
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                children: [
                  Obx(
                    () => controller.wishList.isEmpty
                        ? const Text("Empty")
                        : ListView.builder(
                            itemCount: controller.wishList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = controller.wishList[index];
                              return ListTile(
                                onTap: () {
                                  Get.to(() => CryptoDetail(id: data['id']));
                                },
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  child: Image.network(
                                    data['image'],
                                    errorBuilder:
                                        (context, exception, stackTrack) =>
                                            const Icon(
                                      Icons.error,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "${data['name']}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(
                                  data['current_price'].toStringAsFixed(2),
                                  style: TextStyle(
                                      color: data['price_change_24h'] > 0
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
