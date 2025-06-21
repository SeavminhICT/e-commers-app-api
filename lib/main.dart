import 'package:e_commers_app/global_binding/api_binding.dart';
import 'package:e_commers_app/module/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // <-- Make sure to import this
import 'package:e_commers_app/module/app.dart'; // Import your App widget
import 'package:provider/provider.dart';
import 'module/langauge_logic.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguageLogic(),
      child: GetMaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        initialBinding: APIBinding(), // Now valid
      ),
    );
  }
}
