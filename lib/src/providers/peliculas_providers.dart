import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{

  String _apikey = '8f2ff49857c923c883dbd9a27b85730c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future <List<Pelicula>> getEnCines() async{
    //Construcción de la URL
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language,
    });
    return await _handleResponse(url);
  }

  Future<List<Pelicula>> getPopulares() async{
    final url = Uri.https(_url, '3/movie/popular',{
      //queryParameters
      'api_key' : _apikey,
      'language' : _language,
    });
    return await _handleResponse(url);
  }

  Future <List<Pelicula>> _handleResponse(Uri url) async{
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }
}