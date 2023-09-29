import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/model/location_model.dart';
import 'package:http/http.dart' as http;

class LocationProvider with ChangeNotifier {
  static const baseUrl = 'https://rickandmortyapi.com/api/location/';
  List<Location> locations = [];

  Future<void> getAllLocations() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      locations = (jsonBody['results'] as List)
          .map((characterJson) => Location.fromJson(characterJson))
          .toList();

      notifyListeners();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
