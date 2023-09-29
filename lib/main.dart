import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/character_model.dart';

import 'package:rick_and_morty_app/providers/character_provider.dart';
import 'package:rick_and_morty_app/providers/episode_provider.dart';
import 'package:rick_and_morty_app/providers/location_provider.dart';

import 'package:rick_and_morty_app/screens/character_details_page.dart';
import 'package:rick_and_morty_app/screens/characters_page.dart';
import 'package:rick_and_morty_app/screens/home_page.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: 'character',
          builder: (context, state) {
            final character = state.extra as Character;
            return CharacterDetails(
              character: character,
            );
          },
        ),
        GoRoute(
          path: 'characters',
          builder: (context, state) {
            return const CharactersPage();
          },
        ),
      ],
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharacterProvider()),
        ChangeNotifierProvider(create: (_) => EpisodeProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Rick And Morty - APP',
        routerConfig: _router,
      ),
    );
  }
}
