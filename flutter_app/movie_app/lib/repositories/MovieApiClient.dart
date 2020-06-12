import 'package:movie_app/models/Movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieApiClient {
  static String _baseURL = "https://api.themoviedb.org/3/movie/";
  static String _apiKey = "802b2c4b88ea1183e50e6b285a27696e";

  static Future<Movie> fetchMovie(int id) async {
    String url = _baseURL + id.toString() + "?api_key=" + _apiKey;

    final response = await http.get(url);

    if (response.statusCode == 200){
      return Movie.fromJson(json.decode(response.body));
    }
    else{
      return null;
    }
  }

  static List<Future<Movie>> loadMovies(List<int> list_id){
    List<Future<Movie>> list_movies = new List<Future<Movie>>();

    for(var i in list_id){
      Future<Movie> m = fetchMovie(i);
      if (m != null) {
        list_movies.add(m);
      }
    }

    return list_movies;
  }

  static Future<Map<String, dynamic>> loadRecommendedMovies(int userId) async {
    http.Response response = await http.post(
      "http://10.0.2.2:8000/api/recommendations",
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String,int>{
        'user_id': userId
      })
    );

    Map<String, dynamic> res_data = json.decode(response.body);

    return res_data;
  }

  static Future<List<int>> searchMovies(String title) async {
    String url = 'http://10.0.2.2:8000/api/search_movies?title=' + title.trim().replaceAll(' ', '%20');
    http.Response response = await http.get(url);

    List<dynamic> data = json.decode(response.body);
    List<int> listMovieId = new List<int>();
    for(int i = 0; i < data.length; i++){
      listMovieId.add(data[i]['movie_id']);
    }
    return listMovieId;
  }
}