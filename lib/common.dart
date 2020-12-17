import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

// Input-field decoration for all general input-fields
InputDecoration inputField(String placeholderText, IconData icon) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 15,
    ),
    filled: true,
    fillColor: Colors.grey[200],
    hintText: placeholderText,
    hintStyle: const TextStyle(fontSize: 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        width: 0.6,
        color: Colors.grey[300],
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        width: 1.1,
        color: Colors.grey[350],
      ),
    ),
    prefixIcon: Icon(icon, size: 21),
  );
}

// Input field handler for all email fields
TextFormField emailField(
  TextEditingController controller,
  String placeholder,
) {
  return TextFormField(
    decoration: inputField(
      placeholder,
      Icons.email_outlined,
    ),
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    validator: (String value) {
      if (value.isEmpty) {
        return 'Email is required';
      } else if (!EmailValidator.validate(value)) {
        return 'Invalid Email Address';
      }
      return null;
    },
  );
}
