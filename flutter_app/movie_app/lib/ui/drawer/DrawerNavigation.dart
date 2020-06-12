import 'package:flutter/material.dart';
import 'package:movie_app/blocs/DrawerNavigationBloc.dart';
import 'package:movie_app/models/User.dart';
import 'package:movie_app/ui/items/DrawerItem.dart';
import 'package:movie_app/ui/screens/HomePage.dart';

class DrawerNavigation extends StatefulWidget{
  User user;

  DrawerNavigation(this.user);

  @override
  DrawerNavigationState createState() => DrawerNavigationState();

}

class DrawerNavigationState extends State<DrawerNavigation>{
  DrawerNavigationBloc _bloc = new DrawerNavigationBloc();

  @override
  Widget build(BuildContext context) {
    _bloc.setUser(widget.user);

    List<Widget> drawerOptions = new List<Widget>();

    for(int i = 0; i < _bloc.options.length; i++){
      drawerOptions.add(
        GestureDetector(
          child: DrawerItem(_bloc.options[i]["icon"], _bloc.options[i]["title"], i==_bloc.indexSelected),
          onTap: (){
            setState(() {
              _bloc.onItemSelected(i);
              Navigator.of(context).pop();
            });
          },
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2d3450),
        title: Center(child: Text(_bloc.options[_bloc.indexSelected]["title"])),
        actions: _bloc.indexSelected==0? <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              _bloc.showSearchPage(context);
            },
          )
        ] : [IconButton(icon: Icon(null),)],
      ),

      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2d3450)
              ),
              accountName: Text("Nguyen Tien Dat"),
              accountEmail: Text("datnt.148@gmail.com"),
            ),
            Column(
              children: drawerOptions,
            )
          ],
        ),
      ),
      body: _bloc.getUI(_bloc.indexSelected),
    );
  }

}