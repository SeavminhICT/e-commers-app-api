import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _payment = true;
  bool _tracking = true;
  bool _completeOrder = true;
  bool _notification = true;

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
        languageData.Notifications, // Use translated string
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
              title: Text(languageData.Payment), // Use translated string
              value: _payment,
              onChanged: (val) {
                setState(() {
                  _payment = val;
                });
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: Text(languageData.Tracking), // Use translated string
              value: _tracking,
              onChanged: (val) {
                setState(() {
                  _tracking = val;
                });
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: Text(languageData.Complete_Order), // Use translated string
              value: _completeOrder,
              onChanged: (val) {
                setState(() {
                  _completeOrder = val;
                });
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: Text(languageData.Notifications), // Use translated string (reusing 'Notifications' key)
              value: _notification,
              onChanged: (val) {
                setState(() {
                  _notification = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
