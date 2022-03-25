import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lagourmet/BLOC%20Layer/recipe_cubit.dart';
import 'package:lagourmet/Constants/const_widget.dart';
import 'package:lagourmet/Data%20Layer/Modles/meal_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MealScreen extends StatefulWidget {
  MealScreen({Key? key, required this.randomMeal}) : super(key: key);

  final MealModel? randomMeal;

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  var panelController = PanelController();

  double height = 100;
  Color ingredientsColor = Colors.grey;
  Color instructionsColor = Colors.black;
  ScrollPhysics panelScrollPhysics = const NeverScrollableScrollPhysics();
  bool _toggle = true;
  @override
  Widget build(BuildContext context) {
    var mealItem = widget.randomMeal;
    return Scaffold(
      appBar: buildAppBar(),
      body: SlidingUpPanel(
        minHeight: 150,
        backdropEnabled: true,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        maxHeight: 500,
        parallaxEnabled: true,
        controller: panelController,
        onPanelOpened: () {
          setState(() {
            print('opened');
            panelScrollPhysics = const BouncingScrollPhysics();
          });
        },
        onPanelClosed: () {
          setState(() {
            print('closed');
            _toggle = true;
            instructionsColor = Colors.black;
            ingredientsColor = Colors.grey;
            panelScrollPhysics = const NeverScrollableScrollPhysics();
          });
        },
        panel: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            //   physics: panelScrollPhysics,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 90,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _toggle = true;
                            instructionsColor = Colors.black;
                            ingredientsColor = Colors.grey;
                          });
                        },
                        child: Text(
                          'Instructions',
                          style: GoogleFonts.poppins(color: instructionsColor),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        width: 2,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _toggle = false;
                            instructionsColor = Colors.grey;
                            ingredientsColor = Colors.black;
                          });
                        },
                        child: Text(
                          'Ingredients',
                          style: GoogleFonts.poppins(color: ingredientsColor),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (_toggle)
                    Text(
                      mealItem!.instructions,
                      textAlign: TextAlign.center,
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: mealItem!.ingerdients.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 38,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '- ${mealItem.ingerdients[index].name}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                ]),
          ),
        ),
        body: Stack(
          children: [
            Body(
              height: 500,
              mealItem: mealItem,
            ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  Body({
    required this.height,
    required this.mealItem,
  });
  final double? height;
  final MealModel? mealItem;

  @override
  Widget build(BuildContext context) {
    var cubit = RecipeCubit.get(context);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 120.0,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.srcATop),
            child: Image.network(
              mealItem!.imgUrl,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 300,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Text(
                  mealItem!.title ?? 'saf',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
