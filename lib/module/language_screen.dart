import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'English';

  final List<Map<String, String>> _languages = [
    {'name': 'English', 'flag': '🇬🇧'},
    {'name': 'Khmer', 'flag': '🇰🇭'},
    {'name': 'Chinese', 'flag': '🇨🇳'},
  ];

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
        'Language',
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search language',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _languages.length,
            itemBuilder: (context, index) {
              final language = _languages[index];
              final isSelected = language['name'] == _selectedLanguage;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.deepPurple.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                  ),
                ),
                child: ListTile(
                  leading: Text(
                    language['flag'] ?? '',
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(language['name'] ?? ''),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.deepPurple)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = language['name']!;
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
