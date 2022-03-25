import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lagourmet/BLOC%20Layer/recipe_cubit.dart';
import 'package:lagourmet/Constants/my_colors.dart';
import 'package:lagourmet/Constants/const_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = RecipeCubit.get(context);
        if (cubit.categories.isEmpty && cubit.randomMeal == null) {
          return Container(
            color: MyColors.bars,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
              appBar: buildAppBar(),
              drawer: Drawer(),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.bottomNavCurrentIndex,
                onTap: (index) async {
                  await cubit.onBottomBarTap(index);
                },
                items: cubit.bottomItems,
              ),
              body: cubit.screens[cubit.bottomNavCurrentIndex]);
        }
      },
    );
  }
}
