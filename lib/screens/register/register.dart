import 'package:flutter/material.dart';

import 'package:anonymous_chat/components/login_register_header.dart';
import 'package:anonymous_chat/screens/register/components/form.dart';
import 'package:anonymous_chat/screens/register/components/back_button.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 15,
              right: 15,
            ),
            child: Column(
              children: <Widget>[
                Header(),
                RegisterForm(),
              ],
            ),
          ),
          RegisterBackButton(),
        ],
      ),
    );
  }
}
