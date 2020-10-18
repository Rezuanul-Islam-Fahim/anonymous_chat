import 'package:flutter/material.dart';

import 'package:anonymous_chat/screens/setting/setting.dart';

// Chat screen's appbar widget handler
AppBar getAppBar(
  BuildContext context,
  Map<String, dynamic> _userData,
) {
  return AppBar(
    leading: Container(
      margin: EdgeInsets.only(left: 10),
      child: Hero(
        tag: 'logo',
        child: Image.asset('assets/images/logo.png'),
      ),
    ),
    title: Text('Chats'),
    titleSpacing: 10,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.account_circle),
        iconSize: 30,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SettingScreen(_userData),
            ),
          );
        },
      ),
    ],
  );
}
