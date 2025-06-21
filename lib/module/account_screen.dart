import 'dart:convert';
import 'package:e_commers_app/module/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:e_commers_app/service/storage_service.dart';
import 'package:get/get.dart';
import 'settings_screen.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String username = 'YourUsername';
  String emailOrPhone = 'your@email.com';
  String linkedAccount = 'Google';
  String avatar = 'avatar';

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
        avatar = userMap['avatar'];
      });
    }
  }
  Language _language = Language();
  int _langIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    _language = context.watch<LanguageLogic>().language;
    _langIndex = context.watch<LanguageLogic>().langIndex;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      title: Text(
        _language.ACCOUNT, 
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.deepPurple),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    _language = context.watch<LanguageLogic>().language;
    _langIndex = context.watch<LanguageLogic>().langIndex;
    final imageUrl = fixUrl(avatar);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF9C27B0).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 52,
              backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                  ? NetworkImage(imageUrl!) as ImageProvider
                  : const AssetImage('images/profile.png'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const SizedBox(height: 36),
        _buildReadOnlyField(username, Icons.person_outline),
        const SizedBox(height: 28),
        _buildReadOnlyField(emailOrPhone, Icons.email_outlined),
        const SizedBox(height: 28),
        _buildSectionTitle(_language.Account_Linked_With),
        _buildLinkedAccount(),
        SizedBox(
          height: 30,
        ),
        _buidingLogout(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: Color(0xFF7B1FA2),
      ),
    );
  }

  Widget _buildReadOnlyField(String text, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF7B1FA2)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7B1FA2)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedAccount() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF7B1FA2)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/google_logo.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 12),
          Text(
            linkedAccount,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Icon(
            Icons.link,
            color: const Color(0xFF7B1FA2),
          ),
        ],
      ),
    );
  }

  Widget _buidingLogout() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      // Add some margin
      decoration: BoxDecoration(
        color: Colors.redAccent, // Background color for the button area
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        boxShadow: [
          // Optional: Add a subtle shadow
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          // Padding inside the button
          foregroundColor: Colors.cyan,
          shape: RoundedRectangleBorder(
            // Ensure the button shape matches the container
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () async {
          await StorageService.delete(key: 'token');
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RegisterScreen()),
          );

          print('Logout button pressed');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            Icon(
              Icons.logout, // Logout icon
              color: Colors.white, // Icon color
            ),
            SizedBox(width: 8.0), // Spacing between icon and text
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
