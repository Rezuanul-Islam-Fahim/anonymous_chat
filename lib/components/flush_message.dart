import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

// This class will handle flush-message service
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

  // This handler will show Flush-message to provided context
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
          color: Colors.black54,
          offset: Offset(2, 2),
          blurRadius: 4,
          spreadRadius: 1,
        ),
      ],
    )..show(context);
  }
}
