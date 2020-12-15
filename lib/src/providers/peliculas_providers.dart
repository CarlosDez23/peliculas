import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{

  String _apikey = '8f2ff49857c923c883dbd9a27b85730c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  bool _isLoading = false;

  List<Pelicula> _listaPeliculasPopulares = new List();

  //Creacion de un stream
  //Broadcast para que varios lugares puedan escuchar el stream
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  //Introducimos películas al stream
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  //Escuchamos películas del stream
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  Future<List<Pelicula>> getEnCines() async{
    //Construcción de la URL
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language,
    });
    return await _handleResponse(url);
  }

  Future<List<Pelicula>> getPopulares() async{
    //Para que no esté realizando constantemente peticiones
    if(_isLoading){
      return [];
    }
    _isLoading = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular',{
      //queryParameters
      'api_key' : _apikey,
      'language' : _language,
      'page': _popularesPage.toString(),
    });
    final response = await _handleResponse(url);
    _listaPeliculasPopulares.addAll(response);
    popularesSink(_listaPeliculasPopulares);
    _isLoading = false;
    return response;
  }

  Future<List<Pelicula>> _handleResponse(Uri url) async{
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> searchMovie (String query) async{
    final url = Uri.https(_url, '3/search/movie',{
      //queryParameters
      'api_key'  : _apikey,
      'language' : _language,
      'query'    : query,
    });
    return await _handleResponse(url);
  }

  //Cerramos el stream
  void  disposeStream(){
    _popularesStreamController?.close();
  }
}