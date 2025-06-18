import 'dart:convert';
import 'package:e_commers_app/constant/constants.dart';
import 'package:e_commers_app/module/model/category_model.dart';
import 'package:e_commers_app/module/model/product_model.dart';
import 'package:http/http.dart' as http;

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


}
