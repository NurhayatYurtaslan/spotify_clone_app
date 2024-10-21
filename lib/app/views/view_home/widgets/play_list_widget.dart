import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/constants/color_constants.dart';
import 'package:spotify_clone_app/core/extensions/context_extension.dart';
import 'package:spotify_clone_app/core/helpers/is_dark_mode.dart';

class PlayListWidget extends StatelessWidget {
  const PlayListWidget({
    super.key,
    required this.showSeeMore,
    required this.onSeeMorePressed, // Callback fonksiyonu ekledik
  });

  final bool showSeeMore; // See More durumunu tutmak için bir değişken
  final VoidCallback
      onSeeMorePressed; // See More butonuna tıklanınca çalışacak fonksiyon

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
                'Playlist',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              GestureDetector(
                onTap:
                    onSeeMorePressed, // Butona tıklandığında çalışacak fonksiyon
                child: Text(
                  'See More',
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
