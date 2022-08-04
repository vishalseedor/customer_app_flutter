import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';

import '../bottom_app_screen.dart';

class OrderEmptyScreen extends StatelessWidget {
  const OrderEmptyScreen({Key key}) : super(key: key);

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
              child: const Text('Your Order is Empty')),
          Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                'Looks like you havent\'t Order any product.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(BottomAppScreen.routeName);
              },
              child: const Text('ADD PRODUCT TO ORDER'))
        ],
      ),
    );
  }
}
