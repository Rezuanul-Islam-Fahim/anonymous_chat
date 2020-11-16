import 'package:flutter/material.dart';

// Setting screen's link widget
class Link extends StatelessWidget {
  Link(this.icon, this.label, this.handler);

  final IconData icon;
  final String label;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey[200],
      onTap: handler,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 21, color: Colors.grey[700]),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
