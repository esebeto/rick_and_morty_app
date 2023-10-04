import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/providers/character_provider.dart';

class CharacterDetails extends StatefulWidget {
  final Character character;
  const CharacterDetails({super.key, required this.character});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  get character => null;

  @override
  void initState() {
    super.initState();
    final characterProvider =
        Provider.of<CharacterProvider>(context, listen: false);
    characterProvider.getEpisodes(widget.character);
  }

  @override
  Widget build(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);
    return Scaffold(
      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       floating: false,
      //       title: Text(widget.character.name!),
      //       pinned: false,
      //       expandedHeight: 450,
      //       flexibleSpace: Image.network(
      //         widget.character.image!,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ],
      // ),

      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: Hero(
                tag: widget.character.id!,
                child: Image.network(
                  widget.character.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Card(
                child: Column(
                  children: [
                    Text(widget.character.created.toString()),
                    Text(widget.character.gender!),
                    Text(widget.character.species!),
                    Text(widget.character.name!),
                    Text(widget.character.status!),
                    Text(widget.character.type!),
                    Text(widget.character.url!),
                    Text(widget.character.episode!.length.toString()),
                    Text(widget.character.id.toString()),
                    Text(widget.character.location!.name!),
                    Text(widget.character.origin!.name!),
                  ],
                ),
              ),
            ],
          ),
          const Text('Episodes'),
          Expanded(
            child: characterProvider.episodes.isNotEmpty
                ? EpisodeList(
                    character: character, characterProvider: characterProvider)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    super.key,
    required this.characterProvider,
    required character,
  });

  final CharacterProvider characterProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: characterProvider.episodes.length,
        itemBuilder: (context, index) {
          if (index < characterProvider.episodes.length) {
            final episode = characterProvider.episodes[index];
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




// class EpisodeList extends StatefulWidget {
//   const EpisodeList({super.key, required this.character});

//   final Character character;

//   @override
//   State<EpisodeList> createState() => _EpisodeListState();
// }

// class _EpisodeListState extends State<EpisodeList> {
//   @override
//   void initState() {
//     super.initState();
//     final characterProvider =
//         Provider.of<CharacterProvider>(context, listen: false);
//     characterProvider.getEpisodes(widget.character);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final characterProvider = Provider.of<CharacterProvider>(context);
//     return ListView.builder(
//       itemCount: characterProvider.episodes.length,
//       itemBuilder: (context, index) {
//         final episode = characterProvider.episodes[index];
//         print(episode.name);
//         return ListTile(
//           leading: Text(episode.episode!),
//           title: Text(episode.name!),
//         );
//       },
//     );
//   }
// }
