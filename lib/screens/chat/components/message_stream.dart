import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:anonymous_chat/screens/chat/components/message.dart';

// Message stream-builder widget
class MessageStream extends StatelessWidget {
  MessageStream(this._userData, this._messageScroll, this._msgLimit);

  final Map<String, dynamic> _userData;
  final ScrollController _messageScroll;
  final int _msgLimit;
  final CollectionReference _messageCollection =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _messageCollection
            .orderBy('timendate', descending: true)
            .limit(_msgLimit)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // If snapshot has no data, then show loader
          // untll data loads
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> _messages = snapshot.data.docs;

          // Messages list builder
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 5),
            controller: _messageScroll,
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot _message = _messages[index];

              return Message(
                _message.get('text'),
                _message.get('fromName'),
                _message.get('fromEmail') == _userData['email'],
              );
            },
          );
        },
      ),
    );
  }
}
