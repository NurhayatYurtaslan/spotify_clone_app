import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? fontSize; // Nullable yapıyoruz
  final double? height;

  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    this.fontSize, // Null olmasına izin veriyoruz
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.lightBackground,
          fontSize: fontSize ??
              context.mediumValue *
                  .7, // Eğer fontSize null ise 15 değeri kullanılır
        ),
      ),
    );
  }
}
