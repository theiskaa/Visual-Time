import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  final Function onTap;
  CustomFAB({this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.black.withOpacity(.3),
      child: Icon(Icons.add, size: 30),
      backgroundColor: Colors.black,
      onPressed: onTap,
    );
  }
}
