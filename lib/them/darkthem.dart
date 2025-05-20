import 'package:flutter/material.dart';
import 'package:flutter_application_1/them/app_them.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Colors.blue,
    primary: Colors.yellow,
    secondary: Colors.black54,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: darkPrimaryColor,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  cardTheme: CardTheme(
    shadowColor: Colors.yellow[200],
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 31, 98, 131),
    selectedItemColor: Colors.yellow[300],
    unselectedItemColor: Color.fromARGB(255, 95, 180, 222),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: darkPrimaryColor,
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 87, 97, 103),
);
