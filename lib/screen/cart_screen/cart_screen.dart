import 'package:flutter/material.dart';

import 'package:food_app/const/theme.dart';

import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/screen/cart_screen/empty_cart_screen.dart';
import 'package:food_app/widget/cart_product_wid/cart_full_design.dart';

import 'package:provider/provider.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key key}) : super(key: key);
  static const routeName = 'mycart_screen';

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CartProvider>(context);
    final cartproduct = data.cartproduct;
    void alertBox() async {
      return await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Clear Cart"),
          content: const Text("Do you want to clear all Cart Product"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                data.removeAllCartProd(context: context);

                Navigator.of(ctx).pop();
              },
              child: const Text("Clear"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        ),
      );
    }
    // final total = data.totalAmount;

    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(6),
              child: InkWell(
                onTap: () {
                  alertBox();
                },
                child: Text(
                  'Clear cart',
                  style: CustomThemeData().clearStyle(),
                ),
              ),
            ),
          )
        ],
      ),
      body: cartproduct.isEmpty
          ? const EmptyCartScreen()
          : const CartScreenDesign(),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.transparent,
      //   elevation: 0,
      //   child: Container(
      //     margin: const EdgeInsets.all(10),
      //     width: size.width,
      //     height: size.height * 0.05,
      //     child: ElevatedButton(
      //         onPressed: () {}, child: Text('Select Address at next')),
      //   ),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     width: size.width,
      //     height: size.height * 0.05,
      //     child: Text(data.shippingcharge.toString()),
      //   ),
      // ),
    );
  }
}
