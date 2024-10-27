import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/helpers/is_dark_mode.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final Widget? title;
  final List<Widget>? actions; // Changed to List<Widget> for flexibility
  final Color? backgroundColor;
  final bool hideBack;

  const BasicAppbar({
    this.title,
    this.hideBack = false,
    this.actions, // Make actions optional
    this.backgroundColor,
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? const Text(''),
      actions: actions, // Use actions directly
      leading: hideBack
          ? null
          : IconButton(
              onPressed: onPressed,
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.03)
                      : Colors.black.withOpacity(0.04),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
