import 'dart:math';
import 'package:applion_movie_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  static const routeName = '/settings';

  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late String _selectedLanguage = 'English';
  var isServiceMode = false;
  int serviceModeTapCounter = 0;
  final Map<String, String> languageMap = {'English': 'en', 'Hungarian': 'hu'};

  void setSelectedLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageProvider = Provider.of<LanguageProvider>(
      context,
      listen: false,
    );
    setSelectedLanguage(
      languageMap.entries
          .firstWhere(
            (entry) => entry.value == languageProvider.currentLanguage,
          )
          .key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      appBar: AppBar(title: Text('Settings')),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
              bottom: 26.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Language Dropdown
                ListTile(
                  // title: Text(AppLocalizations.of(context)!.language),
                  title: Text('Language'),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedLanguage,
                      items:
                          languageMap.keys
                              .map(
                                (lang) => DropdownMenuItem(
                                  value: lang,
                                  child: Text(lang),
                                ),
                              )
                              .toList(),
                      onChanged: (newLang) {
                        if (newLang == null) return;
                        setSelectedLanguage(newLang);
                      },
                    ),
                  ),
                ),

                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 60),
                  builder: (context, double value, child) {
                    return Transform.rotate(
                      angle: value * 2 * pi,
                      child: child,
                    );
                  },
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Icon(Icons.settings, size: 100)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
