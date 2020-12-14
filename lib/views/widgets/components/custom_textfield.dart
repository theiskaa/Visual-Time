import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  
  const CustomTextField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(),
    );
  }
}
