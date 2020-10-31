class HomeList {
  List<Dishs> dishs;

  HomeList({this.dishs});

  HomeList.fromJson(Map<String, dynamic> json) {
    if (json['dishs'] != null) {
      dishs = new List<Dishs>();
      json['dishs'].forEach((v) {
        dishs.add(new Dishs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dishs != null) {
      data['dishs'] = this.dishs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dishs {
  String dishType;
  String dishTypeName;
  int dishCount;
  List<Dish> dish;

  Dishs({this.dishType, this.dishTypeName, this.dishCount, this.dish});

  Dishs.fromJson(Map<String, dynamic> json) {
    dishType = json['dish_type'];
    dishTypeName = json['dish_type_name'];
    dishCount = json['dish_count'];
    if (json['dish'] != null) {
      dish = new List<Dish>();
      json['dish'].forEach((v) {
        dish.add(new Dish.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dish_type'] = this.dishType;
    data['dish_type_name'] = this.dishTypeName;
    data['dish_count'] = this.dishCount;
    if (this.dish != null) {
      data['dish'] = this.dish.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dish {
  String dishId;
  String dishName;
  String dishImageLink;

  Dish({this.dishId, this.dishName, this.dishImageLink});

  Dish.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishImageLink = json['dish_image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dish_id'] = this.dishId;
    data['dish_name'] = this.dishName;
    data['dish_image_link'] = this.dishImageLink;
    return data;
  }
}