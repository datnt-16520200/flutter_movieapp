import 'package:flutter/material.dart';
import 'package:movie_app/models/Movie.dart';
import 'package:movie_app/utils/Sizes.dart';

class PageViewHeaderItem extends StatelessWidget{
  Future<Movie> _movie;
  String _base_url = "https://image.tmdb.org/t/p/w500";

  PageViewHeaderItem(this._movie);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<Movie>(
      future: this._movie,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return Container(
            child: Stack(
              alignment: Alignment(-1, 1),
              children: <Widget>[
                Image.network(
                  _base_url + snapshot.data.backdropPath,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black87,
                            Colors.transparent
                          ]
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(snapshot.data.title,
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(snapshot.data.releaseDate,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        else if (snapshot.hasError){
          return Container(
            child: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }

        return Container(
          width: double.infinity,
          height: DeviceSize.getWidth()/1.78,
          child: Center(
            child: Container(
              width: DeviceSize.getWidth()/2,
              height: DeviceSize.getWidth()/2,
              child: CircularProgressIndicator(strokeWidth: 10,),
            ),
          ),
        );
      },
    );
  }

}