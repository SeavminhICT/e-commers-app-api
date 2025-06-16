import 'dart:convert';

import 'package:e_commers_app/module/model/productfav.dart';
import 'package:e_commers_app/module/model/productmyorder_model.dart';
import 'package:http/http.dart' as http;



class ApiMyorder {

  Future<List<ProductModel>> getProductsmyorder() async {
 final url = "https://fakestoreapi.com/products";
    try {
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return  productModelFromJson(res.body);
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
