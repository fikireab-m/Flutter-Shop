import 'dart:convert';
import 'dart:developer';

import 'package:flutter_shop/models/product.dart';
import 'package:http/http.dart' as http;

class APIHandler {
  static Future<List<Product>> getProducts() async {
    try {
      var uri = Uri.https("api.escuelajs.co", "api/v1/products");
      var response = await http.get(uri);

      // print("response ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
      }

      return Product.productsFromSnapshot(tempList);
    } catch (error) {
      log("An error occured $error");
      throw error.toString();
    }
  }
}
