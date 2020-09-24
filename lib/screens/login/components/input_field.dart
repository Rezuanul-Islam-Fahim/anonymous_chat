import 'package:flutter/material.dart';

import 'package:anonymous_chat/commons.dart';

TextFormField passwordField(TextEditingController controller) {
  return TextFormField(
    decoration: inputField(
      'Enter your Password',
      Icons.vpn_key_outlined,
    ),
    controller: controller,
    obscureText: true,
    validator: (value) {
      if (value.isEmpty) {
        return 'Password is required';
      }
      return null;
    },
  );
}
