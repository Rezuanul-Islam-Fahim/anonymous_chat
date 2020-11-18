import 'package:flutter/material.dart';

// App's default theme
ThemeData get appTheme => ThemeData(
      primarySwatch: Colors.blueGrey,
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontSize: 18,
                  ),
                ),
          ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline2: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
            headline3: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
            headline4: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
            bodyText1: TextStyle(
              fontSize: 16,
              color: Colors.black87.withOpacity(0.75),
            ),
            bodyText2: TextStyle(fontSize: 12),
          ),
    );
