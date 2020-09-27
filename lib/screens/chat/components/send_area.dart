import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:anonymous_chat/screens/chat/components/message_input_field.dart';

class SendArea extends StatelessWidget {
  SendArea({
    this.messageController,
    this.messageScroll,
    this.user,
    this.userDetails,
    this.handler,
  });

  final User user;
  final Map<String, String> userDetails;
  final Function handler;
  final ScrollController messageScroll;
  final TextEditingController messageController;

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
            icon: Icon(Icons.send_outlined),
            iconSize: 28,
            onPressed: handler,
          ),
        ],
      ),
    );
  }
}
