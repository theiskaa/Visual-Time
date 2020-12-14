import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final int lineCount;
  final Function(String) validation;
  final Function(String) onChanged;
  
  const CustomTextField({
    Key key,
    this.hint,
    this.lineCount,
    this.validation,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: buildInputDecoration(),
      maxLines: lineCount,
      validator: validation,
      onChanged: onChanged,
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.black, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.black, width: 2.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}
