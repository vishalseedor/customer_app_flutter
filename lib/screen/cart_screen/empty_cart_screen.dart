import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/provider/bottom_navigationbar_provider.dart';

import 'package:provider/provider.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final navigation = Provider.of<BottomNavigationBarProvider>(context);
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
              child: const Text('Your Cart is Empty')),
          Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                'Looks like you havent\'t added any product to your cart yet.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              )),
          ElevatedButton(
            onPressed: () {
              navigation.currentIndex = 0;
              // Navigator.of(context).pushNamed(BottomAppScreen.routeName);
            },
            child: const Text('ADD PRODUCT TO CART'),
          ),
        ],
      ),
    );
  }
}
