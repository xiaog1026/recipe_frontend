class MyTableItem {
  int userId;
  CurrentRecommendation currentRecommendation;
  CurrentRecommendConditionSummary currentRecommendConditionSummary;

  MyTableItem(
      {this.userId,
        this.currentRecommendation,
        this.currentRecommendConditionSummary});

  MyTableItem.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    currentRecommendation = json['current_recommendation'] != null
        ? new CurrentRecommendation.fromJson(json['current_recommendation'])
        : null;
    currentRecommendConditionSummary =
    json['current_recommend_condition_summary'] != null
        ? new CurrentRecommendConditionSummary.fromJson(
        json['current_recommend_condition_summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    if (this.currentRecommendation != null) {
      data['current_recommendation'] = this.currentRecommendation.toJson();
    }
    if (this.currentRecommendConditionSummary != null) {
      data['current_recommend_condition_summary'] =
          this.currentRecommendConditionSummary.toJson();
    }
    return data;
  }
}

class CurrentRecommendation {
  int dishCount;
  List<Dish> dish;

  CurrentRecommendation({this.dishCount, this.dish});

  CurrentRecommendation.fromJson(Map<String, dynamic> json) {
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
  String tagId;
  String tagName;

  Dish(
      {this.dishId,
        this.dishName,
        this.dishImageLink,
        this.tagId,
        this.tagName});

  Dish.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishImageLink = json['dish_image_link'];
    tagId = json['tag_id'];
    tagName = json['tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dish_id'] = this.dishId;
    data['dish_name'] = this.dishName;
    data['dish_image_link'] = this.dishImageLink;
    data['tag_id'] = this.tagId;
    data['tag_name'] = this.tagName;
    return data;
  }
}

class CurrentRecommendConditionSummary {
  List<Condition> validIngredents;
  List<Condition> nPersonWithBadTeeth;
  List<Condition> nKids;
  List<Condition> nDishs;
  List<Condition> nPerson;
  List<Condition> cookingTime;
  List<Condition> cost;
  List<Condition> favoriteIngredients;
  List<Condition> unlikeIngredients;
  List<Condition> favoriteFlavor;
  List<Condition> cookingMethod;
  List<Condition> medicalHistory;

  CurrentRecommendConditionSummary(
      {this.validIngredents,
        this.nPersonWithBadTeeth,
        this.nKids,
        this.nDishs,
        this.nPerson,
        this.cookingTime,
        this.cost,
        this.favoriteIngredients,
        this.unlikeIngredients,
        this.favoriteFlavor,
        this.cookingMethod,
        this.medicalHistory});

  CurrentRecommendConditionSummary.fromJson(Map<String, dynamic> json) {
    if (json['valid_ingredents'] != null) {
      validIngredents = new List<Condition>();
      json['valid_ingredents'].forEach((v) {
        validIngredents.add(new Condition.fromJson(v));
      });
    }
    if (json['n_person_with_bad_teeth'] != null) {
      nPersonWithBadTeeth = new List<Condition>();
      json['n_person_with_bad_teeth'].forEach((v) {
        nPersonWithBadTeeth.add(new Condition.fromJson(v));
      });
    }
    if (json['n_kids'] != null) {
      nKids = new List<Condition>();
      json['n_kids'].forEach((v) {
        nKids.add(new Condition.fromJson(v));
      });
    }
    if (json['n_dishs'] != null) {
      nDishs = new List<Condition>();
      json['n_dishs'].forEach((v) {
        nDishs.add(new Condition.fromJson(v));
      });
    }
    if (json['n_person'] != null) {
      nPerson = new List<Condition>();
      json['n_person'].forEach((v) {
        nPerson.add(new Condition.fromJson(v));
      });
    }
    if (json['cooking_time'] != null) {
      cookingTime = new List<Condition>();
      json['cooking_time'].forEach((v) {
        cookingTime.add(new Condition.fromJson(v));
      });
    }
    if (json['cost'] != null) {
      cost = new List<Condition>();
      json['cost'].forEach((v) {
        cost.add(new Condition.fromJson(v));
      });
    }
    if (json['favorite_ingredients'] != null) {
      favoriteIngredients = new List<Condition>();
      json['favorite_ingredients'].forEach((v) {
        favoriteIngredients.add(new Condition.fromJson(v));
      });
    }
    if (json['unlike_ingredients'] != null) {
      unlikeIngredients = new List<Condition>();
      json['unlike_ingredients'].forEach((v) {
        unlikeIngredients.add(new Condition.fromJson(v));
      });
    }
    if (json['favorite_flavor'] != null) {
      favoriteFlavor = new List<Condition>();
      json['favorite_flavor'].forEach((v) {
        favoriteFlavor.add(new Condition.fromJson(v));
      });
    }
    if (json['cooking_method'] != null) {
      cookingMethod = new List<Condition>();
      json['cooking_method'].forEach((v) {
        cookingMethod.add(new Condition.fromJson(v));
      });
    }
    if (json['medical_history'] != null) {
      medicalHistory = new List<Condition>();
      json['medical_history'].forEach((v) {
        medicalHistory.add(new Condition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.validIngredents != null) {
      data['valid_ingredents'] =
          this.validIngredents.map((v) => v.toJson()).toList();
    }
    if (this.nPersonWithBadTeeth != null) {
      data['n_person_with_bad_teeth'] =
          this.nPersonWithBadTeeth.map((v) => v.toJson()).toList();
    }
    if (this.nKids != null) {
      data['n_kids'] = this.nKids.map((v) => v.toJson()).toList();
    }
    if (this.nDishs != null) {
      data['n_dishs'] = this.nDishs.map((v) => v.toJson()).toList();
    }
    if (this.nPerson != null) {
      data['n_person'] = this.nPerson.map((v) => v.toJson()).toList();
    }
    if (this.cookingTime != null) {
      data['cooking_time'] = this.cookingTime.map((v) => v.toJson()).toList();
    }
    if (this.cost != null) {
      data['cost'] = this.cost.map((v) => v.toJson()).toList();
    }
    if (this.favoriteIngredients != null) {
      data['favorite_ingredients'] =
          this.favoriteIngredients.map((v) => v.toJson()).toList();
    }
    if (this.unlikeIngredients != null) {
      data['unlike_ingredients'] =
          this.unlikeIngredients.map((v) => v.toJson()).toList();
    }
    if (this.favoriteFlavor != null) {
      data['favorite_flavor'] =
          this.favoriteFlavor.map((v) => v.toJson()).toList();
    }
    if (this.cookingMethod != null) {
      data['cooking_method'] =
          this.cookingMethod.map((v) => v.toJson()).toList();
    }
    if (this.medicalHistory != null) {
      data['medical_history'] =
          this.medicalHistory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Condition {
  String conditionName;
  int conditionCode;
  double conditionValue;

  Condition(
      {this.conditionName, this.conditionCode, this.conditionValue});

  Condition.fromJson(Map<String, dynamic> json) {
    conditionName = json['condition_name'];
    conditionCode = json['condition_code'];
    conditionValue = json['condition_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition_name'] = this.conditionName;
    data['condition_code'] = this.conditionCode;
    data['condition_value'] = this.conditionValue;
    return data;
  }
}