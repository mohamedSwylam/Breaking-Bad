import 'package:dio/dio.dart';

import 'end_point.dart';

class WebServices {
   Dio dio;

  WebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://www.breakingbadapi.com/api/',
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get(GET_CHARACTERS);
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }

  }

 Future<List<dynamic>> getQuotes(String charName) async {
    try {
      Response response = await dio.get(GET_Quotes,queryParameters:{'author': charName} );
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }

  }




}