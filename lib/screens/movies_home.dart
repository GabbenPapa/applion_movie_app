import 'package:applion_movie_app/components/movies_card.dart';
import 'package:applion_movie_app/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesHomeScreen extends StatefulWidget {
  const MoviesHomeScreen({super.key});

  @override
  State<MoviesHomeScreen> createState() => _MoviesHomeScreenState();
}

class _MoviesHomeScreenState extends State<MoviesHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

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

  void _onSearchSubmitted(String query) {
    Provider.of<MovieProvider>(context, listen: false).fetchMovies(query);
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
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search for a movie',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: _onSearchSubmitted,
              ),
            ),
            Expanded(
              child:
                  movies.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : MoviesCard(movies: movies),
            ),
          ],
        ),
      ),
    );
  }
}
