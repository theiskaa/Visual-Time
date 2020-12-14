import 'package:flutter/material.dart';

class CreateButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  const CreateButton({Key key, this.title, this.onTap});

  @override
  _CreateButtonState createState() => _CreateButtonState();
}

class _CreateButtonState extends State<CreateButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        setState(() {
          isTapped = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      onTapDown: (details) {
        setState(() {
          isTapped = true;
        });
        widget.onTap();
      },
      child: Opacity(
        opacity: isTapped ? .9 : 1,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
