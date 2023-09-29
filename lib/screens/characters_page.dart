import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/providers/character_provider.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    final characterProvider =
        Provider.of<CharacterProvider>(context, listen: false);
    characterProvider.getAllCharacters(page);

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading == true;
        });
        page++;
        await characterProvider.getAllCharacters(page);
        setState(() {
          isLoading == false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Characters'),
        ),
        body: characterProvider.characters.isNotEmpty
            ? CharacterList(
                characterProvider: characterProvider,
                scrollController: scrollController,
                isLoading: isLoading,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList(
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
          ? characterProvider.characters.length + 2
          : characterProvider.characters.length,
      itemBuilder: (context, index) {
        final character = characterProvider.characters[index];

        return GestureDetector(
          onTap: () {
            context.go('/character');
          },
          child: Card(
            child: Column(
              children: [
                Image.network(character.image),
                Text(character.name),
              ],
            ),
          ),
        );
      },
    );
  }
}
