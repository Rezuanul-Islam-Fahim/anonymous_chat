import 'package:flutter/material.dart';

// Send message input field widget for chat screen
class MessageInputField extends StatelessWidget {
  const MessageInputField(this._messageController, this._handler);

  final TextEditingController _messageController;
  final Function _handler;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 42,
        padding: const EdgeInsets.only(right: 8),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 0.6,
                color: Colors.grey[300].withOpacity(0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey[300].withOpacity(0.7),
              ),
            ),
            hintText: 'Enter your text...',
            hintStyle: TextStyle(fontSize: 15),
            prefixIcon: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(Icons.textsms_outlined, size: 19),
            ),
          ),
          controller: _messageController,
          onSubmitted: (_) => _handler(),
        ),
      ),
    );
  }
}
