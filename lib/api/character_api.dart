import 'dart:convert';
import 'package:http/http.dart' as http;

class CharacterApi {
  final String baseUrl = "https://rickandmortyapi.com/api/character";

  Future<List<Map<String, dynamic>>> getAllCharacters() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> characterList = json.decode(response.body)["results"];
      return characterList.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to load characters");
    }
  }

  Future<List<Map<String, dynamic>>> getRandomCharacters() async {
    final response = await http.get(Uri.parse("$baseUrl?random=true&count=20"));

    if (response.statusCode == 200) {
      final List<dynamic> characterList = json.decode(response.body);
      return characterList.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to load random characters");
    }
  }

  Future<List<Map<String, dynamic>>> searchCharactersByName(String name) async {
    final response = await http.get(Uri.parse("$baseUrl?name=$name"));

    if (response.statusCode == 200) {
      final List<dynamic> characterList = json.decode(response.body)["results"];
      return characterList.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to search characters by name");
    }
  }

  Future<List<Map<String, dynamic>>> searchCharactersByStatus(
      String status) async {
    final response = await http.get(Uri.parse("$baseUrl?status=$status"));

    if (response.statusCode == 200) {
      final List<dynamic> characterList = json.decode(response.body)["results"];
      return characterList.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to search characters by status");
    }
  }

  Future<List<Map<String, dynamic>>> searchCharactersBySpecies(
      String species) async {
    final response = await http.get(Uri.parse("$baseUrl?species=$species"));

    if (response.statusCode == 200) {
      final List<dynamic> characterList = json.decode(response.body)["results"];
      return characterList.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to search characters by species");
    }
  }

  Future<List<Map<String, dynamic>>> searchCharactersByGender(
      String gender) async {
    final response = await http.get(Uri.parse("$baseUrl?gender=$gender"));

    if (response.statusCode == 200) {
      final List<dynamic> characterList = json.decode(response.body)["results"];
      return characterList.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to search characters by gender");
    }
  }
}
