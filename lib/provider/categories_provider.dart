import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_app/const/config.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/services/snackbar.dart';
import 'package:http/http.dart' as http;

import '../const/image_base64.dart';

class CategoriesProvider with ChangeNotifier {
  static const path = 'Assets/Images';
  bool _loadingSpinner = false;

  bool get loadingSpinner {
    return _loadingSpinner;
  }

  GlobalSnackBar snackBar = GlobalSnackBar();

  List<Categories> _categories = [
    // Categories(
    //     id: 'a',
    //     title: 'Fast Food',
    //     // imageUrl: '$path/fast_food.png',
    //     isSelected: false),
    // Categories(
    //     id: 'b',
    //     title: 'Spicy Food',
    //     // imageUrl: '$path/spicy food.png',
    //     isSelected: false),
    // Categories(
    //     id: 'c',
    //     title: 'Sea Food',
    //     // imageUrl: '$path/sea food.png',
    //     isSelected: false),
    // Categories(
    //     id: 'd',
    //     title: 'Meat and poultry',
    //     // imageUrl: '$path/meat_cat.png',
    //     isSelected: false),
    // Categories(
    //     id: 'e',
    //     title: 'Drinks',
    //     // imageUrl: '$path/drinks.png',
    //     isSelected: false),
  ];
  List<Categories> get categories {
    return [..._categories];
  }

  set categories(List<Categories> value) {
    _categories = value;
  }

  Future<void> getAllategoryProd(BuildContext context) async {
    // List<Categories> parsed;

    try {
      List<Categories> _loadedProduct = [];
      var headers = {
        'Content-Type': 'application/json',
      };
      _loadingSpinner = true;
      var body = json.encode({"clientid": client_id, "type": "catagory"});
      var response = await http.post(
          Uri.parse('http://eiuat.seedors.com:8290/get-all-details'),
          headers: headers,
          body: body);
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        for (var i = 0; i < extractedData.length; i++) {
          final base64 = extractedData[i]['image_1024'] == '' ||
                  extractedData[i]['image_1024'] == false
              ? customBase64
              : extractedData[i]['image_1024'];
          var image = base64 == null
              ? base64Decode(customBase64)
              : base64Decode(base64);
          _loadedProduct.add(Categories(
              id: extractedData[i]['id'].toString(),
              title: extractedData[i]['name'].toString(),
              value: extractedData[i][''].toString(),
              isSelected: false,
              image: image ?? base64Decode(customBase64)));
        }
        _categories = _loadedProduct;

        notifyListeners();
      } else {
        snackBar.generalSnackbar(
            context: context, text: 'Something went wrong');
      }

      // _categories.map((data) {
      //   return Categories.fromMap(data);
      // }).toList();
      _loadingSpinner = false;

      notifyListeners();
    } on HttpException catch (e) {
      print('error in category prod -->>' + e.toString());
      _loadingSpinner = false;
      notifyListeners();
      snackBar.generalSnackbar(context: context, text: 'Something went wrong');
    }
  }
}
