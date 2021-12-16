abstract class AppStates {}

class AppInitialState extends AppStates {}

class GetCharactersLoadingState extends AppStates {}

class GetCharactersSuccessState extends AppStates {}

class GetCharactersErrorState extends AppStates {
  final String error;

  GetCharactersErrorState(this.error);
}
