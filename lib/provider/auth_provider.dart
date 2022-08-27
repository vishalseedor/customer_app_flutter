import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_app/const/config.dart';
import 'package:food_app/provider/device_info.dart';
import 'package:food_app/services/dialogbox.dart';

import 'package:food_app/services/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/bottom_app_screen.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  GlobalSnackBar globalSnackBar = GlobalSnackBar();
  GlobalServices services = GlobalServices();

  Future<void> registerApicall({
    @required String firstName,
    @required String lastName,
    @required String phoneNumber,
    @required String email,
    @required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      var header = {'Content-Type': 'application/json'};
      var body = json.encode({
        "clientid": client_id,
        "firstname": firstName,
        "lastname": lastName,
        "email": email,
        "mobile": phoneNumber
      });
      var response = await http.post(
          Uri.parse('http://eiuat.seedors.com:8290/customer-signup'),
          body: body,
          headers: header);
      // print('Login response -->>' + response.body.toString());
      // print('Login statuscode -->>' + response.statusCode.toString());
      if (response.statusCode == 200) {
        // print(response.body.toString());
        Navigator.of(context).pop();
        await globalSnackBar.successsnackbar(
            context: context,
            text: 'Your Account has been created successfully');
      } else if (response.statusCode == 500) {
        await globalSnackBar.generalSnackbar(
            context: context,
            text: 'User Already present with this email please try signIn');
      } else if (response.statusCode == 404) {
        await globalSnackBar.generalSnackbar(
            context: context, text: 'Something went wrong');
      }
      _isLoading = false;
      notifyListeners();
    } on HttpException catch (e) {
      print('Register api error -->' + e.message);
      await globalSnackBar.generalSnackbar(
          context: context, text: e.message.toString());
    }
    // print(isLoading.toString() + '-->loading fasle');
  }

  Future<void> loginapiCall({
    BuildContext context,
    @required String email,
    @required String password,
    // @required String deviveId,
    // @required String deviceName,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      var device = Provider.of<DeviceInformation>(context, listen: false);
      final prefs = await SharedPreferences.getInstance();
      var header = {
        'Content-Type': 'application/json',
      };
      var body = json.encode({
        "username": email,
        "password": password,
        "device_id": device.deviceId,
        "os_type": device.deviceName,
        "clientid": client_id
      });
      print(body.toString());
      var response = await http.post(
          Uri.parse('http://eiuat.seedors.com:8290/customer-app/login'),
          headers: header,
          body: body);
      print('http://eiuat.seedors.com:8290/customer-app/login'); 
      print(response.body.toString() + 'wefjoisdfidhivhdli');
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        prefs.setString('partner_id', jsonData['partner_id'].toString());
        prefs.setString('city', jsonData['primary_profile'][0]['city']);
        prefs.setString(
            'companyName', jsonData['primary_profile'][0]['company_name']);
        prefs.setString('country_id',
            jsonData['primary_profile'][0]['country_id'].toString());
        prefs.setString('email', email);
        prefs.setString('id', jsonData['primary_profile'][0]['id'].toString());
        prefs.setString('image_1024',
            jsonData['primary_profile'][0]['image_1024'].toString());
        prefs.setString(
            'mobile', jsonData['primary_profile'][0]['mobile'].toString());
        prefs.setString(
            'name', jsonData['primary_profile'][0]['name'].toString());
        prefs.setString(
            'state_id', jsonData['primary_profile'][0]['state_id'].toString());
        prefs.setString(
            'street', jsonData['primary_profile'][0]['street'].toString());
        prefs.setString(
            'street2', jsonData['primary_profile'][0]['street2'].toString());
        prefs.setString(
            'website', jsonData['primary_profile'][0]['website'].toString());
        prefs.setString('seedor_name', jsonData['seedor_name'].toString());
        prefs.setString('clientid', jsonData['clientid'].toString());
        prefs.setString(
            'city', jsonData['primary_profile'][0]['city'].toString());
        prefs.setString(
            'image', jsonData['primary_profile'][0]['image_1024'].toString());
        print(body.toString());

        Navigator.of(context).pushNamed(BottomAppScreen.routeName);
        await globalSnackBar.successsnackbar(
            context: context, text: 'Logged in successfull');
      } else {
        if (jsonData['ERROR'] == "Please enter the correct password") {
          services.customDialog(
              context, 'Password', 'Please enter the correct password');
        } else {
          await globalSnackBar.generalSnackbar(
              context: context,
              text: 'Something went wrong please try again later');
        }
        _isLoading = false;
        notifyListeners();
      }
    } on HttpException catch (e) {
      print('Login api error -->' + e.message);
      await globalSnackBar.generalSnackbar(
          context: context, text: e.message.toString());
    }
    _isLoading = false;
    notifyListeners();
  }
}
