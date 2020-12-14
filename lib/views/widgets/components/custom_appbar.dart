import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onTap;
  CustomAppBar({this.onTap});
  @override
  Size get preferredSize => Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: buildTitle(),
      actions: [buildActButton()],
    );
  }

  Padding buildActButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(
        icon: Icon(Icons.info_outline, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }

  Text buildTitle() {
    return Text(
      "Time Visualer",
      style: TextStyle( 
        fontWeight: FontWeight.w700,
        fontSize: 23,
      ),
    );
  }
}