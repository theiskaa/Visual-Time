import 'package:flutter/material.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/widgets/utils.dart';

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
          color: ViewUtils.pomodoroOrange,
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            child: (time == 'dn')
                ? const Icon(Icons.done, size: 50, color: ViewUtils.pomodoroOrange)
                : Text(
                    time,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: disabled ? ViewUtils.pomodoroOrange : Colors.white,
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
        border: Border.all(width: 3, color: ViewUtils.pomodoroOrange.withOpacity(.1)),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        height: generalSize,
        width: generalSize,
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: ViewUtils.pomodoroOrange.withOpacity(.1)),
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
