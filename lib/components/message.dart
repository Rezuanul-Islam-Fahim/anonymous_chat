import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String _text;
  final String _from;
  final bool _isMe;

  const Message(this._text, this._from, this._isMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _isMe ? EdgeInsets.only(left: 110) : EdgeInsets.only(right: 110),
      padding: EdgeInsets.all(10),
      alignment: _isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (!_isMe)
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: Text(_from),
            ),
          if (!_isMe) SizedBox(height: 3),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: _isMe ? Theme.of(context).primaryColor : Colors.black87,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              _text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
