import 'package:flutter/material.dart';
import 'langauge_data.dart';

class LanguageLogic extends ChangeNotifier {
  final List<Language> _supportedLanguages = [
    Language(), 
    English(), 
  ];


  int _langIndex = 0;
  late Language _language;

  LanguageLogic() {
    _language = _supportedLanguages[_langIndex];
  }

  int get langIndex => _langIndex;
  Language get language => _language;

  void changeLang(int index) {
    if (index >= 0 && index < _supportedLanguages.length) {
      _langIndex = index;
      _language = _supportedLanguages[index];
      notifyListeners();
    }
  }
}