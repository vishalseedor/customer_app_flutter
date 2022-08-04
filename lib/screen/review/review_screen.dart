import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/theme.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _reviewTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.2,
      child: Column(
        children: [
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              // print(rating);
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            // height: size.height * 0.065,
            decoration: BoxDecoration(
                color: CustomColor.grey100,
                borderRadius: BorderRadius.circular(10)),
            child: Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ThemeData().colorScheme.copyWith(
                        primary: CustomColor.orangecolor,
                      )),
              child: TextFormField(
                maxLines: 2,
                controller: _reviewTextController,
                style: CustomThemeData().sliderSubtitleText(),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Add your Review',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
