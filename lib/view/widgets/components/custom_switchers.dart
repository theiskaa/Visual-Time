import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtime/core/utils/widgets.dart';

class SwitcherTile extends VTStatelessWidget {
  final String title;
  final bool switcherValue;
  final Function(bool) onChanged;
  final Color switcherColor;
  final double spaceAround;

  SwitcherTile({
    Key? key,
    required this.title,
    required this.switcherValue,
    required this.onChanged,
    this.switcherColor = Colors.black,
    this.spaceAround = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: spaceAround),
        CupertinoSwitch(
          activeColor: switcherColor,
          value: switcherValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
