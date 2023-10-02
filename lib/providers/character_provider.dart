import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';

class CharacterProvider with ChangeNotifier {
  final String url = 'rickandmortyapi.com';

  List<Character> characters = [];
  List<Character> randomCharacters = [];
  List<Episode> episodes = [];
  List<Character> rickCharacters = [];

  Future<int> getCountCharacters() async {
    final response = await http.get(Uri.https(url, '/api/character/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final count = data['info']['count'] as int;
      return count;
    } else {
      throw Exception('Failed to fetch count from API');
    }
  }

  Future<void> getAllCharacters(int page) async {
    final response = await http.get(Uri.https(url, "/api/character/", {
      'page': page.toString(),
    }));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      characters = (jsonBody['results'] as List)
          .map((characterJson) => Character.fromJson(characterJson))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<void> getRandomCharacters() async {
    int characters = 10;
    final total = await getCountCharacters();

    List<int> randomNumbers = List.generate(
      characters,
      (index) {
        Random random = Random();
        return random.nextInt(total);
      },
    );

    String rCharacters = randomNumbers.join(', ');

    final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character/$rCharacters'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      randomCharacters = (jsonBody as List)
          .map((randomCharacterJson) => Character.fromJson(randomCharacterJson))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<void> getCharacterByName(String name, int page) async {
    final response = await http.get(Uri.parse(
        'https://rickandmortyapi.com/api/character/?page=$page&name=$name'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      rickCharacters = (jsonBody['results'] as List)
          .map((rickCharacterJson) => Character.fromJson(rickCharacterJson))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<Episode>> getEpisodes(Character character) async {
    episodes = [];

    for (var i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeFromJson(result.body);
      episodes.add(response);
      notifyListeners();
    }

    return episodes;
  }
}
