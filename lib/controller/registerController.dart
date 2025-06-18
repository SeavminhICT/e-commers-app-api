import 'dart:io';
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
    getGeneratedDataUser();
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

  void getGeneratedDataUser() {
    namecontroller.text = _faker.person.name();
    emailcontroller.text = _faker.internet.email();
    passwordcontroller.text = "12345678";
    confirmPasswordController.text = "12345678";
  }

  void register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await _provider.register(
          name: name, email: email, password: password, image: profileImg);
      if (response.statusCode == 200) {
        // success
        Get.dialog(
          AlertDialog(
            title: const Text('Success'),
            content: const Text('Registration successful'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back(result: {
                    'email': email,
                    'password': password,
                  });
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      Get.defaultDialog(title: "Error", content: Text("${e.toString()}"));
    }
  }
}
