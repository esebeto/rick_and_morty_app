import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';
import 'package:http/http.dart' as http;

class EpisodeProvider with ChangeNotifier {
  final String url = 'rickandmortyapi.com';
  List<Episode> episode = [];

  Future<void> getAllEpisodes() async {
    final result = await http.get(Uri.https(url, "/api/episode/"));
    print(result.body);
    if (result.statusCode == 200) {
      final response = episodeResponseFromJson(result.body);
      episode.addAll(response.results!);
      notifyListeners();
    } else {
      throw Exception("Failed to load characters");
    }
  }
}
