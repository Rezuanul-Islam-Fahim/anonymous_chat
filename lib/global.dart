import 'package:flutter/material.dart';

InputDecoration inputField(String placeholderText) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 18,
    ),
    filled: true,
    fillColor: Colors.grey[200],
    hintText: placeholderText,
    border: OutlineInputBorder(),
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
  );
}
