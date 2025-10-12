import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/responsive.dart';
import 'package:anonymous_chat/screens/chat/components/message_input_field.dart';

// Chat screen's widget for building send-area
class SendArea extends StatelessWidget {
  const SendArea(
    this.messageController,
    this.sendMessageHandler,
    this.sendImageHandler,
  );

  final TextEditingController messageController;
  final VoidCallback sendMessageHandler;
  final VoidCallback sendImageHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
      alignment: Alignment.center,
      child: SizedBox(
        width: Responsive(MediaQuery.of(context)).width(450),
        child: Row(
          children: <Widget>[
            Container(
              width: 38,
              padding: const EdgeInsets.only(left: 5),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.insert_photo_outlined),
                iconSize: 22,
                splashRadius: 13,
                onPressed: sendImageHandler,
              ),
            ),
            MessageInputField(messageController, sendMessageHandler),
            SizedBox(
              width: 45,
              height: 45,
              child: Material(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(30),
                elevation: 3,
                color: Theme.of(context).primaryColor,
                type: MaterialType.button,
                child: IconButton(
                  icon: const Icon(Icons.send_rounded),
                  iconSize: 22,
                  color: Colors.white,
                  onPressed: sendMessageHandler,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
