class MyTableItem {
  String dishType;
  String dishTypeName;
  int dishCount;
  List<Dish> dish;
  String ingredentTypeName;
  List<Ingredents> ingredents;
  String sideDishBaseTypeName;
  List<SideDishBases> sideDishBases;
  String sideDishOptionTypeName;
  String sideDishOptionLikeTypeName;
  List<SideDishOptionLikes> sideDishOptionLikes;
  String sideDishOptionHateTypeName;
  List<SideDishOptionHates> sideDishOptionHates;
  String sideDishOptionTasteTypeName;
  List<SideDishOptionTastes> sideDishOptionTastes;

  MyTableItem(
      {this.dishType,
        this.dishTypeName,
        this.dishCount,
        this.dish,
        this.ingredentTypeName,
        this.ingredents,
        this.sideDishBaseTypeName,
        this.sideDishBases,
        this.sideDishOptionTypeName,
        this.sideDishOptionLikeTypeName,
        this.sideDishOptionLikes,
        this.sideDishOptionHateTypeName,
        this.sideDishOptionHates,
        this.sideDishOptionTasteTypeName,
        this.sideDishOptionTastes});

  MyTableItem.fromJson(Map<String, dynamic> json) {
    dishType = json['dish_type'];
    dishTypeName = json['dish_type_name'];
    dishCount = json['dish_count'];
    if (json['dish'] != null) {
      dish = new List<Dish>();
      json['dish'].forEach((v) {
        dish.add(new Dish.fromJson(v));
      });
    }
    ingredentTypeName = json['ingredent_type_name'];
    if (json['ingredents'] != null) {
      ingredents = new List<Ingredents>();
      json['ingredents'].forEach((v) {
        ingredents.add(new Ingredents.fromJson(v));
      });
    }
    sideDishBaseTypeName = json['side_dish_base_type_name'];
    if (json['side_dish_bases'] != null) {
      sideDishBases = new List<SideDishBases>();
      json['side_dish_bases'].forEach((v) {
        sideDishBases.add(new SideDishBases.fromJson(v));
      });
    }
    sideDishOptionTypeName = json['side_dish_option_type_name'];
    sideDishOptionLikeTypeName = json['side_dish_option_like_type_name'];
    if (json['side_dish_option_likes'] != null) {
      sideDishOptionLikes = new List<SideDishOptionLikes>();
      json['side_dish_option_likes'].forEach((v) {
        sideDishOptionLikes.add(new SideDishOptionLikes.fromJson(v));
      });
    }
    sideDishOptionHateTypeName = json['side_dish_option_hate_type_name'];
    if (json['side_dish_option_hates'] != null) {
      sideDishOptionHates = new List<SideDishOptionHates>();
      json['side_dish_option_hates'].forEach((v) {
        sideDishOptionHates.add(new SideDishOptionHates.fromJson(v));
      });
    }
    sideDishOptionTasteTypeName = json['side_dish_option_taste_type_name'];
    if (json['side_dish_option_tastes'] != null) {
      sideDishOptionTastes = new List<SideDishOptionTastes>();
      json['side_dish_option_tastes'].forEach((v) {
        sideDishOptionTastes.add(new SideDishOptionTastes.fromJson(v));
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
    data['ingredent_type_name'] = this.ingredentTypeName;
    if (this.ingredents != null) {
      data['ingredents'] = this.ingredents.map((v) => v.toJson()).toList();
    }
    data['side_dish_base_type_name'] = this.sideDishBaseTypeName;
    if (this.sideDishBases != null) {
      data['side_dish_bases'] =
          this.sideDishBases.map((v) => v.toJson()).toList();
    }
    data['side_dish_option_type_name'] = this.sideDishOptionTypeName;
    data['side_dish_option_like_type_name'] = this.sideDishOptionLikeTypeName;
    if (this.sideDishOptionLikes != null) {
      data['side_dish_option_likes'] =
          this.sideDishOptionLikes.map((v) => v.toJson()).toList();
    }
    data['side_dish_option_hate_type_name'] = this.sideDishOptionHateTypeName;
    if (this.sideDishOptionHates != null) {
      data['side_dish_option_hates'] =
          this.sideDishOptionHates.map((v) => v.toJson()).toList();
    }
    data['side_dish_option_taste_type_name'] = this.sideDishOptionTasteTypeName;
    if (this.sideDishOptionTastes != null) {
      data['side_dish_option_tastes'] =
          this.sideDishOptionTastes.map((v) => v.toJson()).toList();
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

class SideDishBases {
  String sideDishBaseName;
  int sideDishBaseNum;
  String sideDishBaseUnit;

  SideDishBases(
      {this.sideDishBaseName, this.sideDishBaseNum, this.sideDishBaseUnit});

  SideDishBases.fromJson(Map<String, dynamic> json) {
    sideDishBaseName = json['side_dish_base_name'];
    sideDishBaseNum = json['side_dish_base_num'];
    sideDishBaseUnit = json['side_dish_base_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['side_dish_base_name'] = this.sideDishBaseName;
    data['side_dish_base_num'] = this.sideDishBaseNum;
    data['side_dish_base_unit'] = this.sideDishBaseUnit;
    return data;
  }
}

class SideDishOptionLikes {
  String sideDishOptionLikeName;
  int sideDishOptionLikeStatus;

  SideDishOptionLikes(
      {this.sideDishOptionLikeName, this.sideDishOptionLikeStatus});

  SideDishOptionLikes.fromJson(Map<String, dynamic> json) {
    sideDishOptionLikeName = json['side_dish_option_like_name'];
    sideDishOptionLikeStatus = json['side_dish_option_like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['side_dish_option_like_name'] = this.sideDishOptionLikeName;
    data['side_dish_option_like_status'] = this.sideDishOptionLikeStatus;
    return data;
  }
}

class SideDishOptionHates {
  String sideDishOptionHateName;
  int sideDishOptionHateStatus;

  SideDishOptionHates(
      {this.sideDishOptionHateName, this.sideDishOptionHateStatus});

  SideDishOptionHates.fromJson(Map<String, dynamic> json) {
    sideDishOptionHateName = json['side_dish_option_hate_name'];
    sideDishOptionHateStatus = json['side_dish_option_hate_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['side_dish_option_hate_name'] = this.sideDishOptionHateName;
    data['side_dish_option_hate_status'] = this.sideDishOptionHateStatus;
    return data;
  }
}

class SideDishOptionTastes {
  String sideDishOptionTasteName;
  int sideDishOptionTasteStatus;

  SideDishOptionTastes(
      {this.sideDishOptionTasteName, this.sideDishOptionTasteStatus});

  SideDishOptionTastes.fromJson(Map<String, dynamic> json) {
    sideDishOptionTasteName = json['side_dish_option_taste_name'];
    sideDishOptionTasteStatus = json['side_dish_option_taste_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['side_dish_option_taste_name'] = this.sideDishOptionTasteName;
    data['side_dish_option_taste_status'] = this.sideDishOptionTasteStatus;
    return data;
  }
}