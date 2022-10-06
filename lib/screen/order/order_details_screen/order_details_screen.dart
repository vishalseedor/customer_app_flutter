import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/theme.dart';

import 'package:food_app/models/review.dart';

import 'package:food_app/provider/address/address_data.dart';

import 'package:food_app/provider/order_provider.dart';
import 'package:food_app/screen/google_maps/googletracking.dart';

import 'package:food_app/screen/review/review_screen.dart';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderDetailsSCreen extends StatefulWidget {
  const OrderDetailsSCreen({Key key}) : super(key: key);
  static const routeName = 'order-details';

  @override
  State<OrderDetailsSCreen> createState() => _OrderDetailsSCreenState();
}

class _OrderDetailsSCreenState extends State<OrderDetailsSCreen> {
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  var reviewProduct = Review(
      id: DateTime.now().toString(),
      profile: 'sushalt',
      reviewTitle: 'wanted',
      start: '4');
  final TextEditingController _reviewTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _reviewTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context).settings.arguments as String;
    final order = Provider.of<OrderProvider>(context);
    final orderData = order.findById(orderId);
    // final cart = Provider.of<CartProvider>(context);
    // final review = Provider.of<ReviewProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    final address = Provider.of<AddressData>(context)
        .updatePickUpLocation(orderData.address);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: CustomColor.blackcolor,
              )),
          title: const Text('Order Detail'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  child: Text('Your Order',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
                const Divider(
                  color: CustomColor.grey300,
                ),
                Column(
                  children: List.generate(
                      orderData.cart.length,
                      (index) => ListTile(
                            // leading: Image.network(
                            //   // orderData.cart[index].imageUrl ??
                            //   'https://img.huffingtonpost.com/asset/5c1224861f00001b0826a6cb.jpeg?ops=scalefit_720_noupscale&format=webp',
                            //   width: size.width * 0.21,
                            //   height: size.height * 0.12,
                            //   fit: BoxFit.cover,
                            // ),
                            title: Text(
                              orderData.cart[index].title ?? 'null',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            subtitle: Text(
                              'Quantity : ' +
                                      orderData.cart[index].quantity
                                          .toString() ??
                                  '10',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  '₹ ' +
                                          orderData.cart[index].price
                                              .toString() ??
                                      '20',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                GestureDetector(
                                  // ignore: void_checks
                                  onTap: () {
                                    return showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Product Review"),
                                        content: const ReviewScreen(),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // review.addreview(reviewProduct);
                                              fToast.showToast(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                      color: CustomColor
                                                          .orangecolor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Text(
                                                      'Product Review Added Successfull',
                                                      style: CustomThemeData()
                                                          .drawerStyle()),
                                                ),
                                                gravity: ToastGravity.BOTTOM,
                                                toastDuration:
                                                    const Duration(seconds: 2),
                                              );
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(
                                    //         color: CustomColor.orangecolor),
                                    //     borderRadius: BorderRadius.circular(0)),
                                    child: Text(
                                      '',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                ),
                const Divider(
                  color: CustomColor.grey300,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Item total',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          '₹ ' + orderData.amount.toString(),
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Charge',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          '₹ ' + orderData.shipping.toString(),
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: CustomColor.grey300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grand Total',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      '₹ ' + orderData.grandTotal.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
                const Divider(
                  color: CustomColor.grey400,
                ),
                SizedBox(
                    width: size.width,
                    child: const Text(
                      'Track Your Order',
                      textAlign: TextAlign.left,
                    )),
                SizedBox(
                  height: size.height * 0.14,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Ordered',
                            style: orderData.deliveryStatus == 'Ordered'
                                ? Theme.of(context).textTheme.subtitle1
                                : Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: const Divider(
                              color: CustomColor.orangecolor,
                              thickness: 2,
                            ),
                          ),
                          Text(
                            'Inprocess',
                            style: orderData.deliveryStatus == 'Inprogress'
                                ? Theme.of(context).textTheme.subtitle1
                                : Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: const Divider(
                              color: CustomColor.grey400,
                            ),
                          ),
                          Text(
                            'Delivery',
                            style: orderData.deliveryStatus == 'Delivery'
                                ? Theme.of(context).textTheme.subtitle1
                                : Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                          child: const Text('Track your Order in Google Map'),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(GoogleMapTracking.routeName);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                    width: size.width,
                    child: const Text(
                      'Order Details',
                      textAlign: TextAlign.left,
                    )),
                const Divider(
                  color: CustomColor.grey300,
                ),
                orderDetails(
                    title: 'Order Number',
                    subtitle: orderData.id,
                    context: context),
                orderDetails(
                    title: 'Payment',
                    subtitle: orderData.payment,
                    context: context),
                orderDetails(
                    title: 'Date',
                    subtitle: orderData.datetime,
                    context: context),
                orderDetails(
                    title: 'Phone Number', subtitle: '', context: context),
                orderDetails(
                    title: 'Delivery to',
                    subtitle: orderData.address.name +
                            ',' +
                            orderData.address.houseNumber +
                            ',' +
                            orderData.address.area +
                            ',' +
                            orderData.address.landmark +
                            ',' +
                            orderData.address.town ??
                        'null'
                                ',' +
                            orderData.address.state ??
                        'null'
                                ',' +
                            orderData.address.pincode,
                    context: context)
              ],
            ),
          ),
        ));
  }

  Widget orderDetails({String title, String subtitle, BuildContext context}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }
}
