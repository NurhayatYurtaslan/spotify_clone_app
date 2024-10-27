import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/repository/model/songs/songs_model.dart'; // Ensure this is the correct import

class SongSearchDelegate extends SearchDelegate<Song?> {
  final List<Song> songs;

  SongSearchDelegate(this.songs);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search screen
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _getSearchResults();

    if (results.isEmpty) {
      return const Center(
        child: Text("No songs found"),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final song = results[index];
        return ListTile(
          title: Text(song.title), // Use null-aware operator
          subtitle: Text(song.artist), // Use null-aware operator
          onTap: () {
            close(context, song); // Close search screen and return the selected song
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _getSearchResults();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion.title), // Use null-aware operator
          subtitle: Text(suggestion.artist), // Use null-aware operator
          onTap: () {
            query = suggestion.title; // Safely update the query
            showResults(context); // Show search results
          },
        );
      },
    );
  }

  List<Song> _getSearchResults() {
    final lowerQuery = query.toLowerCase(); // Cache the lower case query for reuse
    return songs.where((song) {
      return (song.title.toLowerCase().contains(lowerQuery)) || 
             (song.artist.toLowerCase().contains(lowerQuery)); // Safe access
    }).toList();
  }
}
