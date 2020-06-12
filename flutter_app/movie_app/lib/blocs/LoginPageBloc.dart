import 'package:flutter/material.dart';
import 'package:movie_app/repositories/UserApiClient.dart';
import 'package:movie_app/ui/drawer/DrawerNavigation.dart';
import 'package:movie_app/ui/screens/HomePage.dart';
import 'package:movie_app/models/User.dart';

class LoginPageBloc {
  TextEditingController userController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  String _username = "admin";
  String _password = "123456";

  Future btnLoginPress(BuildContext context) async {
    Map<String, dynamic> res_data = await UserApiClient.Login(userController.text, passController.text);
    if (res_data['success']){
//      Navigator.of(context).pop();
      print(res_data);
      Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerNavigation(User.fromJson(res_data))));
    }
//    if (userController.text == _username && passController.text == _password){
//      Map<String,dynamic> res_data = {'success': true, 'user_id': 8, 'name': 'Tien Dat', 'email': 'tiendat@gmail.com', 'adress': 'Toulon, France', 'birthday': '1960-07-07', 'gender': 'male'};
//      Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerNavigation(User.fromJson(res_data))));
//    }
    else{
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            title: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Text("Login error!", style: TextStyle(color: Colors.red, fontSize: 25)),
            ),
            content: Text("You entered the wrong username or password."),
            actions: <Widget>[
              FlatButton(
                child: Text("OK", style: TextStyle(fontSize: 15, color: Colors.blue),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
            elevation: 24.0,
          );
        }
      );
    }
  }
}