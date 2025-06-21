import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'notifications_screen.dart';
import 'security_screen.dart';
import 'language_screen.dart';
import 'legal_policies_screen.dart';
import 'help_support_screen.dart';
import 'logout_confirmation_dialog.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final language = context.watch<LanguageLogic>().language;
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
        language.Settings, // Use translated string
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

  Widget _buildBody(BuildContext context) {
    final language = context.watch<LanguageLogic>().language;
    final langIndex = context.watch<LanguageLogic>().langIndex;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        Text(
          language.General, // Use translated string
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        _buildListItem(
          context,
          icon: Icons.person_outline,
          label: language.Edit_Profile, // Use translated string
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EditProfileScreen()),
            );
          },
        ),
        _buildListItem( // Use translated string
          context,
          icon: Icons.lock_outline,
          label: language.Change_Password,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
            );
          },
        ),
        _buildListItem( // Use translated string
          context,
          icon: Icons.notifications_outlined,
          label: language.Notifications,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
            );
          },
        ),
        _buildListItem( // Use translated string
          context,
          icon: Icons.security_outlined,
          label: language.Security, // Use translated string
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SecurityScreen()),
            );
          },
        ),
        _buildListItem(
          context,
          icon: Icons.language_outlined,
          label: language.Language_Label, // Use translated string
          trailing: Text(
            langIndex == 0 ? 'ខ្មែរ' : 'English',
            style: const TextStyle(color: Colors.grey),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LanguageScreen()),
            );
          },
        ),
        const SizedBox(height: 24),
        Text(
          language.Preferences, // Use translated string
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        _buildListItem(
          context,
          icon: Icons.shield_outlined,
          label: language.Legal_and_Policies, // Use translated string
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>  LegalPoliciesScreen()),
            );
          },
        ),
        _buildListItem( // Use translated string
          context,
          icon: Icons.help_outline,
          label: language.Help_and_Support, // Use translated string
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
  Widget _buildLogoutButton(BuildContext context) {
    final language = context.watch<LanguageLogic>().language;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: Text(
          language.Logout, // Use translated string
          style: const TextStyle(color: Colors.red),
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
