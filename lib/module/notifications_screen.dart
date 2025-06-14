import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
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
        'Notifications',
        style: TextStyle(
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

  Widget _buildBody() {
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
              title: const Text('Payment'),
              value: _payment,
              onChanged: (val) {
                setState(() {
                  _payment = val;
                });
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: const Text('Tracking'),
              value: _tracking,
              onChanged: (val) {
                setState(() {
                  _tracking = val;
                });
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: const Text('Complete Order'),
              value: _completeOrder,
              onChanged: (val) {
                setState(() {
                  _completeOrder = val;
                });
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: const Text('Notification'),
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
