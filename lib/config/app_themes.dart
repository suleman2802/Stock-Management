import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: const Color.fromARGB(255, 197, 204, 248),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      hintStyle: TextStyle(
        fontSize: 12,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
      titleSmall: TextStyle(
        color: Color(0xFF0B56C4),
        fontSize: 18,
      ),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 18),
      displayLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color(0xFF0B56C4),
      surface: const Color(0xfff3f4fa),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
      backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF0B56C4)),
    )),
    //s useMaterial3: true,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      actionsIconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      color: Color(0xFF0B56C4),
      //s foregroundColor: Colors.white,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF0B56C4),
      actionTextColor: Colors.white,
    ),
    cardColor: const Color(0xFFF6F7F9),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(50, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),

    cardTheme: const CardTheme(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF0B56C4),
    ),
    // iconButtonTheme: IconButtonThemeData(
    //   style: ButtonStyle(
    //     iconColor: WidgetStateProperty.all(Color(0xFF0B56C4)),
    //   ),
    // ),
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   backgroundColor: Color(0xFF0B56C4),
    //   selectedItemColor: Colors.white,
    //   unselectedItemColor: Colors.black,
    // ),
  );

  static final darkTheme = ThemeData(
    primaryColor: const Color(0xFF0B56C4),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    canvasColor: const Color.fromARGB(255, 197, 204, 248),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
      titleSmall: TextStyle(
        color: Color(0xFF0B56C4),
        fontSize: 18,
      ),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 18),
      displayLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xFF0B56C4),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
      backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF0B56C4)),
    )),
    //s useMaterial3: true,
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      color: Color(0xFF0B56C4),
      //s foregroundColor: Colors.white,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF0B56C4),
      actionTextColor: Colors.white,
    ),
    cardColor: null, //const Color.fromARGB(255, 166, 167, 169),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(50, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 12,
      ),
    ),
    cardTheme: const CardTheme(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      //margin: EdgeInsets.all(20),
    ),
  );
}
