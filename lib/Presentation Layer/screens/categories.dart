import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lagourmet/BLOC%20Layer/recipe_cubit.dart';
import 'package:lagourmet/Constants/const_widget.dart';
import 'package:lagourmet/Constants/strings.dart';
import 'package:lagourmet/Data%20Layer/Modles/category_model.dart';
import 'package:lagourmet/Presentation%20Layer/Reusable%20Components/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = RecipeCubit.get(context);
    List<CategoryModel> categories = cubit.categories;
    return BlocConsumer<RecipeCubit, RecipeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroMode(
                  child: Expanded(
                    flex: 3,
                    child: Hero(
                      tag: 'my',
                      child: GestureDetector(
                          child: randomMealContainer(cubit: cubit),
                          onTap: () {
                            Navigator.pushNamed(context, MyStrings.mealScreen,
                                arguments: cubit.randomMeal);
                          }),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Categories : ',
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 2,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CategoryItem(
                        categoryModel: categories[index],
                        onTap: () async {
                          loading(context);
                          await cubit.getCategoryMeals(categories[index].title);
                          Navigator.pop(context);
                          if (state is GetCategorySuccessState) {
                            Navigator.pushNamed(context, MyStrings.mealsScreen,
                                arguments: cubit.categoryMeal);
                          } else if (state is GetCategoryErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Please try again...${state.errorMessage.toString()}'),
                              ),
                            );
                          }
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 15);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
