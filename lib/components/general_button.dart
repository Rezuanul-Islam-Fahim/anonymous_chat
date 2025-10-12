import 'package:flutter/material.dart';

// This is the general button widget for this app. This widget(button)
// is used in login, regiser and change-password screen
class GeneralButton extends StatelessWidget {
  const GeneralButton(this.label, this.handler);

  final String label;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => handler(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, letterSpacing: 0.5),
        ),
      ),
    );
  }
}
