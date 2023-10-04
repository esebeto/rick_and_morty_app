import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:rick_and_morty_app/providers/character_provider.dart';
import 'package:rick_and_morty_app/providers/episode_provider.dart';
import 'package:rick_and_morty_app/providers/location_provider.dart';
import 'package:rick_and_morty_app/widgets/character_avatar.dart';
import 'package:rick_and_morty_app/widgets/character_grid.dart';
import 'package:rick_and_morty_app/widgets/search_character.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    final characterProvider =
        Provider.of<CharacterProvider>(context, listen: false);
    final episodeProvider =
        Provider.of<EpisodeProvider>(context, listen: false);
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    characterProvider.getAllCharacters(page);
    episodeProvider.getAllEpisodes(page);
    locationProvider.getAllLocations();
    characterProvider.getRandomCharacters();
    characterProvider.getCharacterByName('rick', page);

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading == true;
        });
        page++;
        await characterProvider.getCharacterByName('rick', page);
        setState(() {
          isLoading == false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);
    final episodeProvider = Provider.of<EpisodeProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rick & Morty'),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchCharacter());
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Random Character,'),
                  TextButton(
                    child: const Text('MORE'),
                    onPressed: () => context.go('/characters'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: characterProvider.randomCharacters.isNotEmpty
                  ? CharacterAvatar(characterProvider: characterProvider)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            Expanded(
              child: characterProvider.rickCharacters.isNotEmpty
                  ? CharacterGrid(
                      characterProvider: characterProvider,
                      scrollController: scrollController,
                      isLoading: isLoading,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            // Expanded(
            //   child: episodeProvider.episodes.isNotEmpty
            //       ? EpisodeList(
            //           episodeProvider: episodeProvider,
            //           isLoading: isLoading,
            //           scrollController: scrollController,
            //         )
            //       : const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            // ),
            // Expanded(
            //   child: locationProvider.locations.isNotEmpty
            //       ? LocationList(
            //           locationProvider: locationProvider,
            //         )
            //       : const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
