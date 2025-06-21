import 'package:e_commers_app/module/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_logic.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => LanguageLogic(),
        child: MainScreen(),
      ),
    );
  }
}
