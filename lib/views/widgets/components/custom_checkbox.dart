import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final bool val;
  final Function(bool) onChanged;
  const CustomCheckBox({
    Key key,
    this.title,
    this.val,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: val,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
