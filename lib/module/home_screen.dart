import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildNavigationBar(), // add navigation bar here
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
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

  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/Home_icon.png',
                width: 24,
                height: 24,
                color: Colors.blue, // optional color tint
              ),
              const SizedBox(height: 4),
              const Text(
                'HOME',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/wishlist_icon.png',
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              const SizedBox(height: 4),
              const Text(
                'WISHLIST',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/order_icon.png',
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              const SizedBox(height: 4),
              const Text(
                'ORDER',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('images/profile.jpg'),
              ),
              SizedBox(height: 4),
              Text(
                'ACCOUNT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
