import 'dart:ui';

import 'package:flutter/material.dart';

class MiniDayChart extends StatelessWidget {
  final String title;
  final Function? onTap;
  final Color? circleColor;

  const MiniDayChart({
    Key? key,
    required this.title,
    required this.onTap,
    this.circleColor = const Color(0xFFFFFFFF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
                border: Border.all(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
