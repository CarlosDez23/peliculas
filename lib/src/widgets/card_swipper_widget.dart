import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwipper extends StatelessWidget {

  final List<Pelicula> movies;

  //Constructor, le ponemos @required porque debe recibir ese argumento
  CardSwipper({@required this.movies});

  @override
  Widget build(BuildContext context) {

    //Establecemos las dimensiones de las tarjetas
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top:10.0),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          //Contenedor para aplicar estilos de borderRadius
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(movies[index].getPoster()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              //Se adapta la imagen a todo el ancho que tiene 
              fit: BoxFit.cover,
            ),
          ); 
        },
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        //El 70 por ciento del ancho de la pantalla
        itemWidth: _screenSize.width * 0.7,
        //La mitad de la pantalla
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}