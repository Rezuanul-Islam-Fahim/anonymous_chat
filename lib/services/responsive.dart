import 'package:flutter/material.dart';

// This class will handle responsive UI design service
class Responsive {
  Responsive(this.mediaQuery);

  final MediaQueryData mediaQuery;

  double width(double width) {
    double deviceWidth = mediaQuery.size.width;
    return deviceWidth > 500 ? width : deviceWidth;
  }

  EdgeInsetsGeometry marginByPortion({
    double leftPortion = 0,
    double topPortion = 0,
    double rightPortion = 0,
    double bottomPortion = 0,
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    double deviceWidth = mediaQuery.size.width;
    return deviceWidth > 500
        ? EdgeInsets.fromLTRB(
            deviceWidth * leftPortion,
            deviceWidth * topPortion,
            deviceWidth * rightPortion,
            deviceWidth * bottomPortion,
          )
        : EdgeInsets.fromLTRB(left, top, right, bottom);
  }
}
