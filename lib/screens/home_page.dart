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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Rick & Morty'),
        ),
        body: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Random Character,'),
                Text('more...'),
              ],
            ),
            SizedBox(
              height: 100,
              child: apiProvider.characters.isNotEmpty
                  ? CharacterAvatar(apiProvider: apiProvider)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            Expanded(
              child: SizedBox(
                child: apiProvider.characters.isNotEmpty
                    ? CharacterList(
                        apiProvider: apiProvider,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({super.key, required this.apiProvider});

  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: apiProvider.characters.length,
      itemBuilder: (context, index) {
        final character = apiProvider.characters[index];
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 34,
                  backgroundImage: Image.network(character.image!).image,
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

class CharacterList extends StatelessWidget {
  const CharacterList({super.key, required this.apiProvider});

  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.2),
      itemCount: apiProvider.characters.length,
      itemBuilder: (context, index) {
        final character = apiProvider.characters[index];

        return GestureDetector(
          onTap: () {
            context.go('/character');
          },
          child: Card(
            child: Column(
              children: [
                Image.network(character.image!),
                Text(character.name!),
              ],
            ),
          ),
        );
      },
    );
  }
}
