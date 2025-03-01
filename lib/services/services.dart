import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieService {
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
        print(data);
      } else {
        print('Hiba: ${response.statusCode}');
      }
    } catch (e) {
      print('Kérés sikertelen: $e');
    }
  }
}
