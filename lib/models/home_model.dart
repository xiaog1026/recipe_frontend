class Person {
  String name;
  String avatarURL;

  Person.fromMap(Map<String, dynamic> json) {
    this.name = json["name"];
    this.avatarURL = json["avatars"]["medium"];
  }
}

class Actor extends Person {
  Actor.fromMap(Map<String, dynamic> json): super.fromMap(json);
}

class Director extends Person {
  Director.fromMap(Map<String, dynamic> json): super.fromMap(json);
}
int counter = 1;

class Item {
  int rank;
  String imageURL;
  String title;
  String playDate;
  double rating;
  List<String> genres;
  List<String> scrollName;
  List<String> scrollImageURL;
  List<String> foodNameType3;
  List<String> foodImagesType3 ;


  List<Actor> casts;
  Director director;
  String originalTitle;

  Item.fromMap(Map<String, dynamic> json) {
    this.rank = counter++;
    this.imageURL = json["images"]["medium"];
    this.title = json["title"];
    this.playDate = json["year"];
    this.rating = json["rating"]["average"];
    this.genres = json["genres"].cast<String>();
    this.scrollImageURL = json["scroll_images"].cast<String>();
    this.scrollName = json["scroll_name"].cast<String>();

    this.foodNameType3 = json["food_name_type3"].cast<String>();
    this.foodImagesType3 = json["food_images_type3"].cast<String>();

    this.casts = (json["casts"] as List<dynamic>).map((item) {
      return Actor.fromMap(item);
    }).toList();
    this.director = Director.fromMap(json["directors"][0]);
    this.originalTitle = json["original_title"];
  }
}