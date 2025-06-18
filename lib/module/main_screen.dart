import 'dart:convert';

import 'package:e_commers_app/module/account_screen.dart';
import 'package:e_commers_app/module/home_screen.dart';
import 'package:e_commers_app/service/storage_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  String username = 'YourUsername';
  String emailOrPhone = 'your@email.com';
  String? profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userJson = await StorageService.read(key: 'user');
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      setState(() {
        username = userMap['name'] ?? 'YourUsername';
        emailOrPhone = userMap['email'] ?? 'your@email.com';
        profileImage = userMap['profileImage']; // Adjust key as per API response
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        const HomeScreen(),
        const Center(child: Text('Order Page')),
        const Center(child: Text('Order Page')),
        AccountScreen(
          username: username,
          emailOrPhone: emailOrPhone,
          profileImage: profileImage,
        ),
      ],
    );
  }

  Widget _buildNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        const BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('images/Home_icon.png')),
          label: 'HOME',
        ),
        const BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('images/wishlist_icon.png')),
          label: 'WISHLIST',
        ),
        const BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('images/order_icon.png')),
          label: 'ORDER',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 12,
            backgroundImage: profileImage != null
                ? NetworkImage(profileImage!)
                : const AssetImage('images/profile.png') as ImageProvider,
          ),
          label: 'ACCOUNT',
        ),
      ],
    );
  }
}
