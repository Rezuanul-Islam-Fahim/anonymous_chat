import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/screens/chat/components/appbar.dart';
import 'package:anonymous_chat/screens/chat/components/message_stream.dart';
import 'package:anonymous_chat/screens/chat/components/send_area.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _messageScroll = ScrollController();
  Map<String, dynamic> _userData = {};

  // Load user-details handler
  Future<void> _loadUserDetails() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _userData['name'] = _prefs.getString('name');
    _userData['email'] = _prefs.getString('email');

    setState(() {});
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
          MessageStream(_userData, _messageScroll),
          SendArea(_userData, _messageScroll),
        ],
      ),
    );
  }
}
