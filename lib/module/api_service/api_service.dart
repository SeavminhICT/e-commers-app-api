
import 'dart:convert';

import 'package:e_commers_app/module/model/image_banners_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ProductModel>> getProductList() async {
    try {
      final url = "https://api.escuelajs.co/api/v1/products";
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
