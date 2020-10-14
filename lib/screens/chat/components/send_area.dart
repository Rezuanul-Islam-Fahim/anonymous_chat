import 'package:flutter/material.dart';

import 'package:anonymous_chat/screens/chat/components/message_input_field.dart';

// Chat screen's widget for building send-area
class SendArea extends StatelessWidget {
  SendArea(
    this._messageController,
    this._sendMessageHandler,
    this._sendImageHandler,
  );

  final TextEditingController _messageController;
  final Function _sendMessageHandler;
  final Function _sendImageHandler;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 10, 15),
      child: Row(
        children: <Widget>[
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.photo),
            iconSize: 28,
            splashRadius: 20,
            onPressed: _sendImageHandler,
          ),
          MessageInputField(_messageController, _sendMessageHandler),
          Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(30),
            elevation: 5,
            color: Theme.of(context).primaryColor,
            type: MaterialType.button,
            child: IconButton(
              icon: Icon(Icons.send),
              iconSize: 25,
              color: Colors.white,
              padding: EdgeInsets.all(12),
              onPressed: _sendMessageHandler,
            ),
          ),
        ],
      ),
    );
  }
}
