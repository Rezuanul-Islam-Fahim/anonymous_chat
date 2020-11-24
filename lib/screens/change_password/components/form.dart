import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/responsive.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/change_password/components/input_field.dart';

class ChangePasswordForm extends StatefulWidget {
  ChangePasswordForm(
    this._passwordController,
    this._confirmPassController,
    this._handler,
  );

  final TextEditingController _passwordController;
  final TextEditingController _confirmPassController;
  final Function _handler;

  @override
  _ChangePassFormState createState() => _ChangePassFormState();
}

class _ChangePassFormState extends State<ChangePasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: Responsive(MediaQuery.of(context)).width(400),
        child: Column(
          children: <Widget>[
            passwordField(
              'Enter New Password',
              widget._passwordController,
              widget._confirmPassController,
            ),
            SizedBox(height: 20),
            passwordField(
              'Confirm Password',
              widget._confirmPassController,
              widget._passwordController,
            ),
            SizedBox(height: 20),
            GeneralButton('Change Password', () {
              if (_formKey.currentState.validate()) {
                widget._handler(context);
              }
            }),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
