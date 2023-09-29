import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/model/episode_model.dart';

class CharacterProvider with ChangeNotifier {
  final String url = 'rickandmortyapi.com';

  List<Character> characters = [];
  List<Character> randomCharacters = [];
  List<Episode> episodes = [];

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
    int cantidadElementos = 10;

    final count = await getCountCharacters();

    List<int> numerosAleatorios = List.generate(
      cantidadElementos,
      (index) {
        Random random = Random();
        return random.nextInt(count);
      },
    );

    String numerosComoString = numerosAleatorios.join(', ');

    final response = await http.get(Uri.parse(
        'https://rickandmortyapi.com/api/character/$numerosComoString'));

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

  Future<void> getEpisodesByCharacter(Character character) async {
    episodes = [];

    // for (var i = 0; i < character.episode.length; i++) {
    //   final response = await http.get(Uri.parse(character.episode[i]));

    //   if (response.statusCode == 200) {
    //     final jsonBody = json.decode(response.body);
    //     if (jsonBody is List) {
    //       episodes = jsonBody
    //           .map((episodesJson) => Episode.fromJson(episodesJson))
    //           .toList();
    //       notifyListeners();
    //     } else {
    //       throw Exception('Failed to load characters');
    //     }
    //   } else {
    //     throw Exception('Failed to load characters');
    //   }
    // }
  }
}
