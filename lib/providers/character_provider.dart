import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:http/http.dart' as http;

class CharacterProvider with ChangeNotifier {
  final String url = 'rickandmortyapi.com';
  List<Character> characters = [];

  Future<void> getAllCharacters() async {
    final result = await http.get(Uri.https(url, "/api/character/"));

    if (result.statusCode == 200) {
      final response = characterResponseFromJson(result.body);
      characters.addAll(response.results!);
      notifyListeners();
    } else {
      throw Exception("Failed to load characters");
    }
  }

  Future<List<Character>> getRandomCharacters() async {
    int cantidadElementos = 10;

    List<int> numerosAleatorios = List.generate(
      cantidadElementos,
      (index) {
        Random random = Random();
        return random.nextInt(100);
      },
    );
    String numerosComoString = numerosAleatorios.join(', ');

    final response =
        await http.get(Uri.https(url, "/api/character/$numerosComoString"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      final List<Character> randomcharacters =
          jsonList.map((json) => Character.fromJson(json)).toList();

      return randomcharacters;
    } else {
      throw Exception('Error al cargar los personajes');
    }
  }

  Future<void> getRandomCharacter() async {
    int cantidadElementos = 10;

    List<int> numerosAleatorios = List.generate(
      cantidadElementos,
      (index) {
        Random random = Random();
        return random.nextInt(100);
      },
    );
    String numerosComoString = numerosAleatorios.join(', ');

    final result =
        await http.get(Uri.https(url, "/api/character/$numerosComoString"));

    if (result.statusCode == 200) {
      final response = characterResponseFromJson(result.body);
      characters.addAll(response.results!);
      notifyListeners();
    } else {
      throw Exception("Failed to load characters");
    }
  }
}
