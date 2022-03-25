import 'package:flutter/material.dart';
import 'package:lagourmet/Constants/images.dart';
import 'package:lagourmet/Constants/my_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    var totalHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(MyColors.shado, BlendMode.srcATop),
              child: MyImages.backGround(),
            ),
            SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
