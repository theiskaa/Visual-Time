import 'package:flutter/material.dart';

class SetTimeButton extends StatelessWidget {
  final Color borderColor;
  final Color backgorundColor;
  final Color textColor;
  final String title;
  final String time;
  final Function onTap;

  const SetTimeButton({
    Key key,
    this.backgorundColor,
    this.borderColor,
    this.textColor,
    this.title,
    this.time,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
          child: Container(
        constraints: BoxConstraints(
          maxHeight: 50,
          minHeight: 45,
          minWidth: 250,
          maxWidth: MediaQuery.of(context).size.width - 30,
        ),
        decoration: BoxDecoration(
          color: backgorundColor,
          border: Border.all(color: borderColor, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              "$title - $time",
              style: TextStyle(color: textColor, fontSize: 16,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
