import 'package:bloc/bloc.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/model/character_model.dart';
import 'package:rick_and_morty/data/repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  List<Character> characters = [];
  List<Character> getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharactersLoadedState(characters));
      this.characters = characters;
    });
    return characters;
  }

  List<Character> searched = [];
  List<Character> searchedCharacters(String searching) {
    characterRepository.getSearchedCharacters('$filteredCharacterEndpoint$searching').then((value) {
      emit(ShearchedCharactersLoadedState(value));
      searched = value;
    });
    return searched;
  }
}
