import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  // Default values, will be overridden by saved preferences
  bool _faceId = false;
  bool _rememberPassword = true;
  bool _touchId = false;

  static const String _kSecurityFaceId = 'security_face_id';
  static const String _kSecurityRememberPassword = 'security_remember_password';
  static const String _kSecurityTouchId = 'security_touch_id';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load saved values, defaulting to their initial values if not found
      _faceId = prefs.getBool(_kSecurityFaceId) ?? _faceId;
      _rememberPassword =
          prefs.getBool(_kSecurityRememberPassword) ?? _rememberPassword;
      _touchId = prefs.getBool(_kSecurityTouchId) ?? _touchId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageData = context.watch<LanguageLogic>().language;
    return Scaffold(
      appBar: _buildAppBar(context, languageData),
      body: _buildBody(context, languageData),
    );
  }

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
        languageData.Security, // Use translated string
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, Language languageData) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.value();
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(languageData.Face_ID), // Use translated string
                value: _faceId,
              onChanged: (val) async {
                final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    _faceId = val;
                  prefs.setBool(_kSecurityFaceId, _faceId);
                  });
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: Text(languageData.Remember_Password), // Use translated string
                value: _rememberPassword,
              onChanged: (val) async {
                final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    _rememberPassword = val;
                  prefs.setBool(_kSecurityRememberPassword, _rememberPassword);
                  });
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: Text(languageData.Touch_ID), // Use translated string
                value: _touchId,
              onChanged: (val) async {
                final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    _touchId = val;
                  prefs.setBool(_kSecurityTouchId, _touchId);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
