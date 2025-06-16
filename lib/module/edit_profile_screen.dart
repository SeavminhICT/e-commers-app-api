import 'package:flutter/material.dart';
import 'settings_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildSaveButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: const Text(
        'Edit Profile',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        Center(
          child: CircleAvatar(
            radius: 48,
            backgroundImage: AssetImage('images/profile.png'),
          ),
        ),
        const SizedBox(height: 32),
        _buildSectionTitle('Username'),
        _buildTextField(
          controller: _usernameController,
          icon: Icons.person_outline,
          hintText: 'Username',
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('Email or Phone Number'),
        _buildTextField(
          controller: _emailController,
          icon: Icons.email_outlined,
          hintText: 'Email or Phone Number',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('Account Liked With'),
        _buildLinkedAccount(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.deepPurple),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }

  Widget _buildLinkedAccount() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
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
          const Text(
            'Google',
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Icon(
            Icons.link,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // Save changes logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          minimumSize: const Size.fromHeight(48),
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(fontSize: 16,color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
