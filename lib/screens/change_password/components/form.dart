import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/responsive.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/change_password/components/input_field.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm(
    this.passwordController,
    this.confirmPassController,
    this.handler,
  );

  final TextEditingController passwordController;
  final TextEditingController confirmPassController;
  final Function handler;

  @override
  _ChangePassFormState createState() => _ChangePassFormState();
}

class _ChangePassFormState extends State<ChangePasswordForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        width: Responsive(MediaQuery.of(context)).width(400),
        child: Column(
          children: <Widget>[
            passwordField(
              'Enter New Password',
              widget.passwordController,
              widget.confirmPassController,
            ),
            const SizedBox(height: 20),
            passwordField(
              'Confirm Password',
              widget.confirmPassController,
              widget.passwordController,
            ),
            const SizedBox(height: 20),
            GeneralButton('Change Password', () {
              if (formKey.currentState!.validate()) {
                widget.handler(context);
              }
            }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
