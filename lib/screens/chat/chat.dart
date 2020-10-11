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
  final int _msgIncrement = 20;
  Map<String, dynamic> _userData = {};
  int _msgLimit = 15;

  // Load user-details handler
  Future<void> _loadUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _userData['name'] = _prefs.getString('name');
    _userData['email'] = _prefs.getString('email');

    setState(() {});
  }

  // Message scroll listener
  void _scrollListener() {
    if (_messageScroll.offset >= _messageScroll.position.maxScrollExtent &&
        !_messageScroll.position.outOfRange) {
      setState(() => _msgLimit += _msgIncrement);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _messageScroll.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, _userData),
      body: Column(
        children: <Widget>[
          MessageStream(_userData, _messageScroll, _msgLimit),
          SendArea(_userData),
        ],
      ),
    );
  }
}
