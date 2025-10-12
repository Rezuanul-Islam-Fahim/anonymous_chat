import 'package:flutter/material.dart';

import 'package:anonymous_chat/models/message.dart';
import 'package:anonymous_chat/services/responsive.dart';

// Text message widget for chat screen
class TextMessage extends StatelessWidget {
  const TextMessage(this.messageData, this.isMe);

  final Message messageData;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      margin: isMe
          ? Responsive(mediaQuery).marginByPortion(
              leftPortion: 0.45,
              left: 60,
            )
          : Responsive(mediaQuery).marginByPortion(
              rightPortion: 0.45,
              right: 60,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                messageData.fromName,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: isMe ? Theme.of(context).primaryColor : Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: isMe ? Radius.circular(20) : Radius.zero,
                bottomRight: !isMe ? Radius.circular(20) : Radius.zero,
              ),
            ),
            child: Text(
              messageData.text,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
