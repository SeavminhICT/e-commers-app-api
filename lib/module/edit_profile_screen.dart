import 'dart:convert';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';
import 'package:e_commers_app/service/storage_service.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final languageData = context.watch<LanguageLogic>().language;
    return Scaffold(
      appBar: _buildAppBar(context, languageData),
      body: _buildBody(context, languageData),
      bottomNavigationBar: _buildSaveButton(context, languageData),
    );
  }

  // Removed duplicate _buildAppBar with no parameters.

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

  // Removed duplicate _buildSaveButton with no parameters to resolve ambiguity.

  // Corrected helper methods to accept languageData
  AppBar _buildAppBar(BuildContext context, Language languageData) {
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
      title: Text(
        languageData.Edit_Profile, // Use translated string
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Language languageData) {
    final imageUrl = fixUrl(avatar);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        Center(
          child: CircleAvatar(
              radius: 52,
              backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                  ? NetworkImage(imageUrl!) as ImageProvider
                  : const AssetImage('images/profile.png'),
            ),
        ),
        const SizedBox(height: 32),
        _buildSectionTitle(languageData.Username), // Use translated string
        _buildTextField(
          controller: _usernameController,
          icon: Icons.person_outline,
          hintText: languageData.Username, // Use translated string
        ),
        const SizedBox(height: 24),
        _buildSectionTitle(languageData.Email_or_Phone_Number), // Use translated string
        _buildTextField(
          controller: _emailController,
          icon: Icons.email_outlined,
          hintText: languageData.Email_or_Phone_Number, // Use translated string
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        _buildSectionTitle(languageData.Account_Linked_With), // Use translated string
        _buildLinkedAccount(), // This method doesn't use languageData directly, so no change needed here
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context, Language languageData) {
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
        child: Text(
          languageData.Save_Changes, // Use translated string
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
