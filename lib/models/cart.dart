import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';

class CartModel with ChangeNotifier {
  final List<Product> _cartItems = [];

  get getCartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }
}
