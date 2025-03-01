import 'dart:async';
import 'package:applion_movie_app/components/movies_card.dart';
import 'package:applion_movie_app/providers/movie_provider.dart';
import 'package:applion_movie_app/screens/settings.dart';
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
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Movies',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Settings.routeName);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              // Search area
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 240, 240),
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
