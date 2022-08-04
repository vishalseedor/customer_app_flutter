import 'package:flutter/cupertino.dart';

class Addresss with ChangeNotifier {
  final String id;
  final String name;
  final String phoneNumber;
  final String pincode;
  final String houseNumber;
  final String area;
  final String landmark;
  final String town;
  final String state;
  final String addresstype;
  double lat;
  double lng;

  Addresss({
    this.id,
    this.name,
    this.phoneNumber,
    this.pincode,
    this.houseNumber,
    this.area,
    this.landmark,
    this.town,
    this.state,
    this.addresstype,
    this.lat,
    this.lng,
  });
}
