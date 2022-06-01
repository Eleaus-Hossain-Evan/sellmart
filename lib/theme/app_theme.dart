import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class AppTheme {

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFf7931e),
    backgroundColor: Colors.white,
    hintColor: Color(0xFFEEEEEE),
    accentColor: Color(0xFF0cb1d2),
    dialogBackgroundColor: Color(0xFF01cc72),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 4.375 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black), //headline1, 35
      headline2: TextStyle(fontSize: 3.75 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black), //headline2, 30
      headline3: TextStyle(fontSize: 3.25 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black), //headline3, 26
      headline4: TextStyle(fontSize: 2.875 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black), //headline4, 23
      headline5: TextStyle(fontSize: 2.625 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black), //headline5, 21
      headline6: TextStyle(fontSize: 2.5 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black), //headline6, 20
      subtitle1: TextStyle(fontSize: 2.375 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black), //subtitle1, 19
      subtitle2: TextStyle(fontSize: 2.125 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w500, color: Colors.black), //subtitle2, 17
      bodyText1: TextStyle(fontSize: 2 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: Colors.black), //body2, 16
      bodyText2: TextStyle(fontSize: 2 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black), //body1, 16
      caption: TextStyle(fontSize: 2.25 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black), //caption, 18
      button: TextStyle(fontSize: 2.3 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w500, color: Colors.black), //button, 22
      overline: TextStyle(fontSize: 1.875 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.black), //overline, 15
    ),
  );


  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFFf7931e),
    backgroundColor: Color(0xff2F2F2F),
    hintColor: Color(0xFFEEEEEE),
    accentColor: Color(0xFF0cb1d2),
    dialogBackgroundColor: Color(0xFF01cc72),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 4.375 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.white), //headline1, 35
      headline2: TextStyle(fontSize: 3.75 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.white), //headline2, 30
      headline3: TextStyle(fontSize: 3.25 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.white), //headline3, 26
      headline4: TextStyle(fontSize: 2.875 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.white), //headline4, 23
      headline5: TextStyle(fontSize: 2.625 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.white), //headline5, 21
      headline6: TextStyle(fontSize: 2.5 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.white), //headline6, 20
      subtitle1: TextStyle(fontSize: 2.375 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.white), //subtitle1, 19
      subtitle2: TextStyle(fontSize: 2.125 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w500, color: Colors.white), //subtitle2, 17
      bodyText1: TextStyle(fontSize: 2 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: Colors.white), //body2, 16
      bodyText2: TextStyle(fontSize: 2 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.white), //body1, 16
      caption: TextStyle(fontSize: 2.25 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.white), //caption, 18
      button: TextStyle(fontSize: 2.3 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w500, color: Colors.white), //button, 22
      overline: TextStyle(fontSize: 1.875 * SizeConfig.textSizeMultiplier, fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.white), //overline, 15
    ),
  );
}