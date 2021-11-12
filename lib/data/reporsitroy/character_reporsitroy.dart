import '../models/characters.dart';
import '../models/quote.dart';
import '../web_services/characters_web_services.dart';

class CharacterReporsitory {
  final CharacterWebServices characterWebServices;

  CharacterReporsitory(this.characterWebServices);
  Future<List<Character>> getAllCharacters() async {
    final Characters = await characterWebServices.getAllCharacters();
    return Characters.map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getCharacterquote(String charName) async {
    final quotes = await characterWebServices.getCharacterquote(charName);
    return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  }
}
