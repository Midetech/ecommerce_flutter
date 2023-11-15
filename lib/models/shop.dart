// import 'package:ecommerce_app_flutter/models/product.dart';
import 'package:ecommerce_app_flutter/models/product.dart';
import 'package:ecommerce_app_flutter/models/product_list.dart';
import 'package:ecommerce_app_flutter/services/products.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  final List<Product> _shop = [
    // Product(
    //   title: 'Product 1',
    //   price: 59.99,
    //   description: 'Lorem ipsum here',
    // ),
    // Product(
    //   title: 'Product 2',
    //   price: 59.99,
    //   description: 'Lorem ipsum herekskssk',
    // ),
    // Product(
    //   title: 'Product 3',
    //   price: 59.99,
    //   description: 'Lorem ipsum here',
    // ),
    // Product(
    //   title: 'Product 4',
    //   price: 59.99,
    //   description: 'Lorem ipsum here',
    // )
  ];
  List<dynamic> _products = [];
  List<Product> _cart = [];

  List<Product> get shop => _shop;

  List<Product> get cart => _cart;

  List<dynamic> get products => _products;

  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }
}
