import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _faceId = true;
  bool _rememberPassword = true;
  bool _touchId = true;

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
    return Padding(
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
              onChanged: (val) {
                setState(() {
                  _faceId = val;
                });
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: Text(languageData.Remember_Password), // Use translated string
              value: _rememberPassword,
              onChanged: (val) {
                setState(() {
                  _rememberPassword = val;
                });
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: Text(languageData.Touch_ID), // Use translated string
              value: _touchId,
              onChanged: (val) {
                setState(() {
                  _touchId = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
