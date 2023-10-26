import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkmode;

  AppTheme({this.isDarkmode = false});

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkmode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: const Color(0xff2862F5),
      appBarTheme: const AppBarTheme(centerTitle: true));

  AppTheme copyWith({bool? isDarkmode}) =>
      AppTheme(isDarkmode: isDarkmode ?? this.isDarkmode);
}
