import 'package:applion_movie_app/models/movies_model.dart';
import 'package:applion_movie_app/providers/movie_provider.dart';
import 'package:applion_movie_app/providers/settings_provider.dart';
import 'package:applion_movie_app/screens/movies_details.dart';
import 'package:applion_movie_app/screens/movies_home.dart';
import 'package:applion_movie_app/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final languageProvider = LanguageProvider();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider.value(value: languageProvider),
      ],
      child: MyApp(languageProvider),
    ),
  );
}

class MyApp extends StatelessWidget {
  final LanguageProvider languageProvider;

  const MyApp(this.languageProvider, {super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('hu')],
      locale: Locale(languageProvider.currentLanguage),
      debugShowCheckedModeBanner: false,
      title: 'Applipn Test',
      // Todo: Theme hendling
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MoviesHomeScreen(),
      routes: {
        MoviesHomeScreen.routeName: (ctx) => const MoviesHomeScreen(),
        MoviesDetailScreen.routeName:
            (ctx) => MoviesDetailScreen(
              movie: ModalRoute.of(ctx)!.settings.arguments as Movie,
            ),
        Settings.routeName: (ctx) => const Settings(),
      },
    );
  }
}
