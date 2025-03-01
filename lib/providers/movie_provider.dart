import 'package:applion_movie_app/models/movies_model.dart';
import 'package:applion_movie_app/services/services.dart';
import 'package:flutter/foundation.dart';

class MovieProvider with ChangeNotifier {
  final List<Movie> _movies = [];
  List<Movie> get movies => [..._movies];

  Future<void> fetchMovies(String query) async {
    try {
      final List<Map<String, dynamic>> rawData = await MovieService.searchMovie(
        query,
      );

      final List<Movie> fetchedMovies =
          rawData.map((jsonMap) => Movie.fromJson(jsonMap)).toList();

      _movies.clear();
      _movies.addAll(fetchedMovies);

      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        // Todo: show error message and error handling
        print('fetchMovies error: $error');
      }
      rethrow;
    }
  }
}
