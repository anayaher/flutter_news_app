import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
          // Customize light theme here
          appBarTheme: const  AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.teal,

          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black54),
            bodySmall: TextStyle(color: Colors.black),
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            filled: true,
          ),
        );
