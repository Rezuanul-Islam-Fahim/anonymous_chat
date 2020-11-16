import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/responsive.dart';
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
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
      alignment: Alignment.center,
      child: Container(
        width: Responsive(MediaQuery.of(context)).width(450),
        child: Row(
          children: <Widget>[
            Container(
              width: 38,
              padding: EdgeInsets.only(left: 5),
              child: IconButton(
                padding: EdgeInsets.all(0),
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.insert_photo_outlined),
                iconSize: 22,
                splashRadius: 13,
                onPressed: _sendImageHandler,
              ),
            ),
            MessageInputField(_messageController, _sendMessageHandler),
            Container(
              width: 45,
              height: 45,
              child: Material(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(30),
                elevation: 3,
                color: Theme.of(context).primaryColor,
                type: MaterialType.button,
                child: IconButton(
                  icon: Icon(Icons.send_rounded),
                  iconSize: 22,
                  color: Colors.white,
                  onPressed: _sendMessageHandler,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
