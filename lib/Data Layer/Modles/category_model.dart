import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagourmet/Constants/my_colors.dart';

class CategoryModel {
  late final String id;
  late final String title;
  late final String imgUrl;
  bool _isFav = false;
  Color favColor = Colors.grey;

  get getIsfav {
    return _isFav;
  }

  setIsFav(bool fav) {
    _isFav = fav;
    if (_isFav) {
      favColor = Colors.red;
    } else {
      favColor = Colors.grey;
    }
  }

  CategoryModel.fromJSON(Map<String, dynamic> json) {
    id = json["idCategory"];
    title = json["strCategory"];
    imgUrl = json["strCategoryThumb"];
  }

  CategoryModel.tojson(id, title, imgUrl) {
    Map json = {};

    json['idCategory'] = id;
    json["strCategory"] = title;
    json["strCategoryThumb"] = imgUrl;
  }
}
