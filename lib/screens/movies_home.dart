import 'package:applion_movie_app/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MoviesHomeScreen extends StatefulWidget {
  const MoviesHomeScreen({super.key});

  @override
  State<MoviesHomeScreen> createState() => _MoviesHomeScreenState();
}

class _MoviesHomeScreenState extends State<MoviesHomeScreen> {
  List<dynamic> movies = [];
  final TextEditingController _serachController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMovies("");
  }

  @override
  void dispose() {
    _serachController.dispose();
    super.dispose();
  }

  Future<void> _fetchMovies(param) async {
    try {
      final results = await MovieService.searchMovie(param);
      setState(() {
        movies = results;
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error msg: $error');
      } // Todo: show error message and error handling
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Movies'))),
      body: SafeArea(
        child: Column(
          children: [
            // Kereső mező
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _serachController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search for a movie',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  _fetchMovies(value);
                },
              ),
            ),
            Expanded(
              child:
                  movies.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return ListTile(
                            title: Text(movie['title'] ?? 'No title'),
                            subtitle: Text(
                              movie['release_date'] ?? 'Unknown release date',
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
