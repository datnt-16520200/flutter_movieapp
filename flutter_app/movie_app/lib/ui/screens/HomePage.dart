import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/HomePageBloc.dart';
import 'package:movie_app/models/Movie.dart';
import 'package:movie_app/models/User.dart';
import 'package:movie_app/ui/items/MovieItem.dart';
import 'package:movie_app/ui/items/PageViewHeaderItem.dart';
import 'package:movie_app/utils/Sizes.dart';

class HomePage extends StatefulWidget{
  User _user;

  HomePage(this._user);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  HomePageBloc bloc = new HomePageBloc();
  Future<Map<String, dynamic>> res_data;
  Future<List<int>> _recommended_movies;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HomePage: build Function!");
    res_data = bloc.loadRecommendedMovies(widget._user.userId);

    return FutureBuilder<Map<String, dynamic>>(
      future: this.res_data,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xFF2d3450),
              //Nội dung chính của ứng dụng gồm các phần như PageViewHeader và các list films
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PageViewHeader(context),

                    TitleOfList("Recommend for you",snapshot.data['recommendations'].cast<int>()),
                    ListMovies("recommend_for_you",snapshot.data['recommendations'].cast<int>()),

                    TitleOfList("Popularity movies",snapshot.data['popularity'].cast<int>()),
                    ListMovies("popularity_movies",snapshot.data['popularity'].cast<int>()),

                    TitleOfList("New",snapshot.data['new'].cast<int>()),
                    ListMovies("new",snapshot.data['new'].cast<int>()),
                  ],
                ),
              ),
            ),
          );
        }
        else if (snapshot.hasError){
          return Center(
            child: Text(
              "${snapshot.error}",
              //style: TextStyle(color: Colors.white),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget ListMovies(String listName, List<int> movies){
    List<Future<Movie>> list_movies;
    list_movies = bloc.loadMovies(movies.sublist(0,10));
    return Container(
      width: double.infinity,
      height: DeviceSize.getWidth()/3 * 1.5 + 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list_movies.length,
        itemBuilder: (context, index){
          return GestureDetector(
            child: MovieItem(list_movies[index], listName),
            onTap: () async {
              bloc.movieItemSelected(context,await list_movies[index],listName);
            },
          );
        },
      ),
    );
    //}

  }

  Widget PageViewHeader(BuildContext context){
    List<Future<Movie>> list_movies = bloc.loadMovies([271110, 68721, 58233, 49530]);
    return Container(
      width: double.infinity,
      height: DeviceSize.getWidth()/1.78,
      child: PageView.builder(
        itemCount: list_movies.length,
        itemBuilder: (context, index){
          return GestureDetector(
            child: PageViewHeaderItem(list_movies[index]),
            onTap: () async {
              bloc.movieItemSelected(context, await list_movies[index],"");
            },
          );
        },
      ),
    );
  }

  Widget TitleOfList(String title, List<int> movies){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),),
        ),
        GestureDetector(
          onTap: () {
            bloc.buttonMoreTap(context, title, movies);
          },
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 5, right: 5),
            child: Row(
              children: <Widget>[
                Text("More",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
