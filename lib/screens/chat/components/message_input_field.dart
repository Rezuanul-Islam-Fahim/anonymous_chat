import 'package:flutter/material.dart';

class MessageInputField extends StatelessWidget {
  const MessageInputField(this._messageController, this._handler);

  final TextEditingController _messageController;
  final Function _handler;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15,
          ),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.7,
              color: Colors.black26,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: Colors.grey[400],
            ),
          ),
          hintText: 'Enter your message.....',
          prefixIcon: Icon(Icons.message),
        ),
        controller: _messageController,
        onSubmitted: (_) => _handler(),
      ),
    );
  }
}
