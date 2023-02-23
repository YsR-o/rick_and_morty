import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/web_serveces/character_web_services.dart';
import '../model/character_model.dart';

class CharacterRepository {
  final CharacterServices characterServices;
  CharacterRepository(this.characterServices);

  Future<List<Character>> getAllCharacters() async {
    final List<Map<String, dynamic>> characters =
        await characterServices.getAllCharacters(characterEndpoint);
    characterEndpoint = allCharacternextUrl!;

    return List<Character>.from(
        characters.map((character) => Character.fromJson(character)));
  }

  Future<List<Character>> getSearchedCharacters(String url) async {
    final List<Map<String, dynamic>> characters =
        await characterServices.getAllCharacters(url);
    return List<Character>.from(
        characters.map((character) => Character.fromJson(character)));
  }
}
