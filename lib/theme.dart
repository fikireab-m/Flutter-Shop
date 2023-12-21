import 'package:flutter/material.dart';
import 'package:flutter_shop/consts/colors.dart';

ThemeData themeData = ThemeData(
  colorScheme: ThemeData().colorScheme.copyWith(
        secondary: lightIconsColor,
        brightness: Brightness.light,
        background: lightBackgroundColor,
      ),
  useMaterial3: true,
  scaffoldBackgroundColor: lightScaffoldColor,
  primaryColor: lightCardColor,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: lightIconsColor,
    ),
    backgroundColor: lightScaffoldColor,
    centerTitle: true,
    titleTextStyle: TextStyle(
        color: lightTextColor, fontSize: 22, fontWeight: FontWeight.bold),
    elevation: 0,
  ),
  iconTheme: IconThemeData(
    color: lightIconsColor,
  ),

  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blue,
    // selectionHandleColor: Colors.blue,
  ),
  // textTheme: TextTheme()
  // textTheme: Theme.of(context).textTheme.apply(
  //       bodyColor: Colors.black,
  //       displayColor: Colors.black,
  //     ),
  cardColor: lightCardColor,
  brightness: Brightness.light,
);
