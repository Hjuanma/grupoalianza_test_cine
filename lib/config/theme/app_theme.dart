import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkmode;

  AppTheme({this.isDarkmode = false});

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkmode ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff2862F5),
        primary: const Color(0xff5ca0d3),
        secondary: const Color(0xFF2B3848),
        primaryContainer: Color.fromARGB(255, 134, 183, 221),
      ),
      appBarTheme: const AppBarTheme(centerTitle: true));

  AppTheme copyWith({bool? isDarkmode}) =>
      AppTheme(isDarkmode: isDarkmode ?? this.isDarkmode);
}
