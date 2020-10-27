class HomeDetailItem {
  String dishId;
  String dishName;
  String dishImageLink;
  String dishVedioLink;
  String author;
  String level;
  String tool;
  List<Nutritions> nutritions;
  List<Ingredents> ingredents;
  List<Steps> steps;
  Rating rating;
  List<Comments> comments;

  HomeDetailItem(
      {this.dishId,
        this.dishName,
        this.dishImageLink,
        this.dishVedioLink,
        this.author,
        this.level,
        this.tool,
        this.nutritions,
        this.ingredents,
        this.steps,
        this.rating,
        this.comments});

  HomeDetailItem.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishImageLink = json['dish_image_link'];
    dishVedioLink = json['dish_vedio_link'];
    author = json['author'];
    level = json['level'];
    tool = json['tool'];
    if (json['nutritions'] != null) {
      nutritions = new List<Nutritions>();
      json['nutritions'].forEach((v) {
        nutritions.add(new Nutritions.fromJson(v));
      });
    }
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
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
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
    if (this.nutritions != null) {
      data['nutritions'] = this.nutritions.map((v) => v.toJson()).toList();
    }
    if (this.ingredents != null) {
      data['ingredents'] = this.ingredents.map((v) => v.toJson()).toList();
    }
    if (this.steps != null) {
      data['steps'] = this.steps.map((v) => v.toJson()).toList();
    }
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nutritions {
  int nutritionRate;
  String nutritionName;
  String nutritionWeight;

  Nutritions({this.nutritionRate, this.nutritionName, this.nutritionWeight});

  Nutritions.fromJson(Map<String, dynamic> json) {
    nutritionRate = json['nutrition_rate'];
    nutritionName = json['nutrition_name'];
    nutritionWeight = json['nutrition_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nutrition_rate'] = this.nutritionRate;
    data['nutrition_name'] = this.nutritionName;
    data['nutrition_weight'] = this.nutritionWeight;
    return data;
  }
}

class Ingredents {
  String ingredentName;
  int ingredentWeight;
  String ingredentUnit;

  Ingredents({this.ingredentName, this.ingredentWeight, this.ingredentUnit});

  Ingredents.fromJson(Map<String, dynamic> json) {
    ingredentName = json['ingredent_name'];
    ingredentWeight = json['ingredent_weight'];
    ingredentUnit = json['ingredent_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredent_name'] = this.ingredentName;
    data['ingredent_weight'] = this.ingredentWeight;
    data['ingredent_unit'] = this.ingredentUnit;
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

class Comments {
  String user;
  String commentContent;
  String commentDate;
  String image;

  Comments({this.user, this.commentContent, this.commentDate, this.image});

  Comments.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    commentContent = json['comment_content'];
    commentDate = json['comment_date'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['comment_content'] = this.commentContent;
    data['comment_date'] = this.commentDate;
    data['image'] = this.image;
    return data;
  }
}