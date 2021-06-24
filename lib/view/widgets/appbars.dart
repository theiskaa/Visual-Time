import 'package:flutter/material.dart';

class TransparentAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool disableLeading;
  final Function? onLeadingTap;
  final Widget? titleWidget;

  const TransparentAppBar({
    Key? key,
    this.disableLeading = false,
    this.onLeadingTap,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: titleWidget,
      centerTitle: true,
      leading: disableLeading
          ? const SizedBox.shrink()
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => onLeadingTap!(),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
