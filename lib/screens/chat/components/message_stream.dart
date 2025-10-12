import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:anonymous_chat/models/user.dart';
import 'package:anonymous_chat/models/message.dart';
import 'package:anonymous_chat/screens/chat/components/image_message.dart';
import 'package:anonymous_chat/screens/chat/components/text_message.dart';

// Message stream-builder widget
class MessageStream extends StatelessWidget {
  MessageStream(this.userData, this.messageScroll, this.msgLimit);

  final UserM userData;
  final ScrollController messageScroll;
  final int msgLimit;
  final CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: messageCollection
            .orderBy('timendate', descending: true)
            .limit(msgLimit)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // If snapshot has no data, then show circular loader
          // untll data loads
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> messageDocs = snapshot.data.docs;

          // Messages list builder
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 5),
            controller: messageScroll,
            reverse: true,
            itemCount: messageDocs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot message = messageDocs[index];

              return message.get('isImage')
                  ? ImageMessage(
                      Message(
                        text: message.get('text'),
                        fromName: message.get('fromName'),
                        fromEmail: message.get('fromEmail'),
                        timendate: message.get('timendate'),
                        isImage: message.get('isImage'),
                      ),
                      message.get('fromEmail') == userData.email,
                    )
                  : TextMessage(
                      Message(
                        text: message.get('text'),
                        fromName: message.get('fromName'),
                        fromEmail: message.get('fromEmail'),
                        timendate: message.get('timendate'),
                        isImage: message.get('isImage'),
                      ),
                      message.get('fromEmail') == userData.email,
                    );
            },
          );
        },
      ),
    );
  }
}
