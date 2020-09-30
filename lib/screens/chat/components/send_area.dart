import 'package:flutter/material.dart';

import 'package:anonymous_chat/screens/chat/components/message_input_field.dart';

// Chat screen's widget for building send-area
class SendArea extends StatelessWidget {
  SendArea(this.messageController, this.handler);

  final TextEditingController messageController;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 12,
        bottom: 12,
        left: 12,
        right: 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(0, -2),
            blurRadius: 2.8,
            spreadRadius: 0.4,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          MessageInputField(messageController, handler),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 28,
            onPressed: handler,
          ),
        ],
      ),
    );
  }
}
