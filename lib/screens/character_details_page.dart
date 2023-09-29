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
    characterProvider.getEpisodesByCharacter(widget.character);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.character.name),
          ),
          body: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Hero(
                    tag: widget.character.id,
                    child: Image.network(
                      widget.character.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Text('Episodes'),
              //EpisodeList(character: character),
            ],
          )),
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
//     characterProvider.getEpisodesByCharacter(widget.character);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final characterProvider = Provider.of<CharacterProvider>(context);
//     return ListView.builder(
//       itemCount: characterProvider.episodes.length,
//       itemBuilder: (context, index) {
//         final episode = characterProvider.episodes[index];
//         return ListTile(
//           leading: Text(episode.episode!),
//           title: Text(episode.name!),
//         );
//       },
//     );
//   }
// }
