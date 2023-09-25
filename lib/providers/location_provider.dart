import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/model/location_model.dart';
import 'package:http/http.dart' as http;

class LocationProvider with ChangeNotifier {
  final String url = 'rickandmortyapi.com';
  List<Location> location = [];

  Future<void> getAllLocations() async {
    final result = await http.get(Uri.https(url, "/api/location/"));
    if (result.statusCode == 200) {
      final response = locationResponseFromJson(result.body);
      location.addAll(response.results!);
      notifyListeners();
    } else {
      throw Exception("Failed to load locations");
    }
  }
}
