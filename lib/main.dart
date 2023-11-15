import 'package:ecommerce_app_flutter/pages/cart_page.dart';
import 'package:ecommerce_app_flutter/pages/intro_page.dart';
import 'package:ecommerce_app_flutter/pages/shop_page.dart';
import 'package:ecommerce_app_flutter/themes/light_mode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: const IntroPage(),
      routes: {
        '/intro_page': (context) => const IntroPage(),
        '/shop_page': (context) => const ShopPage(),
        '/cart': (context) => const CartPage()
      },
    );
  }
}
