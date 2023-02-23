part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoadedState extends CharactersState {
  final List<Character> character;

  CharactersLoadedState(this.character);
}

class ShearchedCharactersLoadedState extends CharactersState {
  final List<Character> searched;

  ShearchedCharactersLoadedState(this.searched);
}
