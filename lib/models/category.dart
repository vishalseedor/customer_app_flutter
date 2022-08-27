import 'dart:typed_data';

import 'package:flutter/material.dart';

class Categories {
  final String id;
  final String title;
  final Uint8List image;

  bool isSelected = false;

  Categories(
      {@required this.id,
      @required this.title,
      @required this.isSelected,
      @required this.image,
      String value,
      String startprice,
      String endprice});

  // factory Categories.fromMap(Map<String, dynamic> json) {
  //   return Categories(
  //       id: json['id'].toString(),
  //       title: json['name'].toString(),
  //       image: ,
  //       isSelected: false);
  // }
}
