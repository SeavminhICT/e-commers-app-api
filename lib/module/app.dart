import 'package:e_commers_app/module/main_screen.dart';
import 'package:flutter/material.dart';



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Simple Screen',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: MainScreen(),
    );
  }
}