import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/providers/character_provider.dart';

class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({super.key, required this.characterProvider});

  final CharacterProvider characterProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: characterProvider.randomCharacters.length,
      itemBuilder: (context, index) {
        final character = characterProvider.randomCharacters[index];
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.go('/character', extra: character);
                },
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.black,
                  child: Hero(
                    tag: character.id,
                    child: CircleAvatar(
                      radius: 34,
                      backgroundImage: Image.network(character.image).image,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        );
      },
    );
  }
}
