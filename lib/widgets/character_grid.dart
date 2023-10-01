import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/providers/character_provider.dart';

class CharacterGrid extends StatelessWidget {
  const CharacterGrid(
      {super.key,
      required this.characterProvider,
      required this.scrollController,
      required this.isLoading});

  final CharacterProvider characterProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.2),
      itemCount: isLoading
          ? characterProvider.rickCharacters.length + 2
          : characterProvider.rickCharacters.length,
      itemBuilder: (context, index) {
        final rickCharacter = characterProvider.rickCharacters[index];

        return GestureDetector(
          onTap: () {
            context.go('/character');
          },
          child: Card(
            child: Column(
              children: [
                Image.network(rickCharacter.image),
                Text(rickCharacter.name),
              ],
            ),
          ),
        );
      },
    );
  }
}
