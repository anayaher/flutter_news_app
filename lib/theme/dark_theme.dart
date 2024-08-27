import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  
  // Customize dark theme here
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  scaffoldBackgroundColor: Colors.black54,
  primaryColor: Colors.tealAccent,

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
    bodySmall: TextStyle(color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey[800],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide.none,
    ),
    filled: true,
  ),
);
