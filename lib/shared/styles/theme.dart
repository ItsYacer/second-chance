import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



Color darkColor =Colors.black;
Color lightColor =Colors.white;

ThemeData darkTheme =  ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: darkColor,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: darkColor,
      elevation: 0.0,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.white,
      elevation: 20.0,
      backgroundColor:darkColor,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.deepOrange,
      ),
    ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.redAccent,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.redAccent,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.redAccent,
    ),
  ),
);
