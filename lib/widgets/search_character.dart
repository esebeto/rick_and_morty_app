import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/providers/character_provider.dart';

class SearchCharacter extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);

    Widget circleLoading() {
      return const Center(
        child: Text('No Hay Sugerencias'),
      );
    }

    if (query.isEmpty) {
      return circleLoading();
    }

    return FutureBuilder(
        future: characterProvider.getCharacter(query),
        builder: (context, AsyncSnapshot<List<Character>> snapshot) {
          if (!snapshot.hasData) {
            return circleLoading();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final character = snapshot.data![index];
              return ListTile(
                onTap: () {
                  context.go('/character', extra: character);
                },
                title: Text(character.name!),
                leading: Hero(
                  tag: character.id!,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(character.image!),
                  ),
                ),
              );
            },
          );
        });
  }
}
