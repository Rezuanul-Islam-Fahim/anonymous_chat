import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/responsive.dart';

// Text message widget for chat screen
class TextMessage extends StatelessWidget {
  const TextMessage(this._text, this._from, this._isMe);

  final String _text;
  final String _from;
  final bool _isMe;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    return Container(
      margin: _isMe
          ? Responsive(_mediaQuery).marginByPortion(
              leftPortion: 0.45,
              left: 60,
            )
          : Responsive(_mediaQuery).marginByPortion(
              rightPortion: 0.45,
              right: 60,
            ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      alignment: _isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (!_isMe)
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Text(
                _from,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: _isMe ? Theme.of(context).primaryColor : Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: _isMe ? Radius.circular(20) : Radius.zero,
                bottomRight: !_isMe ? Radius.circular(20) : Radius.zero,
              ),
            ),
            child: Text(
              _text,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
