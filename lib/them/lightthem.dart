import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    primary: Colors.blue,
    secondary: Colors.yellow,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 109, 176, 231),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color.fromARGB(255, 109, 176, 231),
      selectedIconTheme: IconThemeData(color: Colors.blue)),
  cardTheme: CardTheme(
    shadowColor: Colors.yellow[200],
  ),
  listTileTheme: ListTileThemeData(
    iconColor: Colors.black,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Color.fromARGB(255, 31, 98, 131),
  ),
);
