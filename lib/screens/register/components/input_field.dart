import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';

TextFormField nameField(TextEditingController controller) {
  return TextFormField(
    decoration: inputField(
      'Name',
      Icons.account_circle_outlined,
    ),
    controller: controller,
    validator: (value) {
      if (value.isEmpty) {
        return 'Name is required';
      }
      return null;
    },
  );
}

TextFormField passwordField(TextEditingController controller) {
  return TextFormField(
    decoration: inputField(
      'Password',
      Icons.vpn_key_outlined,
    ),
    controller: controller,
    obscureText: true,
    validator: (value) {
      if (value.isEmpty) {
        return 'Password is required';
      } else if (value.length < 6) {
        return 'Password should be at least 6 characters';
      }
      return null;
    },
  );
}
