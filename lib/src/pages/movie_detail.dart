import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieDetail extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {

    //Recibimos la película
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
  
    return Scaffold(
      body: CustomScrollView (
        //Los children
        slivers: <Widget> [
          _createAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _createPosterTitle(pelicula, context),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),

              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAppbar(Pelicula pelicula) {
    return SliverAppBar (
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      //Que se mantenga visible cuando se hace el scroll
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()) ,
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),

    );
  }

  Widget _createPosterTitle(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget> [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage (pelicula.getPoster()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text(
                  pelicula.title, 
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis
                ),
                Row(
                  children: <Widget> [
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                )
              ]
            )
          )
        ],
      )
    );
  }

  Widget _description(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}