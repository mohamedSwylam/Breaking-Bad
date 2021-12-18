import 'package:breaking_bad/models/character%20_model.dart';
import 'package:breaking_bad/shared/network/remote/web_services.dart';

class Repository {
  final WebServices webServices;

  Repository(this.webServices);

  Future<List<CharacterModel>> getAllCharacters() async {
    final characters = await webServices.getAllCharacters();
    return characters.map((character) => CharacterModel.fromJson(character)).toList();
  }

}

