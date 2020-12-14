import 'package:flutter/material.dart';
import 'package:timevisualer/core/custom_colors.dart';

class CustomFAB extends StatelessWidget {
  final Function onTap;
  CustomFAB({this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.black.withOpacity(.3),
      child: Icon(
        Icons.add,
        size: 30,
        color: Colors.black,
      ),
      backgroundColor: getYellowColor,
      onPressed: onTap,
    );
  }
}
