import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../components/message.dart';

class ChatScreen extends StatefulWidget {
  final UserCredential _user;

  ChatScreen(this._user);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
      'text': 'Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik ',
      'from': 'Steve',
      'me': false,
    },
    {
      'text': 'Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik Hello Ashik',
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
          child: Image.asset('assets/images/logo.png'),
        ),
        title: Text('Chats'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
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
            child: Row(
              children: <Widget>[
                Expanded(child: TextField()),
                IconButton(
                  icon: Icon(Icons.send_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
