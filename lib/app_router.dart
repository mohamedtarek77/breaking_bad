import 'bussiness_logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/characters.dart';
import 'data/reporsitroy/character_reporsitroy.dart';
import 'data/web_services/characters_web_services.dart';
import 'presentation/screens/characters_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/screens/character_details_screen.dart';

class AppRouter {
  late CharacterReporsitory characterReporsitory;
  late CharactersCubit charactersCubit;
  AppRouter() {
    characterReporsitory = CharacterReporsitory(CharacterWebServices());
    charactersCubit = CharactersCubit(characterReporsitory);
  }
  Route? genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharacterScreen(),
          ),
        );
      case characterDetailScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CharactersCubit(characterReporsitory),
                  child: CharacterDetailScreen(
                    character: character,
                  ),
                ));
    }
  }
}
