import 'package:flutter/material.dart';

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
        'Security',
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
              title: const Text('Face ID'),
              value: _faceId,
              onChanged: (val) {
                setState(() {
                  _faceId = val;
                });
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: const Text('Remember Password'),
              value: _rememberPassword,
              onChanged: (val) {
                setState(() {
                  _rememberPassword = val;
                });
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: const Text('Touch ID'),
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
