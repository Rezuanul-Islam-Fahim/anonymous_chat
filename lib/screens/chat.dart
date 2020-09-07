import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../components/message.dart';

class ChatScreen extends StatefulWidget {
  final UserCredential _loggedUser;

  ChatScreen(this._loggedUser);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _messagesScroll = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.reference().child('messages');

  Future<void> _sendMessage() async {
    if (_messageController.text.length > 0) {
      await _dbRef.push().set({
        'text': _messageController.text,
        'from': widget._loggedUser.user.email,
        'timendate': DateTime.now().toIso8601String(),
      });

      _messageController.clear();
    }
  }

  var dummyData = [
    {
      'text': 'Hello Fahim',
      'from': 'Fahim',
      'me': true,
    },
    {
      'text': 'Fahim',
      'from': 'Rezuanul Fahim',
      'me': false,
    },
    {
      'text': 'Istiaq',
      'from': 'Rezuanul',
      'me': false,
    },
    {
      'text': 'Hello Rezuan',
      'from': 'Niloy',
      'me': false,
    },
    {
      'text': 'Rezuanul Islam Fahim',
      'from': 'Fardous',
      'me': false,
    },
    {
      'text': 'Hello Niloy',
      'from': 'Fahim',
      'me': true,
    },
    {
      'text': 'Hello Ashik',
      'from': 'Steve',
      'me': false,
    },
    {
      'text': 'Hello Ashik',
      'from': 'Steve',
      'me': true,
    },
    {
      'text':
          'Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik ',
      'from': 'Steve',
      'me': false,
    },
    {
      'text':
          'Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik',
      'from': 'Steve',
      'me': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Hero(
            tag: 'logo',
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        title: Text('Anonymous Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _messagesScroll,
              itemCount: dummyData.length,
              itemBuilder: (context, index) {
                return Message(
                  dummyData[index]['text'],
                  dummyData[index]['from'],
                  dummyData[index]['me'],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 12,
              bottom: 12,
              left: 12,
              right: 0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(0, -2),
                  blurRadius: 2.8,
                  spreadRadius: 0.4,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: _messageInputDecoration(),
                    controller: _messageController,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send_outlined),
                  iconSize: 28,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration _messageInputDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.grey[100],
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
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
    prefixIcon: Icon(Icons.message_outlined),
  );
}
