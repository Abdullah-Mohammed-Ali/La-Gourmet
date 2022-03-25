import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lagourmet/Data%20Layer/Modles/category_model.dart';
import 'package:lagourmet/Data%20Layer/Modles/meal_model.dart';
import 'package:lagourmet/Data%20Layer/Repositry/Data_repo.dart';
import 'package:lagourmet/Presentation%20Layer/screens/Profile_screen.dart';
import 'package:lagourmet/Presentation%20Layer/screens/categories.dart';
import 'package:lagourmet/Presentation%20Layer/screens/search_screen.dart';
import 'package:meta/meta.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(RecipeInitial());

  static RecipeCubit get(context) => BlocProvider.of(context);
  DataRepository _dataRepository = DataRepository();

  MealModel? randomMeal;
  MealModel? currentMeal;

  List<MealModel> categoryMeal = [];

  List<MealModel> searchResults = [];
  List<CategoryModel> categories = [];
  List screens = [
    CategoriesScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
  int bottomNavCurrentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.houseUser),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      label: '',
    ),
  ];

  onBottomBarTap(int index) async {
    bottomNavCurrentIndex = index;
    emit(BottomNavBarChange());
  }

  void getCategories() async {
    emit(GetCategoryLoadingState());
    try {
      await getRandomMeal();
      categories = await _dataRepository.getCategories();
      emit(GetCategorySuccessState());
    } catch (e) {
      emit(GetCategoryErrorState(e.toString()));
    }
  }

  Future<void> getRandomMeal() async {
    try {
      randomMeal = await _dataRepository.getRandomMeal();
      //print(randomMeal!.imgUrl);
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  Future<void> getMealById(String id) async {
    try {
      currentMeal = await _dataRepository.getMealById(id);
      print(currentMeal!.imgUrl);
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  Future<void> getCategoryMeals(String category) async {
    try {
      emit(GetCategoryLoadingState());
      categoryMeal = await _dataRepository.getCategoryMeals(category);
      emit(GetCategorySuccessState());
    } catch (e) {
      print('sdfsdf......');
      emit(
        GetCategoryErrorState(
          e.toString(),
        ),
      );
      print(e.toString());
    }
  }

  Future<void> getSearchedRecipe(String name) async {
    try {
      emit(GetCategoryLoadingState());
      searchResults =
          await _dataRepository.getSearchResult(name) as List<MealModel>;
      emit(GetSearchResultSuccessState(searchResults));
    } catch (e) {
      print(e);
      emit(
        GetCategoryErrorState(
          e.toString(),
        ),
      );
    }
  }
}
