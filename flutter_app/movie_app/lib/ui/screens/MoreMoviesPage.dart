import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/Movie.dart';
import 'package:movie_app/ui/items/MovieItem.dart';
import 'package:movie_app/blocs/HomePageBloc.dart';

class MoreMoviesPage extends StatefulWidget{
  String _title;
  List<int> _movies;

  MoreMoviesPage(this._title, this._movies);

  @override
  MoreMoviesPageState createState() => MoreMoviesPageState();
}

class MoreMoviesPageState extends State<MoreMoviesPage>{
  HomePageBloc _bloc = new HomePageBloc();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Future<Movie>> movies = _bloc.loadMovies(widget._movies);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[IconButton(icon: Icon(null))],
        backgroundColor: Color(0xFF2d3450),
        title: Center(
          child: Text(
            widget._title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF2d3450),
        child: ListView.builder(
          cacheExtent: 0.0,
          itemCount: movies.length,
          itemBuilder: (context, index){
            return GestureDetector(
              child: MovieItemForMore(movies[index],"more_page"),
              onTap: () async{
                _bloc.movieItemSelected(context, await movies[index], "more_page");
              },
            );
          },
        ),
//        child: MovieItemForMore(movies[0]),
      ),
    );
  }

}