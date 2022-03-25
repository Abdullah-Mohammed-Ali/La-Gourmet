part of 'recipe_cubit.dart';

@immutable
abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class BottomNavBarChange extends RecipeState {}

class GetCategoryLoadingState extends RecipeState {}

class GetCategorySuccessState extends RecipeState {}

class GetSearchResultSuccessState extends RecipeState {
  final List<MealModel> searchResults;

  GetSearchResultSuccessState(this.searchResults);
}

class GetCategoryErrorState extends RecipeState {
  final String errorMessage;

  GetCategoryErrorState(this.errorMessage);
}
