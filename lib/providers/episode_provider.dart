import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';
import 'package:http/http.dart' as http;

class EpisodeProvider with ChangeNotifier {
  final String url = 'rickandmortyapi.com';
  List<Episode> episodes = [];

  Future<void> getAllEpisodes(int page) async {
    final response = await http.get(Uri.https(url, "/api/episode/", {
      'page': page.toString(),
    }));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      episodes = (jsonBody['results'] as List)
          .map((episodeJson) => Episode.fromJson(episodeJson))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
