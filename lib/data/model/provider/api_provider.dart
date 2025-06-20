import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_commers_app/constant/constants.dart';
import 'package:e_commers_app/service/storage_service.dart';

class ApiProvider {
  final _dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      contentType: 'application/json',
      responseType: ResponseType.json,
      receiveTimeout: Duration(seconds: 60),
      validateStatus: (status) {
        return status! <
            500; // Accept all responses with status code less than 500
      },
    ),
  );

  Future<Response> register(
      {required String name,
      required String email,
      required String password,
      File? image}) async {
    try {
      // print("image ${image!.path}");
      final _formData = FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'avatar':
            image != null ? await MultipartFile.fromFile(image.path) : null,
      });

      return await _dio.post("/register", data: _formData);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      final _formData = FormData.fromMap({
        'email': email,
        'password': password,
      });

      return await _dio.post("/login", data: _formData);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getCartProducts() async {
    try {
      return await _dio.get(
        "/viewCart",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                'Bearer ${await StorageService.read(key: 'token')}',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addToCart(
      {required int productId,
      required int quantity,
      required num price}) async {
    try {
      return await _dio.post(
        '/cart',
        data: {
          'product_id': productId,
          'quantity': quantity,
          'price': price,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                'Bearer ${await StorageService.read(key: 'token')}',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
