import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app/models/Movie.dart';
import 'package:movie_app/repositories/MovieApiClient.dart';
import 'package:movie_app/ui/screens/MovieDetailPage.dart';

class SearchPageBloc {
  Future<List<int>> searchMovies(String title) async {
    List<int> data = await MovieApiClient.searchMovies(title);
    return data;
  }

  List<Future<Movie>> loadMovies(List<int> list_id){
    return MovieApiClient.loadMovies(list_id);
  }

  void movieItemSelected(BuildContext context,Movie movie,String listName){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailPage(movie,listName)));
  }
}