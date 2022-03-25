import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lagourmet/Constants/const_widget.dart';
import 'package:lagourmet/Constants/my_colors.dart';
import 'package:lagourmet/Data%20Layer/Modles/category_model.dart';
import 'package:lagourmet/Data%20Layer/Modles/meal_model.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({
    Key? key,
    required this.categoryModel,
    required this.onTap,
  }) : super(key: key);

  final CategoryModel categoryModel;
  final Function() onTap;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(-5, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: MyColors.cards,
      ),
      child: Stack(children: [
        Positioned(
          left: 10,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.heart,
              color: widget.categoryModel.favColor,
            ),
            onPressed: () {
              setState(() {
                print(!widget.categoryModel.getIsfav);

                widget.categoryModel.setIsFav(!widget.categoryModel.getIsfav);
              });
            },
          ),
        ),
        Positioned(
          top: 40,
          height: 190,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 180,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(widget.categoryModel.imgUrl),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.categoryModel.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 4,
                          color: Colors.grey[600],
                        ),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

class MealsListItem extends StatelessWidget {
  MealsListItem({
    Key? key,
    required this.listOfMeals,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final List<MealModel>? listOfMeals;
  final int? index;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(listOfMeals![index!].imgUrl),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Column(children: [
                    const SizedBox(height: 30),
                    Text(
                      listOfMeals![index!].title!,
                      maxLines: 2,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
                    )
                  ])),
            ],
          ),
        ));
  }
}
