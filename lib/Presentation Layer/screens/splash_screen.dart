import 'package:flutter/material.dart';
import 'package:lagourmet/Constants/my_colors.dart';
import 'package:lagourmet/Constants/images.dart';
import 'package:lagourmet/Constants/strings.dart';
import 'package:lagourmet/Data%20Layer/Web-Services/meals_provide.dart';
import 'package:lagourmet/Presentation%20Layer/Reusable%20Components/text-position.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // height and width of the screen .
    var totalWidth = MediaQuery.of(context).size.width;
    var totalHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(MyColors.shado, BlendMode.srcATop),
            child: MyImages.backGround(),
          ),
          MyImages.Logo(totalHeight, totalWidth),
          TextPlace(
            top: totalHeight * 0.34,
            left: (totalWidth - 210) / 2.2,
            text: MyStrings.appName,
            fontStyle: MyStrings.logoFontStyle,
            fontSize: totalHeight * 0.06,
            color: MyColors.mainFont,
          ),
          TextPlace(
            top: totalHeight * 0.465,
            left: (totalWidth - 250) / 2,
            text: MyStrings.hintText,
            fontStyle: MyStrings.hintFontStyle,
            fontSize: (20 / 720) * (totalHeight * 0.7),
            color: MyColors.fontHintText,
          ),
          Positioned(
            top: totalHeight * 0.8,
            width: totalWidth,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        primary: MyColors.main,
                      ),
                      onPressed: () async {
                        Navigator.pushReplacementNamed(
                            context, MyStrings.homeScreen);
                      },
                      child: Text(MyStrings.buttonText),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
