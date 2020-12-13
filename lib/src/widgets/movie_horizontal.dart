import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  //Esta es la función que vamos a mandar desde home, que es la que llama al provider para llamar a la api
  final Function nextPage;

  MovieHorizontal({@required this.peliculas, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    //Va a mostrar 3 imagenes y un framgento de otra (0.3 * 3 = 0.9)
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;
    //Para que cuando llegue al final del scroll vuelva a llamar a más películas
    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        //Es el método que nos pasan desde el home
        nextPage();
      }
    });
    return Container(
      height: _screenSize.height *  0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int index){
          return _createCard(context, peliculas[index]);
        }
      ),      
    );
  }

  // List<Widget> _cards(context) {
  //   //Map hace que por cada película en este caso devuelva un container con las propiedades establecidas
  //   return peliculas.map((pelicula){
  //     return Container(
  //       margin: EdgeInsets.only(right:15.0),
  //       child: Column(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20.0),
  //             child: FadeInImage( 
  //               placeholder: AssetImage('assets/img/no-image.jpg'), 
  //               image: NetworkImage(pelicula.getPoster()),
  //               fit: BoxFit.cover,
  //               height: 115.0,
  //             ),
  //           ),
  //           SizedBox(height: 5.0),
  //           Text(
  //             pelicula.title,
  //             //Coloca 3 puntos cuando el texto no cabe
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           )
  //         ],
  //       )
  //     );
  //   }).toList();
  // }

  Widget _createCard(BuildContext context, Pelicula pelicula){
    final movieCard = Container(
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
    return GestureDetector(
      onTap: (){
        //Le pasamos la película a la otra página
        Navigator.pushNamed(context, 'detail', arguments: pelicula);
      },
      child: movieCard,

    );
  }
}
