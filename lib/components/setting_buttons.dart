import 'package:flutter/material.dart';

class SettingButtons extends StatelessWidget {
  final dynamic icon;
  final String label;
  final Function handler;

  SettingButtons(this.icon, this.label, this.handler);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey[350],
      onTap: handler,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 25, color: Colors.grey[700]),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}