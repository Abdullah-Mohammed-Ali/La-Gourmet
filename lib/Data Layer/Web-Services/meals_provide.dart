import 'package:dio/dio.dart';
import 'package:lagourmet/Data%20Layer/Modles/category_model.dart';

class MealsProvider {
  late final Dio dio;
  List<dynamic> _categories = [];
  List<dynamic> _categoryMeals = [];
  MealsProvider() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://www.themealdb.com/api/json/v1/1/',
      receiveDataWhenStatusError: true,
      receiveTimeout: 3000,
    );

    dio = Dio(options);
  }

  Future<dynamic> getCategories() async {
    try {
      Response response = await dio.get('categories.php');
      _categories = response.data['categories'];
      List<CategoryModel> categories =
          _categories.map((e) => CategoryModel.fromJSON(e)).toList();
      print(categories[0].title);
      return categories;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata
  Future<List> getMealById(String id) async {
    Response getRandomMeal =
        await dio.get('lookup.php', queryParameters: {'i': id});
    List mealmodel = getRandomMeal.data['meals'];
    return mealmodel;
  }

  Future<List> getRandomMeal() async {
    Response getRandomMeal = await dio.get('random.php');
    List mealmodel = getRandomMeal.data['meals'];
    return mealmodel;
  }

  Future<List> getCategoryMeals(String category) async {
    Response getCategoryMeals = await dio.get('filter.php?c=$category');
    _categoryMeals = getCategoryMeals.data['meals'];
    // print(_categoryMeals.length);
    return _categoryMeals;
  }

  Future<List> getSearchResult(String name) async {
    Response fetchResults = await dio.get(
      'search.php',
      queryParameters: {'s': name},
    );
    print(fetchResults.data['meals']);
    return fetchResults.data['meals'];
  }
}
