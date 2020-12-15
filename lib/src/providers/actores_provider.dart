import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/actores_model.dart';

class ActoresProvider{

  String _apikey = '8f2ff49857c923c883dbd9a27b85730c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Actor>> getMovieCasting(String movieId) async{

    final url = Uri.https(_url, '3/movie/$movieId/credits',{
      'api_key' : _apikey,
      'language' : _language,
    });
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final actores = new Actores.fromJsonList(decodedData['cast']);
    print(actores.actoresList[0]);
    return actores.actoresList;
  }
}