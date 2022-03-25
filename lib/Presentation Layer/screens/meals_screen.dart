import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lagourmet/BLOC%20Layer/recipe_cubit.dart';
import 'package:lagourmet/Constants/const_widget.dart';
import 'package:lagourmet/Constants/my_colors.dart';
import 'package:lagourmet/Constants/strings.dart';
import 'package:lagourmet/Data%20Layer/Modles/meal_model.dart';
import 'package:lagourmet/Presentation%20Layer/Reusable%20Components/category_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({Key? key, required this.categoryMeals}) : super(key: key);
  final List<MealModel>? categoryMeals;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipeCubit, RecipeState>(
      listener: (context, state) {},
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              MyStrings.appName,
              style: const TextStyle(color: MyColors.main),
            ),
          ),
          SliverFillRemaining(
              child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return MealsListItem(
                    listOfMeals: categoryMeals,
                    index: index,
                    onTap: () async {
                      loading(context);
                      await RecipeCubit.get(context)
                          .getMealById(categoryMeals![index].id);
                      Navigator.pop(context);
                      Navigator.pushNamed(context, MyStrings.mealScreen,
                          arguments: RecipeCubit.get(context).currentMeal);
                    },
                  );
                },
                itemCount: categoryMeals!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}
