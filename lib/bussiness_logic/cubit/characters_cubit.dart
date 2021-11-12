import 'package:bloc/bloc.dart';
import '../../data/models/quote.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/models/characters.dart';
import '../../data/reporsitroy/character_reporsitroy.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharacterReporsitory characterReporsitory;

  List<Character> characters = [];
  CharactersCubit(this.characterReporsitory) : super(CharactersInitial());
  List<Character> getAllCharaters() {
    characterReporsitory.getAllCharacters().then((characters) {
      emit(ChararctersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes(String charName) {
    characterReporsitory.getCharacterquote(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
