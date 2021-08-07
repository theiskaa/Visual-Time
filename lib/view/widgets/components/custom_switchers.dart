import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/widgets/utils.dart';

class SwitcherTile extends VTStatelessWidget {
  final String title;
  final bool switcherValue;
  final Function(bool) onChanged;
  final Color? switcherColor;
  final double spaceAround;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle titleStyle;

  SwitcherTile({
    Key? key,
    required this.title,
    required this.switcherValue,
    required this.onChanged,
    this.switcherColor,
    this.spaceAround = 10,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.titleStyle = const TextStyle(fontWeight: FontWeight.bold),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(title, style: titleStyle),
        ),
        SizedBox(width: spaceAround),
        CupertinoSwitch(
          activeColor: switcherColor ?? ViewUtils().pomodoroOrange(context),
          value: switcherValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
