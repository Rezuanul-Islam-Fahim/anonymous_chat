import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/screens/chat/components/appbar.dart';
import 'package:anonymous_chat/screens/chat/components/message_stream.dart';
import 'package:anonymous_chat/screens/chat/components/send_area.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _messageScroll = ScrollController();
  String _name;
  String _email;

  // Load user-details handler
  Future<void> _loadUserDetails() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _name = _prefs.getString('name');
    _email = _prefs.getString('email');

    print(_prefs.getString('name'));
    print(_prefs.getString('email'));

    setState(() {});
  }

  // This handler will be used for storing
  // message to database
  Future<void> _sendMessage() async {
    if (_messageController.text.length > 0) {
      // Store message
      await FirebaseFirestore.instance.collection('messages').add({
        'text': _messageController.text,
        'fromName': _name,
        'fromEmail': _email,
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
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Column(
        children: <Widget>[
          MessageStream(_messageScroll, _email),
          SendArea(_messageController, _sendMessage),
        ],
      ),
    );
  }
}
