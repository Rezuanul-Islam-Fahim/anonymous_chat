import 'package:flutter/material.dart';

import 'package:anonymous_chat/models/user.dart';
import 'package:anonymous_chat/screens/settings/settings.dart';

// Chat screen's appbar widget handler
AppBar getAppBar(BuildContext context, UserM userData) {
  return AppBar(
    leading: Container(
      margin: const EdgeInsets.only(left: 10),
      child: Hero(
        tag: 'logo',
        child: Image.asset('assets/images/logo.png'),
      ),
    ),
    title: const Text('Chat'),
    titleSpacing: 10,
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.account_circle),
        iconSize: 30,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SettingScreen(userData),
            ),
          );
        },
      ),
    ],
  );
}
