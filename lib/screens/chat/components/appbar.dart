import 'package:flutter/material.dart';

import 'package:anonymous_chat/screens/setting/setting.dart';

AppBar getAppBar(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(5),
      child: Hero(
        tag: 'logo',
        child: Image.asset('assets/images/logo.png'),
      ),
    ),
    title: Text('Chats'),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SettingScreen()),
          );
        },
      ),
    ],
  );
}
