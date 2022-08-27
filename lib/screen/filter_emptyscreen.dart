import 'package:flutter/material.dart';
import 'package:food_app/screen/filter_screen.dart';

import '../const/color_const.dart';


class FilterEmptyScreen extends StatelessWidget {
  const FilterEmptyScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.remove_shopping_cart,
            color: CustomColor.orangecolor,
            size: size.height * 0.2,
          ),
          Container(
              margin: const EdgeInsets.all(10),
              child: const Text('Filter Product is Empty')),
          Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                'Looks like you havent\'t Filter any product.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              )),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.of(context);
          //           //.pushReplacementNamed(FilterSCreen.routeName);
          //     },
          //   )
        ],
      ),
    );
  }
}





