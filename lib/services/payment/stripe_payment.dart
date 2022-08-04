import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_app/const/color_const.dart';

import 'package:food_app/services/snackbar.dart';

import 'package:http/http.dart' as http;

class StripeTranscationResponse {
  String message;
  bool success;
  StripeTranscationResponse({@required this.message, @required this.success});
}

class StripeServices {
  static String apiBase = 'https://api.stripe.com/v1';
  // static String clientSecret = paymentIntentData['client_secret'];
  static String paymentApiUrl = '${StripeServices.apiBase}/payment-intents';
  static Uri paymentApiUri = Uri.parse(paymentApiUrl);
  static String secret =
      'sk_test_51KGcUiSGFopvxx2uxVsYsr8rhSpeGl1GKWmf7pPDECmtxyXpw1EGanVPNl0yqwtt1K5hKUQjKLRRs1mWYWAaC2sR00hFoL80bA';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeServices.secret}',
    'content-type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json'
  };
  // static init() {
  //   StripePayment.setOptions(StripeOptions(
  //     publishableKey:
  //         'pk_test_51K4MN3SA0BJngaWAguYK5oNC0qKquVwGGJ3baa6gZfUViRBqp4uz0YsLriO9O5yYRhxKmHHYU7QGhxvAmwe8bnOK00ACqeB7h6',
  //     merchantId: 'test',
  //     androidPayMode: 'test',
  //   ));
  // }

  // static Future<Map<String, dynamic>> createPaymentIntent(
  //     String amount, String currency) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       "amount": amount,
  //       "currency": currency,
  //     };
  //     var response =
  //         await http.post(paymentApiUri, headers: headers, body: body);
  //     return jsonDecode(response.body);
  //   } catch (error) {
  //     // print('ERROR OCCURED IN THE PAYMENT $error');
  //   }
  //   return null;
  // }

  // // ignore: missing_return
  // static Future<StripeTranscationResponse> paywithnewCard(
  //     {String amount, String currency}) async {
  //   try {
  //     var paymentMethod = await StripePayment.paymentRequestWithCardForm(
  //         CardFormPaymentRequest());
  //     var paymentIntent = await StripeServices.createPaymentIntent(
  //       amount,
  //       currency,
  //     );
  //     var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
  //         clientSecret: paymentIntent['client_secret'],
  //         paymentMethodId: paymentMethod.id));
  //     if (response.status == 'succeeded') {
  //       return StripeTranscationResponse(
  //           message: 'Transction successful', success: true);
  //     } else {
  //       StripeTranscationResponse(message: 'Transction failed', success: false);
  //     }
  //   } on PlatformException catch (error) {
  //     return StripeServices.getPlatformExpectionError(error);
  //   } catch (error) {
  //     return StripeTranscationResponse(
  //         message: 'Transction failed : $error', success: false);
  //   }
  // }

  // static getPlatformExpectionError(err) {
  //   String message = 'Somthing went worng';
  //   if (err.code == 'cancelled') {
  //     message = ' Transction cancelled';
  //   }
  //   return StripeTranscationResponse(message: message, success: false);
  // }

// static Future<void>  makePayment(String amount,String currency)async{
//   Map<String, dynamic> paymentIntentData;
//  try{
//    paymentIntentData = await createPaymentIntent(amount, currency);
//    await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
//      paymentIntentClientSecret: paymentIntentData['client_secret'],
//      applePay: true,
//      googlePay: true,
//      style: ThemeMode.system,
//      merchantCountryCode: 'IND',
//      merchantDisplayName: 'Seedorsoft',

//    ));
// //  displayPaymentSheet;
// await Stripe.instance.presentPaymentSheet();

//  }catch(err){
//    print('expection' + err.toString());
//  }
// }

// static void displayPaymentSheet(BuildContext context)async{
//   Map<String, dynamic> paymentIntentData;
// try{
//   await Stripe.instance.presentPaymentSheet(
//      parameters: PresentPaymentSheetParameters(clientSecret: paymentIntentData['client_secret'],
//      confirmPayment: true,
//      ),

//    );
//   //  paymentIntentData = null;
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Paid Successfull')));

// }on StripeException catch(error){
//   print('displayPaymentSheet' + error.toString());
//   GlobalServices().addressDialog(context: context, title: 'Payment Failed', content: error.toString());
// }
// }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": amount,
        "currency": currency,
        'payment_method_types[]': 'card',
      };
      // print('sushalt amount' + amount);
      var response =
          await http.post(paymentApiUri, headers: headers, body: body);
      return jsonDecode(response.body);
    } on StripeException catch (error) {
      // print('ERROR OCCURED IN THE PAYMENT $error');
      GlobalSnackBar()
          .generalSnackbar(text: 'Payment Failed ' + error.toString());
    }
    return null;
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }

  // ignore: missing_return
  static Future<Map<String, dynamic>> createPaymentIntents(
      String amount) async {
    print('payment gate way started createPaymentIntents');
    String url = 'https://api.stripe.com/v1/payment_intents';
    //  var amount = '500.00';

    calculateAmount(String amount) {
      final price = int.parse(amount) * 100;
      return price.toString();
    }

    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': 'inr',
      'payment_method_types[]': 'card'
    };
    print('payment gate way started createPaymentIntents body');
    print(body);

    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.body);
      if (response.statusCode == 200) {
        // print('success');
        return json.decode(response.body);
      } else {
        // print(json.decode(response.body));
        throw 'Failed to create PaymentIntents.';
      }
    } catch (err) {
      print(err.toString());
      GlobalSnackBar()
          .generalSnackbar(text: 'Somthing went worng Please try again later');
    }
  }

  static Future<void> createCreditCard(
      String customerId, String paymentIntentClientSecret) async {
    print('payment gate way started createCreditCard');
    try {
      print('payment gate way started createCreditCard ASYNC');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        // applePay: true,
        // googlePay: true,
        style: ThemeMode.light,
        // testEnv: false,
        // merchantCountryCode: 'IN',
        merchantDisplayName: 'Flutter Stripe Store Demo',
        customerId: customerId,
        paymentIntentClientSecret: paymentIntentClientSecret,
      ));
      print('payment gate way started createCreditCard FUNCTION END');
      await Stripe.instance.presentPaymentSheet();
      print('payment gate way started createCreditCard FUNCTION END 2');
    } catch (error) {
      print('payment gate way started createCreditCard error -->>');
      print(error.toString());
      GlobalSnackBar().generalSnackbar(
          text: 'Somthing went worng due to ' + error.toString());
    }
  }

  // ignore: missing_return
  static Future<Map<String, dynamic>> createCustomer() async {
    print('payment gate way started create customer');
    String url = 'https://api.stripe.com/v1/customers';

    try {
      print('payment gate way started create customer');
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: {'description': 'new customer'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print(json.decode(response.body));
        throw 'Failed to register as a customer.';
      }
    } catch (error) {
      print('payment gate way started create customer error');
      print(error.toString());
      GlobalSnackBar().generalSnackbar(
          text: 'Somthing went worng due to ' + error.toString());
    }
    // var response = await http.post(
    //   Uri.parse(url),
    //   headers: headers,
    //   body: {
    //     'description': 'new customer'
    //   },
    // );
    // if (response.statusCode == 200) {
    //   return json.decode(response.body);
    // } else {
    //   print(json.decode(response.body));
    //   throw 'Failed to register as a customer.';
    // }
  }

  static Future<void> payment(String amount) async {
    print('payment gate way started 1');
    final _customer = await createCustomer();
    print('payment gate way started create customer end');
    final _paymentIntent = await createPaymentIntents(amount);
    print('payment gate way started createPaymentIntents end');
    print('sushalt amount print' + amount.toString());
    await createCreditCard(_customer['id'], _paymentIntent['client_secret']);
  }
}
