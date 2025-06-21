import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';

class LegalPoliciesScreen extends StatelessWidget {
  LegalPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.watch<LanguageLogic>().language;
    return Scaffold(
      appBar: _buildAppBar(context, language),
      body: _buildBody(context, language),
    );
  }

  AppBar _buildAppBar(BuildContext context, Language language) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      title: Text(
        language.Legal_and_Policies, // Use translated string
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

  Widget _buildBody(BuildContext context, Language language) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Text(
          language.Terms,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
         Text(
          language.Welcome_to_our_app,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 8),
         Text(
          language.Your_use_of_any,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
         Text(
          language.Changes_to_the,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          language.We_reserve_the_right_to_modify,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          language.If_you_do_not_agree,
          style: const TextStyle(color: Colors.grey),
        ),
          ],
        ),
      ),
    );
  }
}
