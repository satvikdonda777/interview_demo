import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class HomeRepository {
  Future<ProductModel?> getAllProducts(BuildContext context) async {
    try {
      String url = "https://dummyjson.com/products";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        ProductModel productModel =
            ProductModel.fromJson(jsonDecode(response.body));

        return productModel;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return null;
  }
}
