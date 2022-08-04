import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/models/oder.dart';
import 'package:food_app/screen/order/order_details_screen/order_details_screen.dart';
import 'package:provider/provider.dart';

import '../dot.dart';

class OrderUiDesign extends StatelessWidget {
  const OrderUiDesign({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderModel>(context);
    // final val = order.cart;
    // DateTime datetime = DateTime.now();
    // String datetime1 = DateFormat("yyyy-MM-dd").format(datetime);
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
                child: Column(
              children: List.generate(
                  order.cart.length,
                  (index) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(order.cart[index].title),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: CustomColor.grey100,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Ordered',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quantity : ' +
                                    order.cart[index].quantity.toString(),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Price : ₹ ' +
                                    order.cart[index].price.toString(),
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ],
                          ),
                        ],
                      )),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        OrderDetailsSCreen.routeName,
                        arguments: order.id);
                  },
                  child: const Text('More Details',
                      style: TextStyle(
                          color: CustomColor.orangecolor,
                          fontSize: 13,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
            const DotDivider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date : ' + order.datetime.toString().substring(0, 10),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    'Amount : ₹ ${order.amount}',
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
