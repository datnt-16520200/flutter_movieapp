import 'package:flutter/material.dart';
import 'package:movie_app/blocs/MovieDetailPageBloc.dart';
import 'package:movie_app/models/Movie.dart';
import 'package:movie_app/utils/Sizes.dart';

class MovieDetailPage extends StatelessWidget{
  Movie _movie;
  String _listName;
  String _base_url = "https://image.tmdb.org/t/p/";
  double _backdrop_width = DeviceSize.getWidth();
  double _poster_width = DeviceSize.getWidth()/4;

  MovieDetailPageBloc bloc = new MovieDetailPageBloc();

  MovieDetailPage(this._movie,this._listName);

  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[IconButton(icon: Icon(null),)],
        backgroundColor: Color(0xFF2d3450),
        title: Center(
          child: Text(
            "Movie Detail",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF2d3450),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: (_backdrop_width/1.78) + (_poster_width*1.5/2),
                child: Stack(
                  alignment: Alignment(-1, 1),
                  children: <Widget>[
                    Align(
                      alignment: Alignment(-1, -1),
                      child: this._movie.backdropPath != null ? Image.network(
                        _base_url + "w500" + this._movie.backdropPath,
                        width: _backdrop_width,
                        height: _backdrop_width/1.78,
                      ) :
                      Image.asset("assets/images/backdrop_default.PNG"),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                  color: Color(0xFF2d3447),
                                  blurRadius: 25,
                                  offset: Offset(0, 10)
                              )]
                          ),
                          child: Hero(
                            tag: this._movie.id.toString()+"_"+this._listName,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: this._movie.posterPath != null ? Image.network(
                                _base_url + "w300" + this._movie.posterPath,
                                width: _poster_width,
                                height: _poster_width*1.5,
                              ) : Image.asset(
                                "assets/images/default_poster.jpg",
                                width: _poster_width,
                                height: _poster_width*1.5,
                              ),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            width: _backdrop_width*(1-1/4) - 20,
                            height: _poster_width*1.5/2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                      this._movie.title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                ),
                                Text(
                                  "Release date: "+this._movie.releaseDate,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    createRichText("Genres:", convertString(this._movie.genres)),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        children: <Widget>[
                          createRichText("Vote average: ", (this._movie.voteAverage*4/10).toStringAsFixed(2)+" "),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: createRichText("Runtime: ", this._movie.runtime.toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: createRichText("Production companies:", convertString(this._movie.productionCompanies)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: createRichText("Budget: ", this._movie.budget.toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: createRichText("Revenue: ", this._movie.revenue.toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: createRichText("Overview: ", this._movie.overview),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Center(child: createRatingBar()),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String convertString(dynamic genres){
    String result = "";
    int dem = 0;
    for(var i in genres){
      if (dem == 0){
        result += " " + i['name'];
      }
      else{
        result += ", " + i['name'];
      }
      dem++;
    }
    return result + ".";
  }

  Widget createRichText(String title, String detail){
    return RichText(
      text: TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 16),
          children: [
            TextSpan(text: title, style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: detail)
          ]
      ),
    );
  }

  Widget createRatingBar(){
    return StreamBuilder(
      stream: bloc.ratingBarStream,
      builder: (context, snapshot){
        return Column(
          children: <Widget>[
            Divider(
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              child: Center(
                child: Text(
                  "Rating for this movie",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index){
                return IconButton(
                  onPressed: (){
                    bloc.iconButtonPress(index+1);
                  },
                  color: Colors.yellow,
                  iconSize: 30,
                  icon: Icon(
                    index < snapshot.data ? Icons.star : Icons.star_border
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}