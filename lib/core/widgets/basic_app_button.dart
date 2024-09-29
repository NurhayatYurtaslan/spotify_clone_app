import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';

class BasicAppButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color buttonBgColor;
  final Color buttonTextColor;
  final BorderRadius buttonBorderRadius;
  final double? buttonHeight;
  final double? buttonWidth;

  const BasicAppButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonBgColor,
    required this.buttonTextColor,
    this.buttonBorderRadius = const BorderRadius.all(Radius.circular(30)),
    this.buttonHeight,
    this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? context.highValue / 1.5,
      width: buttonWidth ?? context.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: buttonBorderRadius,
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}