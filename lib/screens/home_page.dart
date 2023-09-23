import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/api/character_api.dart';
import 'package:rick_and_morty_app/providers/api_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getAllCharacters();
  }

  final CharacterApi characterApi = CharacterApi();

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: apiProvider.characters.isNotEmpty
            ? CharacterList(
                apiProvider: apiProvider,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({super.key, required this.apiProvider});

  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: apiProvider.characters.length,
      itemBuilder: (context, index) {
        final character = apiProvider.characters[index];

        return GestureDetector(
          onTap: () {
            context.go('/character');
          },
          child: Card(
            child: Text(character.name!),
          ),
        );
      },
    );
  }
}
