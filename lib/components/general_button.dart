import 'package:flutter/material.dart';

// This is the general button widget for this app. This widget(button)
// is used in login, regiser and change-password screen
class GeneralButton extends StatelessWidget {
  GeneralButton(this.label, this.handler);

  final String label;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          label,
          style: TextStyle(fontSize: 16, letterSpacing: 0.5),
        ),
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: handler,
      ),
    );
  }
}
