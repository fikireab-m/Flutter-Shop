import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/colors.dart';

ThemeData themeData = ThemeData(
  colorScheme: ThemeData().colorScheme.copyWith(
        secondary: ColorConst.lightIconsColor,
        brightness: Brightness.light,
        background: ColorConst.lightBackgroundColor,
      ),
  useMaterial3: true,
  scaffoldBackgroundColor: ColorConst.lightScaffoldColor,
  primaryColor: ColorConst.lightCardColor,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: ColorConst.lightIconsColor,
    ),
    backgroundColor: ColorConst.lightScaffoldColor,
    centerTitle: true,
    titleTextStyle: TextStyle(
        color: ColorConst.lightTextColor,
        fontSize: 22,
        fontWeight: FontWeight.bold),
    elevation: 0,
  ),
  iconTheme: const IconThemeData(
    color: ColorConst.lightIconsColor,
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
  cardColor: ColorConst.lightCardColor,
  brightness: Brightness.light,
);
