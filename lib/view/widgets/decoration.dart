import 'package:flutter/material.dart';

class MyDecoration {
  static InputDecoration inputDecoration(
      {required String label, required String hint, required IconData icon}) {
    return InputDecoration(
      label: Text(label),
      hintText: hint,
      fillColor: Colors.grey,
      focusColor: Colors.grey,
      //
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(),
      ),
      prefixIcon: Icon(icon, size: 22),
    );
  }
}