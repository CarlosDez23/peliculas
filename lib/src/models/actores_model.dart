
class Actores {
  List<Actor> actoresList = new List();
  
  Actores.fromJsonList(List<dynamic> jsonList) {
    if(jsonList == null){
      return;
    }
    jsonList.forEach((item){
      final actor = Actor.fromJsonMap(item);
      actoresList.add(actor);
    });
  }
}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  Actor.fromJsonMap(Map<String, dynamic> json){
    adult              = json["adult"];
    gender             = json["gender"].cast<int>();
    id                 = json["id"].cast<int>();
    knownForDepartment = json["known_for_department"];
    name               = json["name"];
    originalName       = json["original_name"];
    popularity         = json["popularity"];
    profilePath        = json["profile_path"];
    castId             = json["cast_id"].cast<int>();
    character          = json["character"];
    creditId           = json["credit_id"];
    order              = json["order"].cast<int>();
    department         = json["department"];
    job                = json["job"];
  }

  String getActorImg(){
    if(profilePath == null){
      return 'https://www.fasionrouse.com/wp-content/themes/gecko/assets/images/placeholder.png';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
