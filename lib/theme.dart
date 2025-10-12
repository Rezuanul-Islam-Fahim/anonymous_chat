import 'package:flutter/material.dart';

// App's default theme
ThemeData get appTheme => ThemeData(
      primarySwatch: Colors.blueGrey,
      appBarTheme: AppBarTheme(
        titleTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            displayLarge: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
            displayMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
            displaySmall: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
            headlineMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Colors.black87.withValues(alpha: 0.75),
            ),
            bodyMedium: const TextStyle(fontSize: 12),
          ),
    );
