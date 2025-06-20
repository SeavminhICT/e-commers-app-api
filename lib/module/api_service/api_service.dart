import 'dart:convert';
import 'package:e_commers_app/constant/constants.dart';
import 'package:e_commers_app/data/model/cart.res.model.dart';
import 'package:e_commers_app/module/model/category_model.dart';
import 'package:e_commers_app/module/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<CategoryModel> getCategoryList() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      return categoryModelFromJson(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<ProductsModel> getProductsList() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
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

  // Fetch cart items
  Future<CartResponse> getCart(String authToken) async {
    final response = await http.get(
      Uri.parse('$kBaseUrl/viewCart'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CartResponse.fromJson(data);
    } else {
      throw Exception(
          'Failed to fetch cart items with status ${response.statusCode}');
    }
  }



  // Login method to get auth token and user data
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data; // contains 'token' and 'user'
    } else {
      throw Exception('Failed to login');
    }
  }

  // Fetch user profile using token
  Future<Map<String, dynamic>> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['user'];
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }
}
