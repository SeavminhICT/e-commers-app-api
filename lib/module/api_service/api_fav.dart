import 'dart:convert';
import 'package:e_commers_app/module/model/productfav_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiFav {
    
  Future<List<ProductFavModel>> getProductfav() async {
    final url = "https://fakestoreapi.com/products";
    try {
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return  productFavModelFromJson(res.body);
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
