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
  @override
  void initState() {
    super.initState();
    final characterProvider =
        Provider.of<CharacterProvider>(context, listen: false);
    final episodeProvider =
        Provider.of<EpisodeProvider>(context, listen: false);
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    characterProvider.getAllCharacters();
    episodeProvider.getAllEpisodes();
    locationProvider.getAllLocations();
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Random Character,'),
                Text('more...'),
              ],
            ),
            SizedBox(
              height: 100,
              child: characterProvider.characters.isNotEmpty
                  ? CharacterAvatar(characterProvider: characterProvider)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            Expanded(
              flex: 2,
              child: episodeProvider.episode.isNotEmpty
                  ? EpisodeList(
                      episodeProvider: episodeProvider,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            Expanded(
              child: locationProvider.location.isNotEmpty
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
        itemCount: locationProvider.location.length,
        itemBuilder: (context, index) {
          final location = locationProvider.location[index];
          return ListTile(
            title: Text(location.name!),
            subtitle: Text(location.dimension!),
            leading: Text(location.type!),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}

class EpisodeList extends StatelessWidget {
  const EpisodeList({super.key, required this.episodeProvider});

  final EpisodeProvider episodeProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: episodeProvider.episode.length,
        itemBuilder: (context, index) {
          final episode = episodeProvider.episode[index];
          return ListTile(
            title: Text(episode.name!),
            subtitle: Text(episode.airDate!),
            leading: Text(episode.episode!),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
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
      itemCount: characterProvider.characters.length,
      itemBuilder: (context, index) {
        final character = characterProvider.characters[index];
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
  const CharacterList({super.key, required this.characterProvider});

  final CharacterProvider characterProvider;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.2),
      itemCount: characterProvider.characters.length,
      itemBuilder: (context, index) {
        final character = characterProvider.characters[index];

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
