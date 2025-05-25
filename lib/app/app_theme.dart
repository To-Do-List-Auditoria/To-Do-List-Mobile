import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green[900],
      foregroundColor: Colors.grey[200],
    ),
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.dark,
      surface: Colors.grey[200],
      primary: Colors.green[900],
      secondary: Colors.green[900],
    ),
    cardTheme: CardTheme(
      color: Colors.grey[200],
      elevation: 8.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[900],
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.black),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.black),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
  );
}
