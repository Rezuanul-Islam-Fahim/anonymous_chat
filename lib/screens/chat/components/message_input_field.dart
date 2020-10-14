import 'package:flutter/material.dart';

// Message input field widget for chat screen
class MessageInputField extends StatelessWidget {
  const MessageInputField(this._messageController, this._handler);

  final TextEditingController _messageController;
  final Function _handler;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 5),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(30),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  width: 0.7,
                  color: Colors.grey[300],
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  width: 1.2,
                  color: Colors.grey[350],
                ),
              ),
              hintText: 'Enter your message.....',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.textsms),
              ),
            ),
            controller: _messageController,
            onSubmitted: (_) => _handler(),
          ),
        ),
      ),
    );
  }
}
