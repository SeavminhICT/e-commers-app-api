import 'package:e_commers_app/module/langauge_data.dart';
import 'package:flutter/material.dart';

class LanguageLogic extends ChangeNotifier {
  Language _language = Khmer();
  Language get language => _language;
  int _langIndex = 0;
  int get langIndex => _langIndex;

  void changeToEnglish() {
    _langIndex = 0;
    _language = languageList[_langIndex];
    notifyListeners();
  }

  void changeToKhmer() {
    _langIndex = 1;
    _language = languageList[_langIndex];
    notifyListeners();
  }

  void changeToChinese() {
    _langIndex = 2;
    _language = languageList[_langIndex];
    notifyListeners();
  }
}

    // Language _language = Khmer();
    // int _langIndex = 0;
    // put under class


    // _language = context.watch<LanguageLogic>().language;
    // _langIndex = context.watch<LanguageLogic>().langIndex;
    // put under package