// ignore_for_file: invalid_required_positional_param

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_app/const/image_base64.dart';
import 'package:food_app/models/cart.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/provider/shareprefes_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../const/config.dart';
import '../services/snackbar.dart';

class CartProvider with ChangeNotifier {
  bool _isLoading = false;
  GlobalSnackBar globalSnackBar = GlobalSnackBar();

  bool get isLoading {
    return _isLoading;
  }

  List<CartModel> _cartproduct = [];
  List<CartModel> get cartproduct {
    return [..._cartproduct];
  }

  List<int> _prodId = [];
  List<int> get prodId {
    return _prodId;
  }

  // Future getAllCartProduct({List<int> prodId}) async {
  //   try {
  //     // Map<String, Favourite> loadData = {};
  //     List<CartModel> loadData = [];
  //     var headers = {
  //       'Content-Type': 'application/json',
  //     };

  //     var body = json.encode({
  //       "product_ids": prodId,
  //     });
  //     print(body + 'cart body');
  //     var response = await http.post(
  //         Uri.parse(
  //             'http://eiuat.seedors.com:8290/customer-mobile-app/get-product/$client_id'),
  //         headers: headers,
  //         body: body);
  //     var jsonData = await json.decode(response.body);
  //     print('cart started ');
  //     print('cart value' + jsonData.toString());
  //     if (response.statusCode == 200) {
  //       for (var i = 0; i < jsonData.length; i++) {
  //         final base64 = jsonData[i]['image_1024'] == ''
  //             ? customBase64
  //             : jsonData[i]['image_1024'];
  //         var image = base64Decode(base64);
  //         print(jsonData[i]['id']);
  //         print(jsonData[i]['display_name']);
  //         print(jsonData[i]['price']);
  //         print(jsonData[i]['image_1024']);
  //         loadData.add(CartModel(
  //             id: jsonData[i]['id'].toString(),
  //             title: jsonData[i]['display_name'].toString(),
  //             price: jsonData[i]['price'],
  //             imageUrl: image,
  //             quantity: 1));
  //         // loadData.
  //         // ignore: missing_return
  //         // _favourite.putIfAbsent('', () {
  //         //   Favourite(
  //         // id: jsonData[i]['create_uid'][0].toString(),
  //         // productTitle: jsonData[i]['display_name'].toString(),
  //         // productPrice: jsonData[i]['cart_qty'],
  //         // imageUrl: jsonData[i]['image_1024'],
  //         // productCategory: jsonData[i]['categ_id'][1]);
  //         //   notifyListeners();
  //         //   print('fav product ' + _favourite.toString());
  //         // });
  //         // loadData.putIfAbsent('32', () {
  //         //   print('welcome');

  //         //   // Favourite(
  //         //   //     id: jsonData[i]['create_uid'][0].toString(),
  //         //   //     productTitle: jsonData[i]['display_name'].toString(),
  //         //   //     productPrice: jsonData[i]['cart_qty'],
  //         //   //     imageUrl: jsonData[i]['image_1024'],
  //         //   //     productCategory: jsonData[i]['categ_id'][1]);
  //         // });

  //         print('simple' + loadData.toString());
  //       }
  //       _cartproduct = loadData;
  //       print(_cartproduct.length.toString() + 'fav data length');
  //       notifyListeners();
  //       print('kkkkkkk' + loadData.toString());
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } catch (e) {
  //     print('error ---->>' + e.toString());
  //   }
  // }

  Future cartProductId({BuildContext context}) async {
    try {
      _isLoading = true;

      List<CartModel> loadData = [];
      List<int> id = [];
      print('runing runing runiing');

      final data = Provider.of<UserDetails>(context, listen: false);

      data.getAllDetails();

      var response = await http.get(
        Uri.parse(
            'http://eiuat.seedors.com:8290/customer-app/mycart/${data.id}?clientid=$client_id&status=cart'),
      );

      if (response.statusCode == 200) {
        print('No product');
        var jsonData = json.decode(response.body);
        if (jsonData['entries'].toString() != '{}') {
          // var jsonData = json.decode(response.body);

          // print(response.body);
          print('cart product 200');
          for (var i = 0; i < jsonData['entries']['entry'].length; i++) {
            var data = int.parse(jsonData['entries']['entry'][i]['quantity']);
            var price =
                jsonData['entries']['entry'][i]['list_price'].toString() == ""
                    ? '0'
                    : jsonData['entries']['entry'][i]['list_price'].toString();
            // print('welcome cart' + jsonData['entries']['entry'][i].toString());
            // print(jsonData['entries']['entry'][i]['productid']);
            // id.add(int.parse(jsonData['entries']['entry'][i]['productid']));
            // print('product id + ${id[i]}');
            if (data >= 1) {
              id.add(int.parse(jsonData['entries']['entry'][i]['productid']));
              loadData.add(CartModel(
                  id: jsonData['entries']['entry'][i]['productid'].toString(),
                  title: jsonData['entries']['entry'][i]['product_variant_id']
                      .toString(),
                  price: price,
                  quantity: data));

              // _prodId = jsonData['entries']['entry'][i]['productid'];

              print('cart product id final' + loadData.toList().toString());
            }
          }
          _cartproduct = loadData;
          _prodId = id;
          _isLoading = false;
          print('completed cart loading --->>');
          notifyListeners();
          // await getAllCartProduct(prodId: _prodId);
        } else {
          _prodId = [];
          // await getAllProductFavApi(_prodId);
          _isLoading = false;
          print('completed cart loading --->>');
          notifyListeners();
        }
      } else {
        _isLoading = false;
        print('completed cart loading --->>');
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _isLoading = false;
      print('completed cart loading --->>');
      notifyListeners();
      print('Something went wrong jjdhjdgj welcome welcome');
    }
  }

  Future cartProductPost(
      {BuildContext context, String productId, int quantity}) async {
    try {
      final data = Provider.of<UserDetails>(context, listen: false);
      data.getAllDetails();
      var headers = {
        'Content-Type': 'application/json',
      };
      print(dateTimeNow);
      print(productId);
      var body = json.encode({
        "userid": data.id,
        "clientid": client_id,
        "productid": productId,
        "status": cartStatus,
        "created_date": dateTimeNow,
        "quantity": quantity
      });
      print(body);
      var response = await http.post(
          Uri.parse('http://eiuat.seedors.com:8290/customer-app/addtocart'),
          headers: headers,
          body: body);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        print('successfully post');
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteCart({
    @required String prodId,
    @required BuildContext context,
    @required int index,
  }) async {
    try {
      final user = Provider.of<UserDetails>(context, listen: false);
      user.getAllDetails();
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = json.encode({
        "productid": prodId,
        "userid": user.id,
        "clientid": client_id,
        "status": cartStatus,
      });
      print(body);
      var response = await http.delete(
        Uri.parse('http://eiuat.seedors.com:8290/customer-app/remove-cart'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 202) {
        _cartproduct.removeAt(index);

        notifyListeners();
        globalSnackBar.generalSnackbar(
            context: context, text: 'Deleted Successfull');
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  // int get productquantity {
  //   var qua = 0;
  //   _cartproduct.
  // }
  Future<void> removeAllCartProd({BuildContext context}) async {
    try {
      var data = Provider.of<UserDetails>(context, listen: false);
      data.getAllDetails();
      var header = {
        'Content-Type': 'application/json',
      };
      var body = json.encode({
        "userid": data.id.toString(),
        "clientid": client_id,
        "status": "cart"
      });
      print(body);
      var response = await http.delete(
          Uri.parse('http://eiuat.seedors.com:8290/customer-app/clear-cart'),
          body: body,
          headers: header);
      if (response.statusCode == 202) {
        globalSnackBar.generalSnackbar(
            context: context, text: ' Your Cart is clear');
        _cartproduct.clear();

        notifyListeners();
      } else {
        globalSnackBar.generalSnackbar(
            context: context, text: 'Something went wrong');
      }
    } catch (e) {
      print(e.toString());
      // globalSnackBar.generalSnackbar(
      //     context: context, text: 'Something went wrong');
    }
  }

  void cartIconButtton({@required BuildContext context}) {
    // var data = Provider.of<FavouriteProvider>(context, listen: false).fav;
    final cart = Provider.of<CartProvider>(context, listen: false);
    // print('fav product lemngth ${data.length}');
    final product =
        Provider.of<ProductProvider>(context, listen: false).product;

    if (cart.cartproduct.isNotEmpty) {
      for (var i = 0; i < product.length; i++) {
        print(product.length.toString() + 'product length');
        for (var j = 0; j < cart.cartproduct.length; j++) {
          print(cart.cartproduct.length.toString() + 'cart length');

          if (product[i].productId == cart.cartproduct[j].id) {
            print(cart.cartproduct[j].toString() +
                '  Cart product is true  ' +
                product[i].productId);
            product[i].isCart = true;
          } else {
            print('Fav product is false' + product[i].productId);

            // product[i].isFavourite = false;
          }
        }
      }
    } else if (cart.cartproduct.isEmpty) {
      print('data empty in favourite');
      for (var i = 0; i < product.length; i++) {
        product[i].isCart = false;
      }
    }
  }

  double get totalAmount {
    double total = 0.0;
    for (var value in _cartproduct) {
      total += double.parse(value.price) * value.quantity;
    }
    // _cartproduct.forEach((key, value) {
    //   total += value.price * value.quantity;
    // });

    return total.roundToDouble();
  }

  double get shippingcharge {
    var shipping = 0.0;
    var charge = 0.0;
    for (var value in _cartproduct) {
      shipping += double.parse(value.price) * value.quantity;
    }
    // _cartproduct.forEach((key, value) {
    //   shipping += value.price * value.quantity;
    // });
    if (shipping > 500) {
      charge = 0;
    } else if (shipping < 500) {
      charge = 50;
    }

    return charge.roundToDouble();
  }

  double get totalTax {
    var tax = 0.0;
    var total = 0.0;
    for (var value in _cartproduct) {
      total += double.parse(value.price) * value.quantity;
      tax = ((total / 100) * 8).toDouble();
    }
    // _cartproduct.forEach((key, value) {
    //   total += value.price * value.quantity;
    //   tax = ((total / 100) * 8).toInt();
    // });

    return tax.toDouble();
  }

  String get totalprice {
    double totalCast = 0.0;
    totalCast = totalAmount + shippingcharge + totalTax;

    // print('success total' + totalCast.toString());

    return totalCast.round().toString();
  }

  double get vattax {
    var vat = 0.0;
    var amount = 0.0;
    var percentage = 8.0;
    for (var value in _cartproduct) {
      amount += double.parse(value.price) * value.quantity;
    }
    // _cartproduct.forEach((key, value) {
    //   amount += value.price * value.quantity;
    // });
    vat = (amount + (percentage / 100) * amount);

    return vat;
  }

  void addToCart(
      {@required String id,
      // @required String title,
      // @required double price,
      // @required int index,
      // @required Uint8List imageUrl,
      @required int quantity}) {
    _cartproduct.indexWhere((element) => element.id == id);
    quantity + 1;
    notifyListeners();
  }

  void decreaseCount(
      {@required String id,
      @required String title,
      @required double price,
      @required Uint8List imageUrl,
      @required int quantity}) {
    if (_cartproduct.contains(id)) {
      // _cartproduct.update(
      //     id,
      //     (existingCart) => CartModel(
      //         id: existingCart.id,
      //         title: existingCart.title,
      //         price: existingCart.price,
      //         imageUrl: existingCart.imageUrl,
      //         quantity: existingCart.quantity - 1));
    }
    notifyListeners();
  }

  // void removeCart(
  //     {@required int index,
  //     @required String productId,
  //     BuildContext context}) async {
  //   _cartproduct.removeAt(index);
  //   await deleteCart(prodId: productId, context: context);
  //   notifyListeners();
  // }

  // void clear({BuildContext context}) {
  //   _cartproduct.clear();
  //   Provider.of<CartProvider>(context, listen: false)
  //       .removeAllCartProd(context: context);
  //   notifyListeners();
  // }

  void addCartProductIntoggle(@required String id, @required String title,
      @required double price, @required int quantity) {
    final newAddItem = CartModel(
        id: id, title: title, price: price.toString(), quantity: quantity + 1);
    if (_cartproduct.isNotEmpty) {
      bool isFound = false;
      for (int itemcount = 0; itemcount < _cartproduct.length; itemcount++) {
        if (_cartproduct[itemcount].id == newAddItem.id) {
          print("addCard");
          isFound = true;
          _cartproduct[itemcount].quantity + 1;
          notifyListeners();
          break;
        }
      }
      if (!isFound) {
        _cartproduct.add(newAddItem);
        notifyListeners();
      }
    } else {
      _cartproduct.add(newAddItem);
      notifyListeners();
    }
  }
}
