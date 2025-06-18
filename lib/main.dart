import 'package:e_commers_app/global_binding/api_binding.dart';
import 'package:e_commers_app/module/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // <-- Make sure to import this

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialBinding: APIBinding(), // Now valid
    );
  }
}
