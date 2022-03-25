import 'package:lagourmet/Data%20Layer/Modles/category_model.dart';
import 'package:lagourmet/Data%20Layer/Modles/meal_model.dart';
import 'package:lagourmet/Data%20Layer/Web-Services/meals_provide.dart';

class DataRepository {
  late MealsProvider _mealsProvider;
  DataRepository() {
    _mealsProvider = MealsProvider();
  }

  Future<List<CategoryModel>> getCategories() async {
    return await _mealsProvider.getCategories();
  }

  Future<MealModel> getRandomMeal() async {
    List data = await _mealsProvider.getRandomMeal();
    //print(data[0]);
    MealModel randomMeal = MealModel.fromJSON(data[0]);
    //print(randomMeal.ingerdients.toString());
    return randomMeal;
  }

  Future<MealModel> getMealById(String id) async {
    List data = await _mealsProvider.getMealById(id);
    //print(data[0]);
    MealModel randomMeal = MealModel.fromJSON(data[0]);
    //print(randomMeal.ingerdients.toString());
    return randomMeal;
  }

  Future<List<MealModel>> getCategoryMeals(String category) async {
    List<MealModel> _categoryMeals = [];
    List temp = await _mealsProvider.getCategoryMeals(category);
    _categoryMeals = temp
        .map(
          (e) => MealModel.fromJSONCategory(e),
        )
        .toList();
    print(_categoryMeals.length);

    return _categoryMeals;
  }

  Future<List> getSearchResult(String name) async {
    List<MealModel> test = [];
    if (name.isNotEmpty) {
      List temp = await _mealsProvider.getSearchResult(name);
      temp
          .map(
            (e) => test.add(
              MealModel.fromJSON(e),
            ),
          )
          .toList();
    }

    return test;
  }
}
