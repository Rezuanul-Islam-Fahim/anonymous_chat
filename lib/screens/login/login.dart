import 'package:flutter/material.dart';

import 'package:anonymous_chat/components/login_register_header.dart';
import 'package:anonymous_chat/screens/login/components/form.dart';
import 'package:anonymous_chat/screens/login/components/register_link.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: <Widget>[
            Header(),
            LoginForm(),
            RegisterLink(),
          ],
        ),
      ),
    );
  }
}
