import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Default values, will be overridden by saved preferences
  bool _payment = true;
  bool _tracking = true;
  bool _completeOrder = true;
  bool _notification = true;

  // Keys for SharedPreferences
  static const String _kNotificationMaster = 'notification_master';
  static const String _kNotificationPayment = 'notification_payment';
  static const String _kNotificationTracking = 'notification_tracking';
  static const String _kNotificationCompleteOrder = 'notification_complete_order';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load saved values, defaulting to true if not found
      _notification = prefs.getBool(_kNotificationMaster) ?? true;
      _payment = prefs.getBool(_kNotificationPayment) ?? true;
      _tracking = prefs.getBool(_kNotificationTracking) ?? true;
      _completeOrder = prefs.getBool(_kNotificationCompleteOrder) ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageData = context.watch<LanguageLogic>().language;
    // Ensure that if master notification is off, sub-settings reflect this visually
    // even before their onChanged is triggered (e.g., on initial load)
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
              onChanged: _notification // Only allow change if master is on
                  ? (val) async {
                      final prefs = await SharedPreferences.getInstance();
                      setState(() {
                        _payment = val;
                        prefs.setBool(_kNotificationPayment, _payment);
                      });
                    }
                  : null,
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: Text(languageData.Tracking), // Use translated string
              value: _tracking,
              onChanged: _notification // Only allow change if master is on
                  ? (val) async {
                      final prefs = await SharedPreferences.getInstance();
                      setState(() {
                        _tracking = val;
                        prefs.setBool(_kNotificationTracking, _tracking);
                      });
                    }
                  : null,
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: Text(languageData.Complete_Order), // Use translated string
              value: _completeOrder,
              onChanged: _notification // Only allow change if master is on
                  ? (val) async {
                      final prefs = await SharedPreferences.getInstance();
                      setState(() {
                        _completeOrder = val;
                        prefs.setBool(_kNotificationCompleteOrder, _completeOrder);
                      });
                    }
                  : null,
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: Text(languageData.Notifications), // Use translated string (reusing 'Notifications' key)
              value: _notification,
              onChanged: (val) async {
                final prefs = await SharedPreferences.getInstance();
                setState(() {
                  _notification = val;
                  prefs.setBool(_kNotificationMaster, _notification);
                  if (!_notification) {
                    // If master notification is turned off, turn off and disable sub-notifications
                    _payment = false;
                    _tracking = false;
                    _completeOrder = false;
                    // Save these changes too
                    prefs.setBool(_kNotificationPayment, _payment);
                    prefs.setBool(_kNotificationTracking, _tracking);
                    prefs.setBool(_kNotificationCompleteOrder, _completeOrder);
                  }
                  // If master is turned on, sub-switches are enabled but retain their 'off' state
                  // allowing the user to re-enable them individually.
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
