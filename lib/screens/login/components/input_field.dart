import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';

// Password field handler
TextFormField passwordField(TextEditingController controller) {
  return TextFormField(
    decoration: inputField(
      'Enter your Password',
      Icons.vpn_key_outlined,
    ),
    controller: controller,
    obscureText: true,
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      return null;
    },
  );
}
