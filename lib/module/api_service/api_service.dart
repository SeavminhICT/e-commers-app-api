import 'dart:convert';
import 'dart:io';
import 'package:e_commers_app/constant/constants.dart';
import 'package:e_commers_app/module/model/category_model.dart';
import 'package:e_commers_app/module/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p; // For basename


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

  
  // Update user profile
  Future<Map<String, dynamic>> updateUserProfile({
    required String token,
    required String name,
    File? avatarFile,
  }) async {
    final Dio dio = Dio();
    String updateUrl = '$baseUrl/profile/update'; // Corrected backend update endpoint

    Map<String, dynamic> formDataMap = {
      'name': name,
    };

    if (avatarFile != null) {
      formDataMap['avatar'] = await MultipartFile.fromFile(
        avatarFile.path,
        filename: p.basename(avatarFile.path),
      );
    }

    FormData formData = FormData.fromMap(formDataMap);

    try {
      final response = await dio.post(
        updateUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data; // Dio decodes JSON by default
        Map<String, dynamic> user = data['user'];
        // Ensure avatar URL is correctly formed if backend returns a path
        if (user['avatar'] != null && !user['avatar'].startsWith('http')) {
          user['avatar'] = '${baseUrl.replaceAll("/api", "")}/storage/${user['avatar']}';
        }
        return user;
      } else {
        throw Exception(
            'Failed to update profile. Status code: ${response.statusCode}, Response: ${response.data}');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data?['message'] ?? e.message;
      throw Exception('Failed to update profile: $errorMsg');
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
     // Change user password
  Future<Map<String, dynamic>> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final Dio dio = Dio();
    String changePasswordUrl = '$baseUrl/change-password'; // Your backend change password endpoint

    try {
      final response = await dio.post(
        changePasswordUrl,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>; // Expecting a success message
      } else {
        throw Exception(
            'Failed to change password. Status code: ${response.statusCode}, Response: ${response.data}');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data?['message'] ?? e.message;
      throw Exception('Failed to change password: $errorMsg');
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  } 
}
