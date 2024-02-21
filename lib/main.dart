import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'app/ui/pages/crypto_coins.dart';
import 'app/ui/pages/wish_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Hello 👋",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                bottom: const TabBar(
                  padding: EdgeInsets.zero,
                  tabs: [
                    Tab(text: "Market"),
                    Tab(text: "Wishlist"),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [CryptoCoins(), WishList()],
              ),
            ),
          ));
    });
  }
}
