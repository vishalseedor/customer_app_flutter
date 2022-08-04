import 'package:flutter/material.dart';

class Review {
  final String id;
  final String profile;
  final String reviewTitle;
  final String start;

  Review(
      {@required this.id,
      @required this.profile,
      @required this.reviewTitle,
      @required this.start});
}
