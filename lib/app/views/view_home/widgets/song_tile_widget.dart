
import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/repository/model/songs/songs_model.dart';

class SongTile extends StatelessWidget {
  final Song song; // Ensure this is a Song type
  final VoidCallback onFavoritePressed;

  const SongTile({
    required this.song,
    required this.onFavoritePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: Image.network(
          song.imageUrl, // Assuming 'Image' is the field in Song model that holds the image URL

          fit: BoxFit.cover, // Maintain aspect ratio
          errorBuilder: (context, error, stackTrace) {
            return const CircleAvatar(
              backgroundColor:
                  Colors.grey, // Fallback color if image fails to load
              child:
                  Icon(Icons.music_note, color: Colors.white), // Fallback icon
            );
          },
        ),
      ),
      title: Text(song.title),
      subtitle: Text(song.artist),
      trailing: IconButton(
        icon: const Icon(Icons.favorite),
        onPressed: onFavoritePressed,
      ),
    );
  }
}
