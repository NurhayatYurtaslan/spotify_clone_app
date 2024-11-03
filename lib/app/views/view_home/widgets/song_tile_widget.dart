import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spotify_clone_app/core/repository/model/songs/songs_model.dart';

class SongTile extends StatelessWidget {
  final List<Song> songs;

  const SongTile({required this.songs, super.key});

  @override
Widget build(BuildContext context) {
  return ValueListenableBuilder<Box<Song>>(
    valueListenable: Hive.box<Song>('favorite').listenable(),
    builder: (context, box, _) {
      return Column(
        children: List.generate(songs.length, (index) {
          final song = songs[index];
          final isFavorite = box.get(song.id) != null;
          return ListTile(
            leading: ClipOval(
              child: Image.network(
                song.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.music_note, color: Colors.red),
                  );
                },
              ),
            ),
            title: Text(song.title),
            subtitle: Text(song.artist),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () async {
                if (isFavorite) {
                  await box.delete(song.id);
                } else {
                  await box.put(song.id, song);
                }
              },
            ),
          );
        }),
      );
    },
  );
}

}
