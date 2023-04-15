import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wheather_app/consts/colors.dart';

class WeatherTheme{


  static final lightTheme=ThemeData(
   cardColor: Colors.white,
    fontFamily: "poppins",
    iconTheme: IconThemeData(
      color: Vx.gray600
    ),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Vx.gray800
  );
   static final darkTheme=ThemeData(
    cardColor: bgColor.withOpacity(0.4),
    fontFamily: "poppins",
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    scaffoldBackgroundColor: bgColor,
    primaryColor: Colors.white
  );
}
