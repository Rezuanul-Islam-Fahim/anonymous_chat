import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';

// Password field handler
TextFormField passwordField(
  String _placeHolder,
  TextEditingController _mainController,
  TextEditingController _secondaryController,
) {
  return TextFormField(
    decoration: inputField(_placeHolder, Icons.vpn_key),
    controller: _mainController,
    obscureText: true,
    validator: (String value) {
      if (value.isEmpty) {
        return 'Required Field';
      } else if (_mainController.text != _secondaryController.text) {
        return 'Password fields should be matched';
      }
      return null;
    },
  );
}
