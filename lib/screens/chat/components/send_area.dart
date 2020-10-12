import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:anonymous_chat/screens/chat/components/send_button.dart';
import 'package:anonymous_chat/screens/chat/components/message_input_field.dart';

// Chat screen's widget for building send-area
class SendArea extends StatelessWidget {
  SendArea(this._userData);

  final Map<String, dynamic> _userData;
  final TextEditingController _messageController = TextEditingController();

  // This handler will be used for storing message to database
  Future<void> _sendMessage() async {
    if (_messageController.text.length > 0) {
      // Store message to a new variable
      String _message = _messageController.text;

      // Clear text field before storing message
      _messageController.clear();

      // Store message
      await FirebaseFirestore.instance.collection('messages').add({
        'text': _message,
        'fromName': _userData['name'],
        'fromEmail': _userData['email'],
        'timendate': DateTime.now().toIso8601String(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          SendButton(Icons.photo, () {}),
          MessageInputField(_messageController, _sendMessage),
          SendButton(Icons.send, _sendMessage),
        ],
      ),
    );
  }
}
