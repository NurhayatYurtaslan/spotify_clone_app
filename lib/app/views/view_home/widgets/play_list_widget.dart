import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/helpers/is_dark_mode.dart';

class PlayListWidget extends StatelessWidget {
  const PlayListWidget({
    super.key,
    required this.text,
    required this.showSeeMore,
    required this.onSeeMorePressed,
    required this.onSeeLessPressed,
  });

  final String text; 
  final bool showSeeMore; 
  final VoidCallback onSeeMorePressed; 
  final VoidCallback onSeeLessPressed; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.mediumValue, horizontal: context.mediumValue),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Playlist', // Daha açıklayıcı bir başlık düşünülebilir
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              GestureDetector(
                onTap: showSeeMore ? onSeeLessPressed : onSeeMorePressed, // Duruma göre tıklama olayları
                child: Text(
                  showSeeMore ? "See Less" : text, // Duruma göre metin değişikliği
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: context.isDarkMode
                        ? AppColors.grey
                        : AppColors.darkGrey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
