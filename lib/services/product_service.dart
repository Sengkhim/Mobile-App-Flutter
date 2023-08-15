import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tast/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final url = "https://fakestoreapi.com/products";

  ///present for get all product
  Future<List<ProductModel>> getAllProduct() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      });
      if (response.statusCode == 200) {
        //working
        final data = json.decode(response.body) as List;
        List<ProductModel> products =
            data.map((e) => ProductModel.fromJson(e)).toList();
        return products;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getAllCategoies() async {
    try {
      final response = await http.get(
          Uri.parse("https://fakestoreapi.com/products/categories"),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json"
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  ///fetch product by category
  Future<List<ProductModel>> getProductByCate({String? categories}) async {
    try {
      final response = await http.get(
          Uri.parse("https://fakestoreapi.com/products/category/$categories"),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json"
          });
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        List<ProductModel> products =
            data.map((e) => ProductModel.fromJson(e)).toList();
        return products;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
