import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lagourmet/Constants/my_colors.dart';

class MyImages {
  static const String background = 'images/background.jpg';
  static const String logo = 'images/logo.svg';

  static Widget backGround() {
    return Center(
      child: Image.asset(
        MyImages.background,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  // My Reusable Widget for the logo
  static Widget Logo(double totalHeight, double totalWidth) {
    var fromTop = totalHeight / 5;
    var raduis = 100.0;
    var fromLeft = (totalWidth - (raduis * 2)) / 2;

    return Stack(children: [
      Positioned(
        top: fromTop,
        left: fromLeft,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(MyColors.shado, BlendMode.srcATop),
          child: CircleAvatar(
            radius: raduis,
            backgroundColor: MyColors.transparent,
          ),
        ),
      ),
      Positioned(
        top: fromTop + 10,
        left: fromLeft,
        child: SvgPicture.asset(
          MyImages.logo,
          width: 200,
        ),
      ),
    ]);
  }
}
