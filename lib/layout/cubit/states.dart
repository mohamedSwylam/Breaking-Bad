import 'package:breaking_bad/models/character%20_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class GetCharactersLoadingState extends AppStates {}

class GetCharactersSuccessState extends AppStates {
  final List<CharacterModel> characters;

  GetCharactersSuccessState(this.characters);
}

class GetCharactersErrorState extends AppStates {
  final String error;

  GetCharactersErrorState(this.error);
}
