import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

// This class will handle flush-message service
class FlushMessage {
  const FlushMessage({
    this.title,
    required this.message,
    required this.icon,
    required this.color,
  });

  final String? title;
  final String message;
  final IconData icon;
  final Color color;

  // This handler will show Flush-message to provided context
  void show(BuildContext context) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(icon, size: 30, color: color),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
      borderRadius: BorderRadius.circular(10),
      duration: const Duration(seconds: 5),
      boxShadows: const <BoxShadow>[
        BoxShadow(
          color: Colors.black54,
          offset: Offset(2, 2),
          blurRadius: 4,
          spreadRadius: 1,
        ),
      ],
    ).show(context);
  }
}
