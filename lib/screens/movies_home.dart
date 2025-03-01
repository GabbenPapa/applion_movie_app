import 'dart:async';
import 'package:applion_movie_app/components/movies_card.dart';
import 'package:applion_movie_app/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesHomeScreen extends StatefulWidget {
  static const routeName = '/movie_home';
  const MoviesHomeScreen({super.key});

  @override
  State<MoviesHomeScreen> createState() => _MoviesHomeScreenState();
}

class _MoviesHomeScreenState extends State<MoviesHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).fetchMovies('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Todo: Hotfix for a while for search when clear textfield
    if (_searchController.text.isEmpty) {
      Provider.of<MovieProvider>(context, listen: false).fetchMovies('');
    }

    if (_searchTimer?.isActive ?? false) _searchTimer!.cancel();

    _searchTimer = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        Provider.of<MovieProvider>(context, listen: false).fetchMovies(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieProvider>();
    final movies = movieProvider.movies;

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Movies'))),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              // Search area
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search for a movie',
                  border: OutlineInputBorder(),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            //Movies list
            Expanded(
              child:
                  movies.isEmpty
                      ? const Center(
                        child: Text(
                          'No movies found, search some movies!',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                      : MoviesCard(movies: movies),
            ),
          ],
        ),
      ),
    );
  }
}
