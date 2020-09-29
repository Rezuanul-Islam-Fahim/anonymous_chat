import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/database.dart';
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
  User _user;
  Map<String, String> _userDetails;

  Future<void> _loadUsernDetails() async {
    _user = AuthService.loadUser();
    _userDetails = await DatabaseService.fromUID(_user.uid).loadUserDetails();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.length > 0) {
      await FirebaseFirestore.instance.collection('messages').add({
        'text': _messageController.text,
        'fromName': _userDetails['name'],
        'fromEmail': _user.email,
        'timendate': DateTime.now().toIso8601String(),
      });

      _messageController.clear();

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
    _loadUsernDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Column(
        children: <Widget>[
          MessageStream(_messageScroll, _user),
          SendArea(_messageController, _sendMessage),
        ],
      ),
    );
  }
}
