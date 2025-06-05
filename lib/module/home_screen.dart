import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Mega Mall',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      actions: [
        
        IconButton(
          icon: Image.asset(
            'images/notification_icon.png',
            height: 20,
            width: 20,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset(
            'images/shopping_icon.png',
            height: 20,
            width: 20,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
