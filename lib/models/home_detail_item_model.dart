// class HomeDetailItem {
//   String dishId;
//   String dishName;
//   String dishImageLink;
//   String dishVedioLink;
//   String author;
//   String level;
//   List<Ingredent> ingredents=[];
//
//   HomeDetailItem();
//
//   HomeDetailItem.fromMap(Map<String, dynamic> json) {
//     this.dishId = json["dish_id"];
//     this.dishName = json["dish_name"];
//     this.dishImageLink = json["dish_image_link"];
//     this.dishVedioLink = json["dish_vedio_link"];
//     this.author = json["author"];
//     this.level = json["level"];
//     this.ingredents = (json["ingredents"] as List<dynamic>).map((item) {
//       return Ingredent.fromMap(item);
//     }).toList();
//   }
// }
// class Ingredent{
//   String ingredentName;
//   String ingredentWeight;
//
//   Ingredent.fromMap(Map<String, dynamic> json) {
//     this.ingredentName = json["ingredent_name"];
//     this.ingredentWeight = json["ingredent_weight"];
//   }
// }
class HomeDetailItem {
  String dishId;
  String dishName;
  String dishImageLink;
  String dishVedioLink;
  String author;
  String level;
  String tool;
  List<Ingredents> ingredents;
  List<Steps> steps;
  Rating rating;
  List<String> foodReviewImages;

  HomeDetailItem(
      {this.dishId,
        this.dishName,
        this.dishImageLink,
        this.dishVedioLink,
        this.author,
        this.level,
        this.tool,
        this.ingredents,
        this.steps,
        this.rating,
        this.foodReviewImages});

  HomeDetailItem.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishImageLink = json['dish_image_link'];
    dishVedioLink = json['dish_vedio_link'];
    author = json['author'];
    level = json['level'];
    tool = json['tool'];
    if (json['ingredents'] != null) {
      ingredents = new List<Ingredents>();
      json['ingredents'].forEach((v) {
        ingredents.add(new Ingredents.fromJson(v));
      });
    }
    if (json['steps'] != null) {
      steps = new List<Steps>();
      json['steps'].forEach((v) {
        steps.add(new Steps.fromJson(v));
      });
    }
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    foodReviewImages = json['food_review_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dish_id'] = this.dishId;
    data['dish_name'] = this.dishName;
    data['dish_image_link'] = this.dishImageLink;
    data['dish_vedio_link'] = this.dishVedioLink;
    data['author'] = this.author;
    data['level'] = this.level;
    data['tool'] = this.tool;
    if (this.ingredents != null) {
      data['ingredents'] = this.ingredents.map((v) => v.toJson()).toList();
    }
    if (this.steps != null) {
      data['steps'] = this.steps.map((v) => v.toJson()).toList();
    }
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['food_review_images'] = this.foodReviewImages;
    return data;
  }
}

class Ingredents {
  String ingredentName;
  String ingredentWeight;

  Ingredents({this.ingredentName, this.ingredentWeight});

  Ingredents.fromJson(Map<String, dynamic> json) {
    ingredentName = json['ingredent_name'];
    ingredentWeight = json['ingredent_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredent_name'] = this.ingredentName;
    data['ingredent_weight'] = this.ingredentWeight;
    return data;
  }
}

class Steps {
  String stepDescription;
  String stepImage;

  Steps({this.stepDescription, this.stepImage});

  Steps.fromJson(Map<String, dynamic> json) {
    stepDescription = json['step_description'];
    stepImage = json['step_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['step_description'] = this.stepDescription;
    data['step_image'] = this.stepImage;
    return data;
  }
}

class Rating {
  int max;
  double average;
  String stars;
  int min;

  Rating({this.max, this.average, this.stars, this.min});

  Rating.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    average = json['average'];
    stars = json['stars'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this.max;
    data['average'] = this.average;
    data['stars'] = this.stars;
    data['min'] = this.min;
    return data;
  }
}