import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';

// Password field handler
TextFormField passwordField(
  String placeHolder,
  TextEditingController mainController,
  TextEditingController secondaryController,
) {
  return TextFormField(
    decoration: inputField(placeHolder, Icons.vpn_key_outlined),
    controller: mainController,
    obscureText: true,
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Required Field';
      } else if (mainController.text != secondaryController.text) {
        return 'Password fields should be matched';
      }
      return null;
    },
  );
}
