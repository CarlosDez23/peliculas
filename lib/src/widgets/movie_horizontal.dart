import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;

  MovieHorizontal({@required this.peliculas});
  
  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height *  0.2,
      child: PageView(
        children: _cards(context),
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          //Va a mostrar 3 imagenes y un framgento de otra (0.3 * 3 = 0.9)
          viewportFraction: 0.3,
        ),
      ),      
    );
  }

  List<Widget> _cards(context) {
    //Map hace que por cada película en este caso devuelva un container con las propiedades establecidas
    return peliculas.map((pelicula){
      return Container(
        margin: EdgeInsets.only(right:15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage( 
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPoster()),
                fit: BoxFit.cover,
                height: 115.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              //Coloca 3 puntos cuando el texto no cabe
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        )
      );
    }).toList();
  }
}