import 'package:flutter/material.dart';
import 'package:movie_app/models/User.dart';
import 'package:movie_app/ui/screens/HomePage.dart';
import 'package:movie_app/ui/screens/UserInfoPage.dart';
import 'package:movie_app/ui/screens/SearchPage.dart';

class DrawerNavigationBloc {
  int _indexItemSelected = 0;
  HomePage _homePage;
  UserInfoPage _userInfoPage;
  User _user;

  void setUser(User user){
    this._user = user;
  }

  List<Map<String,dynamic>> _options = [
    {"icon":Icons.home, "title":"Home Page"},
    {"icon":Icons.person, "title":"User Information"}
  ];

  int get indexSelected => _indexItemSelected;

  List<Map<String, dynamic>> get options => _options;

  void onItemSelected(int index){
    _indexItemSelected = index;
  }

  void showSearchPage(BuildContext context){
    showSearch(context: context, delegate: SearchPage());
  }

  Widget getUI(int index){
    switch (index){
      case 0:
        return getHomePage();
      case 1:
        return getUserInfoPage();
    }
  }

  Widget getHomePage() {
    if(_homePage == null){
      _homePage = new HomePage(_user);
    }
    return _homePage;
  }

  Widget getUserInfoPage() {
    if (_userInfoPage == null){
      _userInfoPage = new UserInfoPage(_user);
    }
    return _userInfoPage;
  }
}