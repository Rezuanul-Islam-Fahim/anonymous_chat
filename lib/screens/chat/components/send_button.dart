import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  SendButton(this._icon, this._handler);

  final IconData _icon;
  final Function _handler;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(30),
      elevation: 5,
      color: Theme.of(context).primaryColor,
      type: MaterialType.button,
      child: IconButton(
        icon: Icon(_icon),
        iconSize: 28,
        color: Colors.white,
        padding: EdgeInsets.all(13),
        onPressed: _handler,
      ),
    );
  }
}
