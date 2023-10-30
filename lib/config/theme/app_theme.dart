import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();

  ThemeData getThemeDarck() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff5ca0d3),
          primary: const Color(0xff5ca0d3),
          secondary: Colors.white,
          background: const Color(0xFF2B3848),
          primaryContainer: const Color.fromARGB(255, 134, 183, 221),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      );

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff5ca0d3),
          primary: const Color.fromARGB(255, 159, 189, 211),
          secondary: const Color(0xFF2B3848),
          background: const Color.fromARGB(255, 213, 224, 242),
          primaryContainer: const Color.fromARGB(255, 134, 183, 221),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      );
}
