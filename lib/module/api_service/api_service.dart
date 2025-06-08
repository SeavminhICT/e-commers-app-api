
import 'dart:convert';

import 'package:e_commers_app/module/model/category_model.dart';
import 'package:e_commers_app/module/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {


  Future<List<CategoryModel>> getCategoryList() async {
    try {
      final url = "https://api.escuelajs.co/api/v1/categories";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return compute(categoryModelFromJson, res.body);
      } else {
        throw Exception("Error code: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
  
  Future<List<ProductModel>> getProductList() async {
    try {
      final url = "https://fakestoreapi.com/products";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return compute(productModelFromJson, res.body);
      } else {
        throw Exception("Error code: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }


}
