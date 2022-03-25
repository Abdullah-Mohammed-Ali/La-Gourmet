import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lagourmet/Constants/my_colors.dart';

Widget TextPlace({
  required double top,
  required double left,
  required String text,
  required String fontStyle,
  required double fontSize,
  required Color color,
}) {
  return Positioned(
    top: top,
    left: left,
    child: Text(
      text,
      style: GoogleFonts.getFont(fontStyle, color: color, fontSize: fontSize),
    ),
  );
}
