import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lagourmet/BLOC%20Layer/recipe_cubit.dart';
import 'package:lagourmet/Constants/const_widget.dart';
import 'package:lagourmet/Constants/my_colors.dart';
import 'package:lagourmet/Constants/strings.dart';
import 'package:lagourmet/Presentation%20Layer/Reusable%20Components/category_item.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = RecipeCubit.get(context);
    return BlocBuilder<RecipeCubit, RecipeState>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: AppTextField(
                      searchController: searchController, cubit: cubit),
                ),
                if (searchController.text.isEmpty ||
                    state is BottomNavBarChange)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Enter Your Favorite Food',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 31,
                            fontWeight: FontWeight.w200,
                            color: MyColors.main),
                      ),
                    ),
                  )
                else if (state is GetCategoryLoadingState)
                  Center(child: CircularProgressIndicator())
                else if (state is GetSearchResultSuccessState)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.searchResults.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MealsListItem(
                          listOfMeals: state.searchResults,
                          index: index,
                          onTap: () async {
                            loading(context);
                            await RecipeCubit.get(context)
                                .getMealById(state.searchResults[index].id);
                            Navigator.pop(context);
                            Navigator.pushNamed(context, MyStrings.mealScreen,
                                arguments:
                                    RecipeCubit.get(context).currentMeal);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        )),
      );
    });
  }
}

class AppTextField extends StatelessWidget {
  AppTextField({
    Key? key,
    required this.searchController,
    required this.cubit,
  }) : super(key: key);

  final TextEditingController searchController;
  final RecipeCubit cubit;
  String search = '';
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      onChanged: (value) async {
        search = value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        labelText: 'Search',
        fillColor: Colors.amber,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(25)),
        labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            FontAwesomeIcons.search,
            color: Colors.grey[700],
          ),
          onPressed: () async {
            await cubit.getSearchedRecipe(search);
          },
        ),
      ),
    );
  }
}
