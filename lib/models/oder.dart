import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:food_app/models/address/address.dart';
import 'package:food_app/models/cart.dart';
import 'package:food_app/provider/order_provider.dart';

class OrderModel with ChangeNotifier {
  final String id;
  final String amount;
  final List<CartData> cart;
  final Addresss address;
  final double itemTotal;
  final String grandTotal;
  final String payment;
  final double shipping;
  final Uint8List imageUrl;
  String deliveryStatus;
  final String datetime;

  OrderModel({
    @required this.id,
    @required this.amount,
    @required this.cart,
    @required this.datetime,
    @required this.itemTotal,
    @required this.grandTotal,
    @required this.payment,
    @required this.shipping,
    @required this.deliveryStatus,
    @required this.address,
    @required this.imageUrl,
  });
}
