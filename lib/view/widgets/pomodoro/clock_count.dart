import 'package:flutter/material.dart';
import 'package:vtime/core/utils/widgets.dart';

import '../loadings.dart';

class ClockCount extends VTStatelessWidget {
  final bool disabled;

  ClockCount({Key? key, required this.disabled}) : super(key: key);

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
              disabled ? '25:00' : '24:59',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = disabled ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThreeRoundCircleGrid extends StatelessWidget {
  final Widget child;
  final double generalSize;
  const _ThreeRoundCircleGrid({
    Key? key,
    required this.child,
    required this.generalSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: generalSize + 5,
      width: generalSize + 5,
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: const Color(0xffFF6347)),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        height: generalSize,
        width: generalSize,
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: const Color(0xffFF6347)),
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
