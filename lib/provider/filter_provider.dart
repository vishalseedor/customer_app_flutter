import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/const/config.dart';

import '../const/image_base64.dart';
import '../models/product.dart';
import '../services/snackbar.dart';
import 'package:http/http.dart' as http;

class FilterProvider with ChangeNotifier {
  List<Product> _filterProduct = [];
  List<Product> get filterProducts {
    return [..._filterProduct];
  }

  GlobalSnackBar snackBar = GlobalSnackBar();
  bool _data = true;
  bool get data {
    // boolData();
    return _data;
  }

  bool _homeScreenLoading = false;

  bool get homeScreenLoading {
    return _homeScreenLoading;
  }

  void boolDataFalse() async {
    _data = false;
  }

  void boolDataTrue() {
    _data = true;
  }

  bool _loadingSpinner = false;

  bool get loadingSpinner {
    return _loadingSpinner;
  }

  Future<void> getProductData(
      {@required BuildContext context,
      @required String startprice,
      @required String endprice,
      @required List<String> listOfId}) async {
    try {
      print(
          "[('list_price','>',$startprice),('list_price','<',$endprice),('id','= ${listOfId.toList().toString()})]");
      _loadingSpinner = true;
      notifyListeners();
      List<Product> _loadedProduct = [];
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie':
            'session_id=d798a1308109711d1021e60acdb94a7a97b883f6; session_id=19498c36d54a58956a096f20b669fdb5ee623949'
      };

      var body = json.encode({
        "clientid": client_id,
        "type": "products",
        "domain":
            "[('list_price','>',$startprice),('list_price','<',$endprice),('categ_id','=',${listOfId.toList().toString()})]",
        "fields":
            "{'active','barcode','barcode','categ_id','currency_id','image_1024','image_variant_1024','lst_price','list_price','description','display_name','name','price','pricelist_id','product_variant_id','product_variant_ids'}"
      });
      var response = await http.post(
          Uri.parse('http://eiuat.seedors.com:8290/get-all-details'),
          headers: headers,
          body: body);

      var jsonData = json.decode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        for (var i = 0; i < jsonData.length; i++) {
          print(jsonData[i]['display_name']);
          double price = jsonData[i]['list_price'];

          final base64 = jsonData[i]['image_1024'].toString() == 'false'
              ? customBase64
              : jsonData[i]['image_1024'].toString();
          var image = base64Decode(base64);
          _loadedProduct.add(Product(
            categories: jsonData[i]['categ_id'][0].toString(),
            colories: '40',
            description: jsonData[i]['description'].toString(),
            imageUrl: image,
            price: price.toInt(),
            startprice: price.toString(),
            endprice: price.toString(),
            productId: jsonData[i]['id'].toString(),
            quantity: 1,
            rating: 3,
            review: [],
            subtitle: jsonData[i]['categ_id'][1],
            timer: 40,
            title: jsonData[i]['display_name'].toString(),
          ));
          _filterProduct = _loadedProduct;
          notifyListeners();
        }
      } else {}
    } on HttpException catch (e) {
      print('error in product prod -->>' + e.toString());
      _loadingSpinner = false;
      notifyListeners();
      snackBar.generalSnackbar(context: context, text: 'Something went wrong');
    }
  }
}
