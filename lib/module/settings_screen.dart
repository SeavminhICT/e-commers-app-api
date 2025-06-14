import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'notifications_screen.dart';
import 'security_screen.dart';
import 'language_screen.dart';
import 'legal_policies_screen.dart';
import 'help_support_screen.dart';
import 'logout_confirmation_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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
        'Settings',
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

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        const Text(
          'General',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        _buildListItem(
          context,
          icon: Icons.person_outline,
          label: 'Edit Profile',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EditProfileScreen()),
            );
          },
        ),
        _buildListItem(
          context,
          icon: Icons.lock_outline,
          label: 'Change Password',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
            );
          },
        ),
        _buildListItem(
          context,
          icon: Icons.notifications_outlined,
          label: 'Notifications',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
            );
          },
        ),
        _buildListItem(
          context,
          icon: Icons.security_outlined,
          label: 'Security',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SecurityScreen()),
            );
          },
        ),
        _buildListItem(
          context,
          icon: Icons.language_outlined,
          label: 'Language',
          trailing: const Text(
            'English',
            style: TextStyle(color: Colors.grey),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LanguageScreen()),
            );
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Preferences',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        _buildListItem(
          context,
          icon: Icons.shield_outlined,
          label: 'Legal and Policies',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LegalPoliciesScreen()),
            );
          },
        ),
        _buildListItem(
          context,
          icon: Icons.help_outline,
          label: 'Help & Support',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HelpSupportScreen()),
            );
          },
        ),
        const SizedBox(height: 24),
        _buildLogoutButton(context),
      ],
    );
  }

  Widget _buildListItem(BuildContext context,
      {required IconData icon,
      required String label,
      Widget? trailing,
      required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(label),
        trailing: trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
        onTap: onTap,
      ),
    );
  }

        _buildLogoutButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text(
          'Logout',
          style: TextStyle(color: Colors.red),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => LogoutConfirmationDialog(
              onCancel: () {
                Navigator.of(context).pop();
              },
              onLogout: () {
                Navigator.of(context).pop();
                // Add your logout logic here, e.g., clearing user session, navigating to login screen
              },
            ),
          );
        },
      ),
    );
  }
}
