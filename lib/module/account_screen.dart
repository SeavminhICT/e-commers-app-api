import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';

class AccountScreen extends StatelessWidget {
  final String username;
  final String emailOrPhone;
  final String linkedAccount;

  const AccountScreen({
    super.key,
    required this.username,
    required this.emailOrPhone,
    this.linkedAccount = 'Google',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: const Text(
        'Account',
        style: TextStyle(
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
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
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
              backgroundImage: AssetImage('images/profile.png'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Removed Edit Profile button as per user request
        const SizedBox(height: 36),
        // _buildSectionTitle('Username'),
        _buildReadOnlyField(username, Icons.person_outline),
        const SizedBox(height: 28),
        // _buildSectionTitle('Email or Phone Number'),
        _buildReadOnlyField(emailOrPhone, Icons.email_outlined),
        const SizedBox(height: 28),
        _buildSectionTitle('Account Linked With'),
        _buildLinkedAccount(),
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
}
