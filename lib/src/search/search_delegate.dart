import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';

//Implementamos la interfaz SearchDelegate
class DataSearch extends SearchDelegate{

  final peliculasProvider = new PeliculasProvider();
  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Superman',
    'Lobezno',
    'Deadpool',
    'Batman',
  ];

  final peliculasRecientes = [
    'Spiderman', 
    'Capitán américa',
  ];

  String seleccion = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones de nuestro appBar (a la derecha del appbar)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          //Query es una variable interna de la clase en la que está lo que escibe el usuario
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Builder que crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando el usuario va escribiendo
    if(query.isEmpty){
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData){
          return ListView(
            children: snapshot.data.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPoster()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: pelicula);
                },
              );
            }).toList(),
          );

        }else{
          return Center(
            child: CircularProgressIndicator()
          );
        }
      },
    );
  }


  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Sugerencias que aparecen cuando el usuario va escribiendo
  //   final listaSugerida = (query.isEmpty)
  //       ? peliculasRecientes
  //       : peliculas.where((pelicula) => pelicula.toLowerCase().startsWith(query.toLowerCase())
  //       ).toList();
  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (BuildContext context, int index){
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[index]),
  //         onTap: (){
  //           seleccion = listaSugerida[index];
  //           showResults(context);
  //         },
  //       );
  //     }
  //   );
  // }

 
}