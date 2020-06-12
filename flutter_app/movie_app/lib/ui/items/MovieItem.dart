import 'package:flutter/material.dart';
import 'package:movie_app/utils/Sizes.dart';
import 'package:movie_app/models/Movie.dart';

class MovieItem extends StatelessWidget{
  double _width_item = DeviceSize.getWidth()/3;
  String _base_url = "https://image.tmdb.org/t/p/w300";
  Future<Movie> _movie;
  String _listName;

  MovieItem(this._movie,this._listName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<Movie>(
      future: this._movie,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
            width: _width_item,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: (_width_item - 10) * 1.5,
                  child: Hero(
                    tag: snapshot.data.id.toString()+"_"+this._listName,
                    child: Image.network(
                      _base_url + snapshot.data.posterPath,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: Text(snapshot.data.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          );
        }
        else if (snapshot.hasError){
          return Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
            width: _width_item,
            child: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }

        return Container(
          width: _width_item,
          height: _width_item * 1.5 + 20,
          child: Center(
            child: Container(
              width: _width_item/2,
              height: _width_item/2,
              child: CircularProgressIndicator(strokeWidth: 10,),
            ),
          )
        );
      },
    );
  }

}

class MovieItemForMore extends StatelessWidget{
  double _widthPoster = DeviceSize.getWidth()/3;
  String _base_url = "https://image.tmdb.org/t/p/w300";
  Future<Movie> _movie;
  String _listName;

  MovieItemForMore(this._movie,this._listName);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<Movie>(
      future: this._movie,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return Container(
            margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: _widthPoster,
                  height: _widthPoster*1.5,
                  child: Hero(
                    tag: snapshot.data.id.toString()+"_"+this._listName,
                    child: snapshot.data.posterPath != null ? Image.network(
                      _base_url + snapshot.data.posterPath,
                      fit: BoxFit.fill,
                    ) : Image.asset("assets/images/default_poster.jpg"),
                  ),
                ),
                SizedBox(
                  width: DeviceSize.getWidth()- _widthPoster - 10,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          snapshot.data.title,
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        createText("Release: "+snapshot.data.releaseDate),
                        createGenres(snapshot.data.genres),
                        Row(
                          children: <Widget>[
                            createText("Vote average: "+ (snapshot.data.voteAverage*4/10).toStringAsFixed(2)+" "),
                            Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.yellow,
                            )
                          ],
                        ),
                        createText("Runtime: "+ snapshot.data.runtime.toString()+ " min")
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        else if (snapshot.hasError){
          return SizedBox(
            width: double.infinity,
            height: 0,
          );
        }
        return Container(
          width: double.infinity,
          height: _widthPoster*1.5,
          child: Center(
            child: Container(
              width: _widthPoster,
              height: _widthPoster,
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget createGenres(List<dynamic> genres){
    if (genres.length > 0){
      List<Widget> someWidget = [];
      for(int i = 0; i < genres.length; i++){
        Widget object = Padding(
          padding: EdgeInsets.only(right: 5, top: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromRGBO(254,160,2,1.0),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
              child: Text(
                genres[i]['name'].toString(),
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
        someWidget.add(object);
      }

      return Wrap(
        children: someWidget,
      );
    }
    return null;
  }

  Widget createText(String text){
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

}