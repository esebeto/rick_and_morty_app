import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider with ChangeNotifier {
  final String url = 'rickandmortyapi.com';
  List<Character> characters = [];

  Future<void> getAllCharacters() async {
    final result = await http.get(Uri.https(url, "/api/character"));
    final response = characterResponseFromJson(result.body);
    characters.addAll(response.results!);
    notifyListeners();
  }
}
