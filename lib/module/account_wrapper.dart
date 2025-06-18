import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:e_commers_app/module/account_screen.dart';
import 'package:e_commers_app/service/storage_service.dart';

class AccountWrapper extends StatefulWidget {
  const AccountWrapper({Key? key}) : super(key: key);

  @override
  _AccountWrapperState createState() => _AccountWrapperState();
}

class _AccountWrapperState extends State<AccountWrapper> {
  String username = 'YourUsername';
  String emailOrPhone = 'your@email.com';
  String linkedAccount = 'Google';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userJson = await StorageService.read(key: 'user');
    if (userJson != null) {
      try {
        final Map<String, dynamic> userMap = jsonDecode(userJson);
        setState(() {
          username = userMap['name'] ?? username;
          emailOrPhone = userMap['email'] ?? emailOrPhone;
          // You can update linkedAccount if available in userMap
        });
      } catch (e) {
        // Handle JSON parse error if needed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AccountScreen(
      username: username,
      emailOrPhone: emailOrPhone,
      linkedAccount: linkedAccount,
    );
  }
}
