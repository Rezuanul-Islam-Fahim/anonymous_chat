import 'package:flutter/material.dart';

class SettingButtons extends StatelessWidget {
  SettingButtons(this.icon, this.label, this.handler);

  final IconData icon;
  final String label;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey[300],
      onTap: handler,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 25, color: Colors.grey[700]),
            SizedBox(width: 15),
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
