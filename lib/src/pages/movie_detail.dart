import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieDetail extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {

    //Recibimos la película
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
  
    return Scaffold(
      body: Center(
        child: Text('Pelicula: ${pelicula.title}'),
      )
      
    );
  }
}