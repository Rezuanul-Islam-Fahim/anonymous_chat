import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class FlashMessage extends StatelessWidget {
  final String title;
  final String message;
  final Icon icon;
  final BuildContext ctx;

  FlashMessage({this.title, this.message, this.icon, this.ctx});

  @override
  Widget build(BuildContext context) {
    return Flushbar(
      title: 'title',
      message: 'message',
      icon: Icon(Icons.ad_units),
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
