import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget{
  Color _colorDark = Color(0xFF2d3447);
  IconData _icon;
  String _title;
  bool _selected;


  DrawerItem(this._icon, this._title, this._selected);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: (_selected) ? _colorDark : null,
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: 50,
            child: Icon(
              _icon,
              size: 30,
              color: (_selected) ? Colors.white : _colorDark,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              _title,
              style: TextStyle(
                fontSize: 16,
                color: (_selected) ? Colors.white : _colorDark,
              ),
            ),
          )
        ],
      ),
    );
  }

}