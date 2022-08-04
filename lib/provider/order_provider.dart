import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_app/const/config.dart';
import 'package:food_app/models/address/address.dart';

import 'package:food_app/models/cart.dart';
import 'package:food_app/models/oder.dart';
import 'package:food_app/provider/shareprefes_provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../const/color_const.dart';
import '../screen/order/order_screen.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orderProduct = [];
  bool _isLoading = false;
  bool get islOading {
    return _isLoading;
  }

  List<OrderModel> get orderproduct {
    return [..._orderProduct];
  }

  List<CartData> _cartData = [];

  List<CartData> get cartData {
    return [..._cartData];
  }

  OrderModel findById(String id) {
    return orderproduct.firstWhere((element) => element.id == id);
  }

  Future<void> getAllOrdered({BuildContext context}) async {
    print('order get api start');
    try {
      _orderProduct = [];

      _isLoading = true;

      List<OrderModel> _loadData = [];
      List<CartData> _cartval = [];

      var data = Provider.of<UserDetails>(context, listen: false);
      data.getAllDetails();
      print('check order api call -->> id ' + data.id);
      var headers = {
        'Accept': 'application/json',
        'Cookie': 'session_id=37a08583d395778c247a854498080eb1811d3fda'
      };
      print('check order api call -->> id ' + data.id);

      var response = await http.get(
          Uri.parse(
              'http://eiuat.seedors.com:8290/services/MobileOrderApi/get-order-details?userid=${data.id}&clientid=$client_id&processstatus=ordered'),
          headers: headers);
      print(
          'http://eiuat.seedors.com:8290/services/MobileOrderApi/get-order-details?userid=${data.id}&clientid=$client_id&processstatus=ordered');
      var jsonData = json.decode(response.body);
      // print(jsonData);
      if (response.statusCode == 200) {
        // print(jsonData['orders']['order'][0].length.toString() +
        //     'total length order');
        if (jsonData['orders'].toString() == '{}') {
          print('no order avalible');
          _isLoading = false;
          notifyListeners();
        } else {
          print('order loaded data value 1');
          for (var i = 0; i < jsonData['orders']['order'].length; i++) {
            print('order loaded data value 2');
            var text = jsonData['orders']['order'][i]['payload'].toString();

            final string2 = text.replaceAll('\'', "");

            final decoded = json.decode(string2);
            // print(decoded);
            String addr = decoded['Order']['address'];
            final List<String> addrData = addr.split(',');
            // print(addrData);
            var addresData = Addresss(
                addresstype: addrData[7].toString(),
                area: addrData[2].toString(),
                houseNumber: addrData[2].toString(),
                landmark: '',
                id: '',
                name: addrData[0].toString(),
                phoneNumber: addrData[5].toString(),
                pincode: addrData[3].toString(),
                state: addrData[6].toString(),
                town: addrData[5].toString());
            // print('address data val -->>' + addrData.toList().toString());
            _cartData = [];
            for (var j = 0; j < decoded['Order']['LineItems'].length; j++) {
              _cartData.add(CartData(
                  id: decoded['Order']['LineItems'][j]['productid'].toString(),
                  title: decoded['Order']['LineItems'][j]['productName']
                      .toString(),
                  price: decoded['Order']['LineItems'][j]['price'].toString(),
                  quantity:
                      decoded['Order']['LineItems'][j]['quantity'].toString()));
            }

            print('order cart data value -->>' + _cartData.toList().toString());

            // final quotedString =
            //     string2.replaceAllMapped(RegExp(r'\b\w+\b'), (match) {
            //   return '"${match.group(0)}"';
            // });

            // print(jsonData['orders']['order'][i]['orderid'].toString());
            // for (var j = 0;
            //     j < jsonData['orders']['order'][i]['payload']['LineItems'].length;
            //     j++) {
            //   print('line item');
            //   // print('line item data -->>' +
            //   //     jsonData['orders']['order'][i]['payload']['LineItems'][j]
            //   //             ['productid']
            //   //         .toString());
            // }

            print(jsonData['orders']['order'][i]['orderid']);
            print(decoded['Order']['amount']);
            print(addresData);
            print(_cartData);
            print(jsonData['orders']['order'][i]['date']);
            print(decoded['Order']['grandTotal']);
            print(decoded['Order']['paymentType']);

            _loadData.add(OrderModel(
              id: jsonData['orders']['order'][i]['orderid'].toString(),
              amount: decoded['Order']['amount'].toString(),
              address: addresData,
              cart: _cartData,

              datetime: jsonData['orders']['order'][i]['date'].toString(),
              itemTotal: 0.0,
              grandTotal: decoded['Order']['grandTotal'].toString(),
              payment: decoded['Order']['paymentType'].toString(),
              shipping: double.parse(decoded['Order']['shipping']),
              deliveryStatus:
                  jsonData['orders']['order'][i]['processstatus'].toString(),

              // address:Address(city: city, country: country, line1: line1, line2: line2, postalCode: postalCode, state: state)
            ));
          }

          _orderProduct = _loadData;
          _isLoading = false;
          notifyListeners();
        }
      } else if (response.statusCode == 500) {
        print('check order api call -->>');
        _isLoading = false;
      }
    } catch (e) {
      _isLoading = false;
      print('check order api call -->>' + e.toString());
    }
  }

  Future<void> postOrderApi({
    BuildContext context,
    String lineItem,
    String addressId,
    String addressDetails,
    String amount,
    String grandTotal,
    String paymentType,
    String shippingCharge,
  }) async {
    try {
      final data = Provider.of<UserDetails>(context, listen: false);
      data.getAllDetails();
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = json.encode({
        "params": {
          "orderid": "",
          "payload":
              "{\"Order\": {\"LineItems\": $lineItem, \"partner_id\": \"${data.patnerId}\", \"partner_shipping_id\": \"$addressId\", \"address\": \"$addressDetails\", \"amount\": \"$amount\", \"grandTotal\": \"$grandTotal\", \"paymentType\": \"$paymentType\",\"shipping\": \"$shippingCharge\"}}",
          "processstatus": "draft",
          "clientid": client_id,
          "receiver": "",
          "date": DateTime.now().toString().substring(0, 19),
          "userid": data.id
        }
      });
      print(body);

      var response = await http.post(
          Uri.parse('http://eiuat.seedors.com:8290/seedor-api/order/create'),
          headers: headers,
          body: body);
      print(response.body);
      if (response.statusCode == 200) {
        print('order successfully placed');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const SizedBox(
            height: 40,
            child: Center(
              child: Text('Order Placed Successfull'),
            ),
          ),

          margin: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: CustomColor.orangecolor,
          duration: const Duration(milliseconds: 1200),
          behavior: SnackBarBehavior.floating,
          // action: SnackBarAction(
          //   textColor: CustomColor.whitecolor,
          //   label: 'View cart',
          //   onPressed: () {},
          // ),
        ));

        Navigator.of(context).pushNamed(OrderScreen.routeName);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {}
  }

  void addorder({
    List<CartModel> cartproduct,
    String amount,
    String id,
    String grandtotal,
    double itemTotal,
    String payment,
    double shipping,
    String deliveryStatus,
    // Address deliveryAddress
  }) {
    DateTime datetime = DateTime.now();
    String datetime1 = DateFormat("yyyy-MM-dd").format(datetime);
    final order = OrderModel(
      id: DateTime.now().toString(),
      amount: amount,
      cart: null,
      datetime: datetime1,
      grandTotal: grandtotal,
      itemTotal: itemTotal,
      payment: payment,
      shipping: shipping,
      deliveryStatus: deliveryStatus,
      // address: deliveryAddress,
    );
    _orderProduct.add(order);
    notifyListeners();
  }
}

class CartData {
  final String id;
  final String title;
  final String price;

  final String quantity;

  CartData(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}
