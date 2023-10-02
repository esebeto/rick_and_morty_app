import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/providers/episode_provider.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    super.key,
    required this.episodeProvider,
    required this.scrollController,
    required this.isLoading,
    required character,
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
              title: Text(episode.name!),
              subtitle: Text(episode.airDate!),
              leading: Text(episode.episode!),
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
