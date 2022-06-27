//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter/material.dart';

class DoubleBounce extends StatefulWidget {
  final Color? color;
  final double? size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;
  final Widget? child;
  final bool disabled;
  final bool isAnimationsDisabled;

  const DoubleBounce({
    Key? key,
    this.color = Colors.white,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(seconds: 2),
    this.controller,
    this.child = const SizedBox(),
    this.disabled = false,
    this.isAnimationsDisabled = false,
  })  : assert(size != null),
        assert(
          !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
              !(itemBuilder == null && color == null),
          'You should specify either an itemBuilder or a color',
        ),
        super(key: key);

  @override
  _DoubleBounceState createState() => _DoubleBounceState();
}

class _DoubleBounceState extends State<DoubleBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(
          vsync: this,
          duration: widget.duration,
        ))
      ..addListener(() => setState(() {}))
      ..repeat(reverse: true);

    _animation = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          widget.isAnimationsDisabled ? const SizedBox.shrink() : animation(),
          Align(
            alignment: Alignment.center,
            child: widget.child ?? const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget animation() {
    return AnimatedOpacity(
      opacity: (widget.disabled) ? 0 : 1,
      duration: widget.duration,
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: List.generate(
            2,
            (index) => Transform.scale(
              scale: (1.0 - index - _animation.value.abs()).abs(),
              child: SizedBox.fromSize(
                size: Size.square(widget.size!),
                child: _itemBuilder(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) {
    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(context, index);
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color!.withOpacity(0.6),
      ),
    );
  }
}
