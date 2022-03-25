import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagourmet/Constants/strings.dart';
import 'package:lagourmet/Data%20Layer/Modles/meal_model.dart';
import 'package:lagourmet/Presentation%20Layer/screens/search_screen.dart';
import 'package:lagourmet/Presentation%20Layer/screens/splash_screen.dart';

import 'home_screen.dart';
import 'login_screen.dart';
import 'meal_screen.dart';
import 'meals_screen.dart';

class AppRoute {
  Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyStrings.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case MyStrings.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case MyStrings.mealScreen:
        MealModel itemMeal = settings.arguments as MealModel;
        return MaterialPageRoute(
            builder: (_) => MealScreen(
                  randomMeal: itemMeal,
                ));
      case MyStrings.mealsScreen:
        List<MealModel> categoryMeals = settings.arguments as List<MealModel>;
        return MaterialPageRoute(
            builder: (_) => MealsScreen(
                  categoryMeals: categoryMeals,
                ));
      case MyStrings.searchScreen:
        List<MealModel> categoryMeals = settings.arguments as List<MealModel>;
        return MaterialPageRoute(
          builder: (_) => SearchScreen(),
        );
      case MyStrings.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
    }
  }
}
