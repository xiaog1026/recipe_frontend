class MoreDishModel {
  List<Data> data;

  MoreDishModel({this.data});

  MoreDishModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String dishType;
  String dishTypeName;
  List<Dish> dish;

  Data({this.dishType, this.dishTypeName, this.dish});

  Data.fromJson(Map<String, dynamic> json) {
    dishType = json['dish_type'];
    dishTypeName = json['dish_type_name'];
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