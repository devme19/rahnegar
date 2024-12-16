import 'package:flutter/material.dart';

Color lightPrimaryColor = const Color(0xff182D7A);
Color? darkGrey = Colors.grey[850];
Color? appBarLightColor = Colors.white;
Color flexibleSpaceLightColor = Color.lerp(Color(0xff312783), Colors.white, 0.9)!;
Color flexibleSpaceDarkColor = Color.lerp(Colors.grey[800], Colors.white, 0.1)!;

Color? appBarDarkColor = Colors.grey[800];
class AppThemes {
  static ThemeData light(String languageCode) => ThemeData(
    fontFamily: languageCode=='fa'?'iranYekan':'roboto',
    appBarTheme: AppBarTheme(
      color:  appBarLightColor, // Light theme AppBar color
      iconTheme: IconThemeData(color: Colors.white), // Icons color for light theme
      titleTextStyle: TextStyle(color: Colors.black), // Title text color for light theme
    ),
    primaryColor: lightPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: lightPrimaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Adjust border radius as needed
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black54,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 15.0, color: Colors.black),
      labelMedium: TextStyle(fontSize: 15.0, color: Color(0xffA09CAB)),
      bodyMedium: TextStyle(fontSize: 15.0, color: Color(0xffA09CAB)),
      bodyLarge: TextStyle(fontSize: 18.0, color: Colors.black54),
      bodySmall: TextStyle(fontSize: 12.0),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.black,
      iconColor: Colors.black,
      tileColor: Colors.white,
    ),
  );

  static ThemeData dark(String languageCode) => ThemeData(
    fontFamily: languageCode=='fa'?'iranYekan':'roboto',
    appBarTheme: AppBarTheme(
      color:  appBarDarkColor, // Light theme AppBar color
      iconTheme: IconThemeData(color: Colors.white70), // Icons color for light theme
      titleTextStyle: TextStyle(color: Colors.black), // Title text color for light theme
    ),
    scaffoldBackgroundColor: Colors.grey[850],
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 15.0, color: Colors.grey),
      labelMedium: TextStyle(fontSize: 15.0, color: Color(0xffA09CAB)),
      bodyMedium: TextStyle(fontSize: 15.0, color: Color(0xffA09CAB)),
      bodyLarge: TextStyle(fontSize: 18.0, color: Colors.white),
      bodySmall: TextStyle(fontSize: 12.0),
    ),
    listTileTheme:  ListTileThemeData(
      textColor: Colors.grey,
      iconColor: Colors.blue,
      tileColor: darkGrey,
    ),
  );
}

