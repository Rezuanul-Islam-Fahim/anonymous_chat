import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class FlushMessage {
  FlushMessage({
    this.title,
    this.message,
    this.icon,
    this.color,
  });

  final String title;
  final String message;
  final IconData icon;
  final Color color;

  void show(BuildContext context) {
    Flushbar(
      title: title != null ? title : null,
      message: message,
      icon: Icon(icon, size: 30, color: color),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(20, 15, 15, 15),
      borderRadius: 10,
      duration: Duration(seconds: 5),
      boxShadows: <BoxShadow>[
        BoxShadow(
          color: Colors.black45,
          blurRadius: 5,
          spreadRadius: 2,
        ),
      ],
    )..show(context);
  }
}
