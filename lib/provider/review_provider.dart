import 'package:flutter/cupertino.dart';
import 'package:food_app/models/review.dart';

class ReviewProvider with ChangeNotifier {
  final List<Review> _review = [];
  List<Review> get review {
    return [..._review];
  }

  // void addreview(Review review) {
  //   final rev = Review(
  //       id: review.id,
  //       profile: review.profile,
  //       reviewTitle: review.reviewTitle,
  //       start: review.start);
  //   _review.insert(0, review);
  // }
}
