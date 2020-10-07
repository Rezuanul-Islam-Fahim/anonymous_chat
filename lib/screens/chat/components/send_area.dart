import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:anonymous_chat/screens/chat/components/message_input_field.dart';

// Chat screen's widget for building send-area
class SendArea extends StatelessWidget {
  SendArea(this._userData, this._messageScroll);

  final Map<String, dynamic> _userData;
  final ScrollController _messageScroll;
  final TextEditingController _messageController = TextEditingController();

  // This handler will be used for storing message to database
  Future<void> _sendMessage() async {
    if (_messageController.text.length > 0) {
      // Store message
      await FirebaseFirestore.instance.collection('messages').add({
        'text': _messageController.text,
        'fromName': _userData['name'],
        'fromEmail': _userData['email'],
        'timendate': DateTime.now().toIso8601String(),
      });

      // Clear text field after storing message
      _messageController.clear();

      // Animate to max scroll extent of messages stream-builder
      // after storing message to database
      _messageScroll.animateTo(
        _messageScroll.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          MessageInputField(_messageController, _sendMessage),
          Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(30),
            elevation: 5,
            color: Theme.of(context).primaryColor,
            type: MaterialType.button,
            child: IconButton(
              icon: Icon(Icons.send),
              iconSize: 28,
              color: Colors.white,
              padding: EdgeInsets.all(13),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
