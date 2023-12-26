import 'dart:convert';
import 'dart:developer';

import 'package:flutter_shop/models/product.dart';
import 'package:http/http.dart' as http;

class APIHandler {
  static Future<List<Product>> getProducts() async {
    List<Product> products = [];
    try {
      var uri = Uri.https("api.escuelajs.co", "api/v1/products");
      var response = await http.get(uri);
      final data = (jsonDecode(response.body)) as List;
      for (var element in data) {
        products.add(Product.fromJson(element));
      }
      return products;
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }
}
