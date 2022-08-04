import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/const/config.dart';
import 'package:food_app/models/address/address.dart';
import 'package:food_app/services/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressProvider with ChangeNotifier {
  GlobalSnackBar snackBar = GlobalSnackBar();
  bool _isLoading = false;
  bool _isErrorLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  bool get isErrorLoading {
    return _isErrorLoading;
  }

  List<Addresss> _address = [
    // Address(
    //     id: "id",
    //     name: "name",
    //     phoneNumber: "phoneNumber",
    //     pincode: "pincode",
    //     houseNumber: "houseNumber",
    //     area: "area",
    //     landmark: "landmark",
    //     town: "town",
    //     state: "state",
    //     addresstype: "addresstype")
  ];
  List<Addresss> get address {
    return [..._address];
  }

  Future<void> getAddressData(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email');
      List<Addresss> loadData = [];
      var headers = {
        'Cookie':
            'session_id=b97381f19975df3426323681eb740be44dae5a7b; session_id=6afab8ba5bd04345bec575ecd16ec8069eaab5f9'
      };
      _isLoading = true;
      var response = await http.get(
          Uri.parse(
              'http://eiuat.seedors.com:8290/customer-app/userprofile?clientid=$client_id&username=$email'),
          headers: headers);
      print(
          'http://eiuat.seedors.com:8290/customer-app/userprofile?clientid=$client_id&username=$email');
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var otherAddress = jsonData['other_address'];
        for (var i = 0; i < otherAddress.length; i++) {
          loadData.add(Addresss(
            id: otherAddress[i]['id'].toString(),
            addresstype: otherAddress[i]['type'] ?? 'other',
            area: otherAddress[i]['street'].toString(),
            houseNumber: otherAddress[i]['street2'].toString(),
            landmark: otherAddress[i]['landmark'].toString() ?? '',
            name: otherAddress[i]['name'].toString(),
            phoneNumber: otherAddress[i]['mobile'].toString(),
            pincode: otherAddress[i]['zip'].toString(),
            state: 'Tamilnadu' ?? otherAddress[i]['state'].toString(),
            town: otherAddress[i]['city'].toString(),
          ));

          // print('success');
        }
        _address = loadData;
        print('add res data ' + _address.toString());
        notifyListeners();
      } else {
        print(response.reasonPhrase);

        _isErrorLoading = true;
        notifyListeners();
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      snackBar.generalSnackbar(context: context, text: 'Something went wrong');
      _isErrorLoading = true;
      notifyListeners();
    }
  }

  Future<void> addAddressData(Addresss address, BuildContext context) async {
    print(address.pincode + 'pincode');
    try {
      final prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email');
      String parentid = prefs.getString('id');
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = json.encode({
        "type": address.addresstype.toLowerCase(),
        "name": address.name,
        "street": address.area,
        "street2": address.houseNumber,
        "state_id": "1",
        "country_id": "1",
        "email": email,
        "phone": address.phoneNumber,
        "mobile": address.phoneNumber,
        "parent_id": parentid,
        "city": address.town,
        "zip": address.pincode,
        "clientid": client_id
      });
      print(body.toString());
      var response = await http.post(
          Uri.parse(
              'http://eiuat.seedors.com:8290/customer-app/create-address'),
          headers: headers,
          body: body);
      print(body.toString());
      if (response.statusCode == 200) {
        snackBar.successsnackbar(
            context: context, text: 'Address Added successfull');
      } else {
        print(response.reasonPhrase);
        snackBar.generalSnackbar(
            context: context, text: 'Something went wrong');
      }
    } on HttpException catch (e) {
      print('error in add address -->>' + e.toString());
    }
  }

  Future<void> updateAddressData(Addresss address, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email');
      String parentid = prefs.getString('id');
      var headers = {
        'Content-Type': 'application/json',
      };
      // print(address.id + 'addressid');
      var body = json.encode({
        "type": address.addresstype.toLowerCase(),
        "name": address.name,
        "street": address.area,
        "street2": address.houseNumber,
        "state_id": "1",
        "country_id": "1",
        "email": email,
        "phone": address.phoneNumber,
        "mobile": address.phoneNumber,
        "parent_id": parentid,
        "city": address.town,
        "zip": address.pincode,
        "clientid": client_id
      });

      var response = await http.put(
          Uri.parse(
              'http://eiuat.seedors.com:8290/customer-app/change-address/${address.id.toString()}'),
          headers: headers,
          body: body);
      print(body.toString());
      if (response.statusCode == 200) {
        snackBar.successsnackbar(
            context: context, text: 'Address Updated Successfull');
      } else {
        print(response.reasonPhrase);
        snackBar.generalSnackbar(
            context: context, text: 'Something went wrong');
      }
    } on HttpException catch (e) {
      print('error in update address  --> ' + e.message.toString());
      snackBar.generalSnackbar(context: context, text: 'Something went wrong');
    }
  }

  Future<void> deleteAddress(String id, BuildContext context) async {
    try {
      var headers = {
        'Cookie':
            'session_id=a10576593ca0176275f0f645dc2d0099de46fe1b; session_id=7dcdf561ed53db1b6bf29345ec305d1e1c9221f3'
      };
      var response = await http.delete(
          Uri.parse(
              'http://eiuat.seedors.com:8290/customer-app/remove-address/$id?clientid=$client_id'),
          headers: headers);
      print(
          'http://eiuat.seedors.com:8290/customer-app/remove-address/$id?clientid=$client_id');

      if (response.statusCode == 200) {
        _address.removeWhere((element) => element.id == id);

        notifyListeners();
        snackBar.successsnackbar(
            context: context, text: 'Address Deleted Successfully');
      } else {
        print('error');
        snackBar.generalSnackbar(
            context: context, text: "Couldn't delete this address");
      }
    } on HttpException catch (e) {
      print('error in delete address  --> ' + e.message.toString());
      snackBar.generalSnackbar(context: context, text: 'Something went wrong');
    }
  }

  void updateAddressOne(Addresss addIndex) {
    // ignore: unrelated_type_equality_checks
    if (addIndex != _address) {
      _address = addIndex as List<Addresss>;
      notifyListeners();
    }
  }

  void addressToBeAdd(Addresss address) {
    final newaddress = Addresss(
      id: DateTime.now().toString(),
      name: address.name,
      phoneNumber: address.phoneNumber,
      pincode: address.pincode,
      houseNumber: address.houseNumber,
      area: address.area,
      landmark: address.landmark,
      town: address.town,
      state: address.state,
      addresstype: address.addresstype,
    );
    _address.add(newaddress);
    // _address.insert(0, newaddress);
    notifyListeners();
  }

  void updateAddress(
      String id, Addresss newAddress, BuildContext context) async {
    final addressIndex = _address.indexWhere((address) => address.id == id);
    await updateAddressData(newAddress, context);

    if (addressIndex >= 0) {
      _address[addressIndex] = newAddress;
      notifyListeners();
    } else {
      await addAddressData(newAddress, context);
      // final newaddress = Address(
      //   name: newAddress.name,
      //   phoneNumber: newAddress.phoneNumber,
      //   pincode: newAddress.pincode,
      //   houseNumber: newAddress.houseNumber,
      //   area: newAddress.area,
      //   landmark: newAddress.landmark,
      //   town: newAddress.town,
      //   state: newAddress.state,
      //   addresstype: newAddress.addresstype,
      //   id: DateTime.now().toString(),
      // );
      // _address.add(newaddress);
      // // _address.insert(0, newaddress);
      // notifyListeners();
    }
  }

  // void addAddress(
  //     {required String id,
  //     required String name,
  //     required String phoneNumber,
  //     required String pincode,
  //     required String houseNumber,
  //     required String area,
  //     required String landmark,
  //     required String town,
  //     required String state,
  //     required String addresType}) {
  //   _address.putIfAbsent(
  //       id,
  //       () => Address(
  //           id: DateTime.now().toString(),
  //           name: name,
  //           phoneNumber: phoneNumber,
  //           pincode: pincode,
  //           houseNumber: houseNumber,
  //           area: area,
  //           landmark: landmark,
  //           town: town,
  //           state: state,
  //           addresstype: addresType));
  // }

  // void removeAddress(String id, BuildContext context) async {
  //   _address.removeWhere((element) => element.id == id);
  //   await deleteAddress(id, context);
  //   notifyListeners();
  // }

  Addresss findById(String id) {
    print(id + 'find by id');
    return address.firstWhere((element) => element.id == id);
  }
}
