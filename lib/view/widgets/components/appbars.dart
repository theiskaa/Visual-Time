//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter/material.dart';

class TransparentAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool disableLeading;
  final Function? onLeadingTap;
  final Widget? titleWidget;
  final Widget? action;

  const TransparentAppBar({
    Key? key,
    this.disableLeading = false,
    this.onLeadingTap,
    this.titleWidget,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget,
      centerTitle: true,
      actions: (action != null) ? [action!] : null,
      leading: disableLeading
          ? const SizedBox.shrink()
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => onLeadingTap!(),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
