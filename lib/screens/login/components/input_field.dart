import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';

TextFormField passwordField(TextEditingController controller) {
  return TextFormField(
    decoration: inputField(
      'Enter your Password',
      Icons.vpn_key,
    ),
    controller: controller,
    obscureText: true,
    validator: (String value) {
      if (value.isEmpty) {
        return 'Password is required';
      }
      return null;
    },
  );
}
