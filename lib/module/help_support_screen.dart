import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'langauge_data.dart';
import 'langauge_logic.dart';
class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final List<bool> _expanded = List.generate(7, (_) => false);

  final List<Map<String, String>> _faqData = [
    {
      'title': 'Lorem ipsum dolor sit amet',
      'body': 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
    },
    {
      'title': 'Lorem ipsum dolor sit amet',
      'body': 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
    },
    {
      'title': 'Lorem ipsum dolor sit amet',
      'body': 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
    },
    {
      'title': 'Lorem ipsum dolor sit amet',
      'body': 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
    },
    {
      'title': 'Lorem ipsum dolor sit amet',
      'body': 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
    },
    {
      'title': 'Lorem ipsum dolor sit amet',
      'body': 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
    },
    {
      'title': 'Why can\'t I add this product to card',
      'body': 'Have trouble with adding your product to your card?',
    },
  ];

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
        languageData.Help_Support, // Use translated string
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

  Widget _buildBody(BuildContext context, Language languageData) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: languageData.searchLanguage, // Use translated string
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          ExpansionPanelList(
            elevation: 0,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _expanded[panelIndex] = !isExpanded;
              });
            },
            children: List.generate(_faqData.length, (index) {
              final title = index == _faqData.length - 1
                  ? languageData.Why_cant_I_add_this_product_to_card
                  : _faqData[index]['title']!; 
              final body = index == _faqData.length - 1
                  ? languageData.Have_trouble_with_adding_your_product_to_your_card
                  : _faqData[index]['body']!; 
              return ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(title),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(body,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                isExpanded: _expanded[index],
              );
            }),
          ),
        ],
      ),
    );
  }
}
