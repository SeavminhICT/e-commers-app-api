import 'dart:convert';
import 'package:e_commers_app/constant/constants.dart';
import 'package:e_commers_app/module/model/category_model.dart';
import 'package:e_commers_app/module/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<CategoryModel> getCategoryList() async {
    final response = await http.get(Uri.parse('$kBaseUrl/categories'));
    if (response.statusCode == 200) {
      return categoryModelFromJson(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<ProductsModel> getProductsList() async {
    final response = await http.get(Uri.parse('$kBaseUrl/products'));
    if (response.statusCode == 200) {
      return productsModelFromJson(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<bool> addToCart({
    required int productId,
    required int quantity,
    required String authToken,
    required double price, 
  }) async {
    final url = Uri.parse('$kBaseUrl/cart');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({
        'product_id': productId,
        'quantity': quantity,
        'price': price, 
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
