import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lagourmet/BLOC%20Layer/recipe_cubit.dart';
import 'package:lagourmet/Constants/strings.dart';

import 'images.dart';
import 'my_colors.dart';

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      MyStrings.appName,
      style: TextStyle(color: MyColors.main, fontSize: 30),
    ),
    centerTitle: true,
  );
}

class randomMealContainer extends StatelessWidget {
  const randomMealContainer({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final RecipeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: Offset(2, 2),
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.fill,
          image: cubit.randomMeal?.imgUrl == null
              ? const AssetImage(MyImages.background) as ImageProvider
              : NetworkImage(cubit.randomMeal!.imgUrl),
        ),
      ),
      child: Stack(fit: StackFit.loose, children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xD8000000), Color(0x00FFFFFF)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Positioned(
          left: 15,
          bottom: 35,
          width: MediaQuery.of(context).size.width - 40,
          child: SizedBox(
            height: 90,
            child: Text(
              cubit.randomMeal!.title!,
              maxLines: 2,
              overflow: TextOverflow.fade,
              style: GoogleFonts.poppins(
                fontSize: 30,
                color: MyColors.mainFont,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        )
      ]),
    );
  }
}

void loading(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}
