import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:food_app/models/review.dart';

class Product with ChangeNotifier {
  final String productId;
  final String colories;
  final String subtitle;
  final String categories;
  final String title;
  final String description;
  final num rating;
  final int quantity;
  final int timer;
  final Uint8List imageUrl;
  final int price;
  final List<Review> review;
  bool isFavourite = false;
  bool isCart = false;

  Product(
      {@required this.productId,
      @required this.colories,
      @required this.subtitle,
      @required this.categories,
      @required this.title,
      @required this.description,
      @required this.rating,
      @required this.quantity,
      @required this.timer,
      @required this.imageUrl,
      @required this.price,
      @required this.review,
      this.isCart = false,
      this.isFavourite = false});

  // factory Product.fromMap(Map<String,dynamic> json){
  //   return Product(productId: json['id'], colories: json['active'], subtitle:
  //   json[''], categories: categories, title: title, description: description, rating: rating, quantity: quantity, timer: timer, imageUrl: imageUrl, price: price, review: review)
  // }
}
