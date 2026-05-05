import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../values/assets.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool hasBackButton;

  const CustomAppBar({
    this.hasBackButton = true,
    super.key,
    this.title,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        titleSpacing: 0,
        leadingWidth: 44,
        leading: hasBackButton
            ? InkWell(
                onTap: () {
                  if (onBackPressed != null) {
                    onBackPressed!();
                  } else {
                    GoRouter.of(context).pop();
                  }
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.icons.arrowBackIcon,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              )
            : null,
        title: Text(title ?? ''),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
