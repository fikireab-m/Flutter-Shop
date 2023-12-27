import 'dart:convert';
import 'dart:developer';
import 'package:flutter_shop/constants/api_constants.dart';
import 'package:flutter_shop/models/category.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:http/http.dart' as http;

class APIHandler {
  static Future<List<Product>> getProducts({required String limit}) async {
    List<Product> products = [];
    try {
      var uri = Uri.https(baseUrl, "api/v1/products", {
        "offset": "0",
        "limit": limit,
      });
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

  static Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    try {
      var uri = Uri.https(baseUrl, "api/v1/categories");
      var response = await http.get(uri);
      final data = (jsonDecode(response.body)) as List;
      for (var element in data) {
        categories.add(Category.fromJson(element));
      }
      return categories;
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }
}
