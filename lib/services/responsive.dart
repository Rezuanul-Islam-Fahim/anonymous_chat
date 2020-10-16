import 'package:flutter/material.dart';

class Responsive {
  Responsive(this.mediaQuery);

  final MediaQueryData mediaQuery;

  double width() {
    return mediaQuery.size.width > 450 ? 400 : mediaQuery.size.width;
  }
}
