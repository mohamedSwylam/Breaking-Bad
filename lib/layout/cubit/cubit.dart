import 'package:bloc/bloc.dart';
import 'package:breaking_bad/layout/cubit/states.dart';
import 'package:breaking_bad/models/character%20_model.dart';
import 'package:breaking_bad/shared/network/remote/web_services.dart';
import 'package:breaking_bad/shared/network/remote/end_point.dart';
import 'package:breaking_bad/shared/network/remote/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
   Repository charactersRepository;
  List<CharacterModel> characters = [];
  AppCubit(this.charactersRepository) : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<CharacterModel> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(GetCharactersSuccessState(characters));
      this.characters = characters;
    });
    return characters;
  }
}
