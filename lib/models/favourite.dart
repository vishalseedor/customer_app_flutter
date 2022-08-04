import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class Favourite with ChangeNotifier {
  final String id;
  final String productTitle;
  final int productPrice;
  final Uint8List imageUrl;
  final String productCategory;

  Favourite(
      {@required this.id,
      @required this.productTitle,
      @required this.productPrice,
      @required this.imageUrl,
      @required this.productCategory});

  factory Favourite.fromJson(Map<String, dynamic> jsonData) {
    return Favourite(
        id: jsonData['create_uid'][0].toString(),
        productTitle: jsonData['display_name'].toString(),
        productPrice: jsonData['cart_qty'],
        imageUrl: json.decode(jsonData['image_1024']),
        productCategory: jsonData['categ_id'][1]);
  }
}
