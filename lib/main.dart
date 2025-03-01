import 'package:applion_movie_app/models/movies_model.dart';
import 'package:applion_movie_app/providers/movie_provider.dart';
import 'package:applion_movie_app/screens/movies_details.dart';
import 'package:applion_movie_app/screens/movies_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MovieProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
    );
  }
}
