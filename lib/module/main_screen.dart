
import 'package:e_commers_app/module/home_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: const [
        HomeScreen(),
        Center(child: Text('Wishlist Page')),
        Center(child: Text('Order Page')),
        Center(child: Text('Account Page')),
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
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('images/Home_icon.png')),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('images/wishlist_icon.png')),
          label: 'WISHLIST',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('images/order_icon.png')),
          label: 'ORDER',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 12,
            backgroundImage: AssetImage('images/profile.jpg'),
          ),
          label: 'ACCOUNT',
        ),
      ],
    );
  }
}
