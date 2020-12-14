import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onTap;
  final String title;
  final Widget leading;
  CustomAppBar({this.onTap, this.title,this.leading,});
  @override
  Size get preferredSize => Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: buildTitle(),
      leading: leading,
      actions: [buildActButton()],
    );
  }

  Padding buildActButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(
        icon: Icon(Icons.info_outline, color: Colors.black),
        onPressed: onTap,
      ),
    );
  }

  Text buildTitle() {
    return Text(
      "$title",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 23,
        color: Colors.black
      ),
    );
  }
}
