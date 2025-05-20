// import 'package:flutter/material.dart';

// final lightTheme = ThemeData(
//   // brightness: Brightness.light,
//   primaryColor: Color(0xf1b8dda),
//   // secondaryHeaderColor: const Color(194,187,111),
//   appBarTheme: AppBarTheme(
//     color: Color.fromARGB(15, 132, 152, 165),
//     // backgroundColor: Colors.blue,
//   ),
//   drawerTheme: DrawerThemeData(
//     backgroundColor: Colors.yellow[400],
//   ),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: Color.fromARGB(255, 246, 251, 255),
//       selectedItemColor: Colors.yellow[300],
//       unselectedItemColor: Colors.black54),
//   // colorScheme: const ColorScheme.light(
//   //   background: Colors.white,
//   //   // primary: Colors.blue,
//   //   // secondary: Colors.yellow,
//   // )
// );

// final darkTheme = ThemeData(
//     primaryColor: const Color.fromARGB(255, 31, 98, 131),
//     appBarTheme: AppBarTheme(
//       color: Colors.blue,
//     ),
//     cardTheme: CardTheme(
//       color: Colors.yellow[300],
//     ),
//     cardColor: Colors.yellow[300],
//     listTileTheme: ListTileThemeData(
//       selectedColor: Colors.blue,
//       iconColor: Colors.yellow[300],
//     ),
//     buttonTheme: ButtonThemeData(buttonColor: Colors.yellow[300]),
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: Color.fromARGB(255, 31, 98, 131),
//       selectedItemColor: Colors.yellow[300],
//       unselectedItemColor: Colors.black54,
//     ));

import 'package:flutter/material.dart';

// الألوان التي سيتم استخدامها في الثيمات
const Color lightPrimaryColor = Color(0x0f3f72af);
const Color lightAccentColor = Colors.blueAccent;
const Color lightBackgroundColor = Colors.white;
const Color lightTextColor = Colors.black;

const Color darkPrimaryColor = Color.fromARGB(15, 105, 119, 127);
const Color darkAccentColor = Colors.orangeAccent;
const Color darkBackgroundColor = Color.fromARGB(15, 148, 172, 185);
const Color darkTextColor = Colors.white;

// تخصيص الـ ThemeData للوضع النهاري
final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: lightPrimaryColor,
  hintColor: lightAccentColor,
  scaffoldBackgroundColor: lightPrimaryColor,
  appBarTheme: AppBarTheme(color: lightPrimaryColor),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: lightTextColor),
    bodyMedium: TextStyle(color: lightTextColor),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightPrimaryColor,
    selectedItemColor: lightPrimaryColor,
    unselectedItemColor: Colors.black54,
  ),
  // iconTheme: IconThemeData(color: Colors.yellow)
);

// تخصيص الـ ThemeData للوضع الليلي
final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: darkPrimaryColor,
  hintColor: darkAccentColor,
  scaffoldBackgroundColor: darkPrimaryColor,
  appBarTheme: AppBarTheme(color: darkPrimaryColor),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: darkTextColor),
    bodyMedium: TextStyle(color: darkTextColor),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkBackgroundColor,
    selectedItemColor: darkPrimaryColor,
    unselectedItemColor: Colors.white60,
  ),
);
