import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class CartModel with ChangeNotifier {
  final String id;
  final String title;
  final String price;
 

  int quantity;

  CartModel(
      {@required this.id,
      @required this.title,
      @required this.price,
      
      this.quantity = 1});
}
