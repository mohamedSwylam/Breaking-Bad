/*

import 'package:breaking_bad/models/character%20_model.dart';
import 'package:breaking_bad/shared/network/remote/dio_helper.dart';

import 'end_point.dart';

class CharactersRepository {
  final DioHelper dioHelper;
  CharactersRepository(this.dioHelper);
  Future<List<CharacterModel>> getAllCharacters() async {
    final characters = await DioHelper.getData(url: GET_CHARACTERS);
    return characters.map((character) => Character.fromJson(character)).toList();
  }
}
*/
