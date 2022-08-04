import 'package:flutter/material.dart';
import 'package:food_app/models/address/address.dart';

class AddressData extends ChangeNotifier {
  Addresss pickUpLocation, dropOffLocation;
  void updatePickUpLocation(Addresss pickupAddress) {
    pickUpLocation = pickupAddress;
    // notifyListeners();
  }

  void updateDropOffLocation(Addresss dropOffAddress) {
    dropOffLocation = dropOffAddress;
    // notifyListeners();
  }
}
