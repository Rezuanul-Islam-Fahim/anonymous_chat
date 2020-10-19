import 'package:flutter/material.dart';

// Register screen's back-button widget
class RegisterBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 45, left: 15),
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        iconSize: 30,
        color: Colors.grey[700],
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
