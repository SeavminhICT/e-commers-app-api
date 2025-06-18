List<Language> languageList = [Language(), Khmer(), Chinese()];

class Language {
  String get food => "Food";
  
}

class Khmer extends Language {
  String get food => "អាហារ";
  
}

class Chinese extends Language {
  String get food => "食物";
  
}
