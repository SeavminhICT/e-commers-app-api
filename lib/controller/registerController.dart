import 'dart:convert';
import 'dart:io';
import 'package:dio/src/response.dart';
import 'package:e_commers_app/data/model/provider/api_provider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  final _provider = Get.find<ApiProvider>();
  final _faker = Faker();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmPasswordController = TextEditingController();
  File? profileImg; // Optional

  @override
  void onInit() {
    // getGeneratedDataUser();
    super.onInit();
  }

  void pickImage() async {
    final XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      // Assign the picked image to profileImg
      profileImg = File(file.path);
      update(); // Notify listeners about the change
    }
  }

  // void getGeneratedDataUser() {
  //   namecontroller.text = _faker.person.name();
  //   emailcontroller.text = _faker.internet.email();
  //   passwordcontroller.text = "12345678";
  //   confirmPasswordController.text = "12345678";
  // }

  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _provider.register(
        name: name,
        email: email,
        password: password,
        image: profileImg,
      );

      if (response.statusCode == 200) {
        // Success dialog
        Get.dialog(
          Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 60),
                  SizedBox(height: 16),
                  Text('Success',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Text('Registration successful',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Get.back(); // Close dialog
                        Get.back(result: {
                          'email': email,
                          'password': password,
                        }); // Go back to previous screen with result
                      },
                      child: Text('Continue'),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else if (response.statusCode == 422) {
        // Email already exists
        final responseBody = response.data;
        if (responseBody['errors']?['email'] != null) {
          Get.snackbar('Error', responseBody['errors']['email'][0]);
        }
      } else if (response.statusCode == 200) {
        // Registration success logic
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      Get.defaultDialog(title: "Error", content: Text(e.toString()));
    }
  }
}
