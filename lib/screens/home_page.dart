import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:rick_and_morty_app/providers/character_provider.dart';
import 'package:rick_and_morty_app/providers/episode_provider.dart';
import 'package:rick_and_morty_app/providers/location_provider.dart';

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
    //characterProvider.getAllCharacters(page);

    characterProvider.getAllCharacters(page);
    episodeProvider.getAllEpisodes(page);
    locationProvider.getAllLocations();
    characterProvider.getRandomCharacters();

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading == true;
        });
        page++;
        //await episodeProvider.getAllEpisodes(page);
        await episodeProvider.getAllEpisodes(page);
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
              child: episodeProvider.episodes.isNotEmpty
                  ? EpisodeList(
                      episodeProvider: episodeProvider,
                      isLoading: isLoading,
                      scrollController: scrollController,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            Expanded(
              child: locationProvider.locations.isNotEmpty
                  ? LocationList(
                      locationProvider: locationProvider,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationList extends StatelessWidget {
  const LocationList({super.key, required this.locationProvider});

  final LocationProvider locationProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: locationProvider.locations.length,
        itemBuilder: (context, index) {
          final location = locationProvider.locations[index];
          return ListTile(
            title: Text(location.name),
            subtitle: Text(location.dimension),
            leading: Text(location.type),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    super.key,
    required this.episodeProvider,
    required this.scrollController,
    required this.isLoading,
  });

  final EpisodeProvider episodeProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        controller: scrollController,
        itemCount: isLoading
            ? episodeProvider.episodes.length + 2
            : episodeProvider.episodes.length,
        itemBuilder: (context, index) {
          if (index < episodeProvider.episodes.length) {
            final episode = episodeProvider.episodes[index];
            return ListTile(
              title: Text(episode.name),
              subtitle: Text(episode.airDate),
              leading: Text(episode.episode),
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

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

// class CharacterList extends StatelessWidget {
//   const CharacterList({super.key, required this.characterProvider});

//   final CharacterProvider characterProvider;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, childAspectRatio: 1 / 1.2),
//       itemCount: characterProvider.characters.length,
//       itemBuilder: (context, index) {
//         final character = characterProvider.characters[index];

//         return GestureDetector(
//           onTap: () {
//             context.go('/character');
//           },
//           child: Card(
//             child: Column(
//               children: [
//                 Image.network(character.image!),
//                 Text(character.name!),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
