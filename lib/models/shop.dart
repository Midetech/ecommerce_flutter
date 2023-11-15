import 'package:ecommerce_app_flutter/models/product.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  final List<Product> _products = [];
  final List<Product> _cart = [];

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
