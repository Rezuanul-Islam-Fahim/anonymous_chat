import 'package:flutter/material.dart';

// Message widget for chat screen
class Message extends StatelessWidget {
  const Message(this._text, this._from, this._isMe);

  final String _text;
  final String _from;
  final bool _isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _isMe ? EdgeInsets.only(left: 110) : EdgeInsets.only(right: 110),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: _isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (!_isMe)
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: Text(
                _from,
                style: TextStyle(fontSize: 13),
              ),
            ),
          if (!_isMe) SizedBox(height: 1),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
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
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
