import 'package:e_commers_app/global_binding/api_binding.dart';
import 'package:e_commers_app/module/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // <-- Make sure to import this
import 'package:e_commers_app/module/app.dart'; // Import your App widget
void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialBinding: APIBinding(), // Now valid
    );
  }
}
