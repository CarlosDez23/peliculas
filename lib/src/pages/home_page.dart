import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';
import 'package:peliculas/src/widgets/card_swipper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget> [
            _cardSwipper(),
            _createHorizontalListView(context),
          ],
        ),
      )
    );
  }

  Widget _cardSwipper() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return CardSwipper(
            movies: snapshot.data,
          );
        }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      },
    );
  }

  Widget _createHorizontalListView(BuildContext context) {
    return Container(
      //Que ocupe todo el ancho disponible
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares', style: Theme.of(context).textTheme.subtitle1
            )
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  //Le pasamos la función que llama al provider de películas entonces en el listener la va a ejecutar
                  //Le pasamos solo la referencia, por eso no lo pasamos con (), porque si no se ejecutaría
                  nextPage : peliculasProvider.getPopulares,
                );
              }else{
                return Center(child: CircularProgressIndicator()) ;  
              }
            },
          ),
        ],
      ),
    );
  }
}