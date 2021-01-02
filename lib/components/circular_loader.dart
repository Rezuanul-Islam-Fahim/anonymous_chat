import 'package:flutter/material.dart';

// This Circular loader is used in login, register, change-password,
// and chat screen(when sending images)
class Loader extends StatelessWidget {
  const Loader(this.loadingText);

  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.92),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
          const SizedBox(height: 20),
          Text(
            loadingText,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
