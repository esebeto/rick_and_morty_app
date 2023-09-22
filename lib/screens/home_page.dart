import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/api/character_api.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final CharacterApi characterApi = CharacterApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final List<Map<String, dynamic>> characters =
                    await characterApi.getAllCharacters();
                // Imprime la información en formato JSON en la terminal
                if (kDebugMode) {
                  print(jsonEncode(characters));
                }
              },
              child: const Text('Obtener Personajes'),
            ),
          ],
        ),
      ),
    );
  }
}
