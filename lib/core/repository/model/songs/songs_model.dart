import 'package:hive/hive.dart';

part 'songs_model.g.dart'; // This is the generated part file.

@HiveType(typeId: 0) // Ensure the typeId is unique
class Song {
  @HiveField(0)
  final String id; // Unique identifier for the song

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String artist;

  @HiveField(3)
  final String imageUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
  });

  // Factory constructor for creating a Song instance from JSON
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      artist: json['artist'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  // Convert Song instance to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'imageUrl': imageUrl,
    };
  }
}
