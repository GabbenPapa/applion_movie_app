import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesHomeScreen extends StatefulWidget {
  const MoviesHomeScreen({super.key});

  @override
  State<MoviesHomeScreen> createState() => _MoviesHomeScreenState();
}

class _MoviesHomeScreenState extends State<MoviesHomeScreen> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    searchMovie('Star Wars');
  }

  Future<void> searchMovie(String query) async {
    final url =
        'https://api.themoviedb.org/3/search/movie?query=$query&api_key=d30cc88bc0168c4e5a9385783eb9fe3f';
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMzBjYzg4YmMwMTY4YzRlNWE5Mzg1NzgzZWI5ZmUzZiIsInN1YiI6IjYzYWZlZThmNTc1MzBlMDA4NTAxMjdkMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wrRM0IPSBjbFO-CcvxU5GsyuHeatUlZlpgV5d3TANLw',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          movies = data['results'];
        });
      } else {
        // Hibakezelés
        print('Hiba: ${response.statusCode}');
      }
    } catch (e) {
      print('Kérés sikertelen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Movies'))),

      body: SafeArea(
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
    );
  }
}
