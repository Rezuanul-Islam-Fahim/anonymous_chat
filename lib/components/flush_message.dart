import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

// This class will handle flush-message service
class FlushMessage {
  const FlushMessage({
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
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
      borderRadius: 10,
      duration: const Duration(seconds: 5),
      boxShadows: <BoxShadow>[
        const BoxShadow(
          color: Colors.black54,
          offset: const Offset(2, 2),
          blurRadius: 4,
          spreadRadius: 1,
        ),
      ],
    )..show(context);
  }
}
