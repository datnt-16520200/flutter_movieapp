import 'package:flutter/material.dart';
import 'package:movie_app/models/User.dart';
import 'package:movie_app/utils/Sizes.dart';

class UserInfoPage extends StatelessWidget{
  User _user;

  UserInfoPage(this._user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              color: Color.fromRGBO(56,58,73, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(3),
                    height: DeviceSize.getWidth()/4,
                    width: DeviceSize.getWidth()/4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/default_avatar.webp',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _user.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.movie_filter, color: Colors.white,),
                            Padding(
                              padding: const EdgeInsets.only(top:8, bottom: 8),
                              child: Text("88 movies...",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.credit_card, color: Colors.yellow,),
                            Padding(
                              padding: const EdgeInsets.only(top:8, bottom: 8),
                              child: Text("VIP level",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color.fromRGBO(64,67,84, 1),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.email, color: Colors.white,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Email: "+_user.email,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.white,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Address: "+_user.adress,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.cake, color: Colors.white,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Birthday: "+_user.birthday,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.wc, color: Colors.white,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Gender: "+_user.gender,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  
}