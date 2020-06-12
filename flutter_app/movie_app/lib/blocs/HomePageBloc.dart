import 'package:movie_app/models/Movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app/repositories/MovieApiClient.dart';
import 'package:movie_app/ui/screens/MovieDetailPage.dart';
import 'package:movie_app/ui/screens/MoreMoviesPage.dart';

class HomePageBloc {
  void buttonMoreTap(BuildContext context, String title, List<int> movies){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MoreMoviesPage(title, movies)));
  }

  void movieItemSelected(BuildContext context,Movie movie,String listName){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailPage(movie,listName)));
  }

  List<Future<Movie>> loadMovies(List<int> list_id){
    return MovieApiClient.loadMovies(list_id);
  }

  Future<Map<String, dynamic>> loadRecommendedMovies(int userId) async {
    Map<String, dynamic> res_data = await MovieApiClient.loadRecommendedMovies(userId);
    return res_data;
  }
}