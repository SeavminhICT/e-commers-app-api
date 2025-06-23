import 'dart:convert';
import 'package:e_commers_app/module/account_screen.dart';
import 'package:e_commers_app/module/home_screen.dart';
import 'package:e_commers_app/module/myFavScreen.dart'; // Contains MyScreen
import 'package:e_commers_app/module/myorder_screen.dart';
import 'package:e_commers_app/service/storage_service.dart';
import 'package:e_commers_app/service/favorite_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';

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
  String fixUrl(String url) {
    if (url.startsWith('https://')) {
      return url.replaceFirst('https://', 'http://');
    }
    return url;
  }

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
        profileImage = userMap['avatar'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageData = context.watch<LanguageLogic>().language;

    return Scaffold(
      body: _buildBody(context), // Pass context if needed by children, not strictly necessary here
      bottomNavigationBar: _buildNavigationBar(context, languageData),
    );
  }

  Widget _buildBody(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: [
        const HomeScreen(),
        const MyOrderScreen(),
        MyFavScreen(favoriteProducts: favoriteProducts), // Pass the global favoriteProducts list
        const AccountScreen(),
      ],
    );
  }

  Widget _buildNavigationBar(BuildContext context, Language languageData) {
    final imageUrl = profileImage != null ? fixUrl(profileImage!) : null;
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
        BottomNavigationBarItem(
          icon: const ImageIcon(AssetImage('images/Home_icon.png')),
          label: languageData.HOME, // Use translated string
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('images/order_icon.png')),
          label: languageData.MYORDER, // Use translated string
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('images/wishlist_icon.png')),
          label: languageData.FAVORITE, 
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 12,
            backgroundImage: imageUrl != null
                ? NetworkImage(imageUrl!)
                : const AssetImage('images/profile.png') as ImageProvider,
          ),
          label: languageData.ACCOUNT, 
        ),
      ],
    );
  }
}
