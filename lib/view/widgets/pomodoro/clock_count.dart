import 'package:flutter/material.dart';
import 'package:vtime/core/utils/widgets.dart';

import '../loadings.dart';

class ClockCount extends VTStatelessWidget {
  final bool disabled;
  final String time;

  ClockCount({
    Key? key,
    required this.disabled,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 1.8;
    return _ThreeRoundCircleGrid(
      generalSize: size,
      child: Center(
        child: DoubleBounce(
          disabled: disabled,
          size: size - 50,
          color: const Color(0xffFF6347),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            child: Text(
              disabled ? '00:00' : time,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = disabled ? const Color(0xffFF6347) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _ThreeRoundCircleGrid extends StatelessWidget {
  final Widget child;
  final double generalSize;

  _ThreeRoundCircleGrid({
    Key? key,
    required this.child,
    required this.generalSize,
  }) : super(key: key);

  Color color = const Color(0xffFF6347).withOpacity(.1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: generalSize + 5,
      width: generalSize + 5,
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: color),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        height: generalSize,
        width: generalSize,
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: color),
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
