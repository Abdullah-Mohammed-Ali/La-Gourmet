import 'package:lagourmet/Data%20Layer/Modles/ingerdients.dart';

class MealModel {
  late final String id;
  late final String? title;
  late final String imgUrl;
  late final String category;
  late final String instructions;
  List<Ingredient> ingerdients = [];

  MealModel.fromJSON(Map<String, dynamic> json) {
    id = json["idMeal"];
    title = json["strMeal"];
    category = json["strCategory"];
    imgUrl = json["strMealThumb"];
    instructions = json["strInstructions"];
    for (int i = 0; i < 20; i++) {
      if (json["strIngredient${i + 1}"] != '' &&
          json["strIngredient${i + 1}"] != null) {
        ingerdients.add(
          Ingredient(
            name: json["strIngredient${i + 1}"],
            measure: json["strMeasure${i + 1}"],
          ),
        );
      }
    }
  }
  MealModel.fromJSONCategory(Map<String, dynamic> json) {
    id = json["idMeal"];
    title = json["strMeal"];
    imgUrl = json["strMealThumb"];
  }

  MealModel.tojson(id, title, imgUrl) {
    Map json = {};

    json['idCategory'] = id;
    json["strCategory"] = title;
    json["strCategoryThumb"] = imgUrl;
  }
}
