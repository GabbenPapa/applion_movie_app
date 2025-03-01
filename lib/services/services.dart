import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieService {
  static const _apiKey = 'd30cc88bc0168c4e5a9385783eb9fe3f';
  static const _accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMzBjYzg4YmMwMTY4YzRlNWE5Mzg1NzgzZWI5ZmUzZiIsInN1YiI6IjYzYWZlZThmNTc1MzBlMDA4NTAxMjdkMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wrRM0IPSBjbFO-CcvxU5GsyuHeatUlZlpgV5d3TANLw';

  static Future<List<Map<String, dynamic>>> searchMovie(String query) async {
    final url =
        'https://api.themoviedb.org/3/search/movie?query=$query&api_key=$_apiKey';
    final headers = {'Authorization': 'Bearer $_accessToken'};

    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Hiba: ${response.statusCode}');
    }
  }
}
