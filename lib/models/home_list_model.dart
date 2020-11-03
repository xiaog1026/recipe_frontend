class HomeList {
  List<Cards> cards;

  HomeList({this.cards});

  HomeList.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      cards = new List<Cards>();
      json['cards'].forEach((v) {
        cards.add(new Cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cards != null) {
      data['cards'] = this.cards.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cards {
  String dishType;
  String dishTypeName;
  int dishCount;
  List<Dish> dish;

  Cards({this.dishType, this.dishTypeName, this.dishCount, this.dish});

  Cards.fromJson(Map<String, dynamic> json) {
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
  int dishId;
  String dishName;
  String dishImageLink;

  Dish({this.dishId, this.dishName, this.dishImageLink});

  Dish.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    if (dishName.length > 10 ){
      dishName = dishName.substring(0,10) + "..";
    }
    // else {
    //   while(dishName.length < 22) {
    //     dishName = dishName + " ";
    //   }
    // }
    print(dishName);
    print(dishName.length);
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