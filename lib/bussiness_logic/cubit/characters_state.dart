part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class ChararctersLoaded extends CharactersState {
  final List<Character> characters;

  ChararctersLoaded(this.characters);
}

class QuotesLoaded extends CharactersState {
  final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}
