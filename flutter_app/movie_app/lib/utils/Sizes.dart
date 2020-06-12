import 'package:flutter/material.dart';

class DeviceSize{
  static double _width;
  static double _height;
  static Orientation _orientation;

  static void init(BuildContext context){
    var screenSize = MediaQuery.of(context);

    DeviceSize._width = screenSize.size.width;
    DeviceSize._height = screenSize.size.height;
    DeviceSize._orientation = screenSize.orientation;
  }

  static double getWidth(){
    if (_orientation == Orientation.portrait){
      return DeviceSize._width;
    }
    return DeviceSize._height;
  }

  static double getHeight(){
    if (_orientation == Orientation.portrait){
      return DeviceSize._height;
    }
    return DeviceSize._width;
  }

  static Orientation getOrientation(){
    return DeviceSize._orientation;
  }
}