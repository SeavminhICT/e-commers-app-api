import 'dart:convert';

import 'package:e_commers_app/data/model/provider/api_provider.dart';
import 'package:e_commers_app/module/home_screen.dart';
import 'package:e_commers_app/module/main_screen.dart';
import 'package:e_commers_app/module/model/product_model_test.dart';
import 'package:e_commers_app/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final _provider = Get.find<ApiProvider>();
  var isLoading = false.obs; // 👈 Add this line

  void login({required String email, required String password}) async {
    isLoading.value = true; // 👈 Start loading

    try {
      final response = await _provider.login(email: email, password: password);
      if (response.statusCode == 200) {
        final token = response.data['token'];
        StorageService.write(key: 'token', value: token);
        Map<String, dynamic> user = response.data['user'];
        StorageService.write(key: 'user', value: jsonEncode(user));

        Get.offAll(() => MainScreen());
      } else {
        Get.defaultDialog(
          title: "Error",
          content: Text("Failed to login"),
        );
      }
    } catch (e) {
      Get.defaultDialog(title: "Error", content: Text(e.toString()));
    } finally {
      isLoading.value = false; // 👈 Stop loading
    }
  }

  List<ProductModel> favoriteProducts = [];
}
