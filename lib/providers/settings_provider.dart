import 'package:flutter/foundation.dart';

// Todo: add shared preferences to persistent language settings
class LanguageProvider with ChangeNotifier {
  String? _currentLanguage;

  String get currentLanguage => _currentLanguage ?? 'en';

  Future<void> setLanguage(String language) async {
    _currentLanguage = language;

    notifyListeners();
  }

  Future<void> resetLanguage() async {
    _currentLanguage = 'en';
    notifyListeners();
  }
}
