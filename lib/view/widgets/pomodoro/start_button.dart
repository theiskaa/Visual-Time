
// import 'package:flutter/material.dart';

// class StartButton extends StatefulWidget {
//   final String? title;
//   final VoidCallback? onTap;
//   final Color? borderColor;
//   final Color? spashColor;
//   final Color? titleColor;
//   final Color? tappedTitleColor;
//   final double? titleSize;
//   final FontWeight? fontWeight;
//   final BorderRadiusGeometry? borderRadius;
//   final Duration? duration;
//   final double? borderWidth;

//   AnimatedHoverButton({
//     Key? key,
//     @required this.title,
//     @required this.onTap,
//     this.borderColor,
//     this.spashColor,
//     this.titleColor,
//     this.tappedTitleColor,
//     this.titleSize,
//     this.borderRadius,
//     this.fontWeight,
//     this.duration,
//     this.borderWidth,
//   }) : super(key: key);

//   @override
//   _AnimatedHoverButtonState createState() => _AnimatedHoverButtonState();
// }

// class _AnimatedHoverButtonState extends State<AnimatedHoverButton>
//     with SingleTickerProviderStateMixin {
//   AnimationController _animationController;
//   Animation<Color> _colorAnimation;
//   Animation<Color> _textColorAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: (widget.duration != null)
//           ? widget.duration
//           : Duration(milliseconds: 300),
//     );

//     _colorAnimation = ColorTween(
//       begin: Colors.transparent,
//       end: (widget.spashColor != null) ? widget.spashColor : Colors.black,
//     ).animate(_animationController);

//     _textColorAnimation = ColorTween(
//       begin: (widget.titleColor != null) ? widget.titleColor : Colors.black,
//       end: (widget.tappedTitleColor != null)
//           ? widget.tappedTitleColor
//           : Colors.white,
//     ).animate(_animationController);

//     _animationController.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (details) {
//         _animationController.forward();
//       },
//       onTapCancel: () {
//         _animationController.reverse();
//       },
//       onTapUp: (details) {
//         _animationController.reverse();
//         widget.onTap();
//       },
//       child: AnimatedBuilder(
//         animation: _animationController,
//         builder: (context, child) {
//           return Container(
//             decoration: buildBoxDecorationOfAnimeHoverButton(),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Text(
//                 (widget.title != null) ? widget.title : "Animated Hover Button",
//                 style: TextStyle(
//                   fontSize: widget.titleSize,
//                   color: _textColorAnimation.value,
//                   fontWeight: widget.fontWeight,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   BoxDecoration buildBoxDecorationOfAnimeHoverButton() {
//     return BoxDecoration(
//       borderRadius: (widget.borderRadius == null)
//           ? BorderRadius.circular(0)
//           : widget.borderRadius,
//       border: Border.all(
//         width: (widget.borderWidth != null) ? widget.borderWidth : 2,
//         color: (widget.borderColor != null) ? widget.borderColor : Colors.black,
//       ),
//       color: _colorAnimation.value,
//     );
//   }
// }