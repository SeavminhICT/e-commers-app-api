import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_logic.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<Map<String, String>> _languageList = const [
    {'name': 'ខ្មែរ', 'flag': '🇰🇭'},
    {'name': 'English', 'flag': '🇬🇧'},
  ];

  @override
  Widget build(BuildContext context) {
    // Access the language logic provider
    final languageLogic = context.watch<LanguageLogic>();
    final languageData = languageLogic.language;
    final currentLangIndex = languageLogic.langIndex;

    return Scaffold(
      appBar: AppBar(
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
          languageData.Language_Label, // Use Language_Label for the title
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: languageData.searchLanguage, // Dynamic hint text
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _languageList.length,
              itemBuilder: (context, index) {
                final languageItem = _languageList[index];
                final isSelected = index == currentLangIndex;

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
                      languageItem['flag']!,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(languageItem['name']!),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.deepPurple)
                        : null,
                    onTap: () {
                      // Call the provider to change the language
                      context.read<LanguageLogic>().changeLang(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
