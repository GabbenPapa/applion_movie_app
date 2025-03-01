import 'package:flutter/foundation.dart';

class LanguageProvider with ChangeNotifier {
  String? _currentLanguage;

  String get currentLanguage => _currentLanguage ?? 'en';

  Future<void> resetLanguage() async {
    _currentLanguage = 'en';
    notifyListeners();
  }
}
