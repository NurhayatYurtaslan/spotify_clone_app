class Song {
  final String title;
  final String artist;
  final String imageUrl; // Düzeltilmiş alan ismi

  Song({
    required this.title,
    required this.artist,
    required this.imageUrl, // Gerekli hale getirildi
  });

  // JSON Map'ten Song oluşturmak için fabrika yapıcı
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      title: json['title'] as String? ?? '', // Null-aware operator kullanımı ve fallback
      artist: json['artist'] as String? ?? '', // Null-aware operator kullanımı ve fallback
      imageUrl: (json['Image'] ?? '') as String, // 'null' durumunu kontrol ediyoruz ve fallback veriyoruz
    );
  }
}
