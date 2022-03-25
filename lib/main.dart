import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lagourmet/BLOC%20Layer/recipe_cubit.dart';
import 'package:lagourmet/Constants/strings.dart';
import 'BLOC Layer/observer.dart';
import 'Constants/my_colors.dart';
import 'Presentation Layer/screens/route.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  AppRoute _appRoute = AppRoute();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecipeCubit>(
      create: (context) => RecipeCubit()..getCategories(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.bars,
          backgroundColor: MyColors.bars,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 0,
              backgroundColor: MyColors.bars,
              unselectedItemColor: MyColors.font,
              selectedItemColor: MyColors.main),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            iconTheme: IconThemeData(color: MyColors.font),
            titleTextStyle: GoogleFonts.getFont(
              MyStrings.logoFontStyle,
              color: MyColors.font,
              fontSize: 30,
            ),
            backgroundColor: MyColors.bars,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: MyStrings.splash,
        onGenerateRoute: _appRoute.onGeneratedRoute,
      ),
    );
  }
}
