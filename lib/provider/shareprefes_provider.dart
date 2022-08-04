import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_app/const/image_base64.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails with ChangeNotifier {
  String _email = '';
  String _userName = '';
  String _joinDate = '';
  String _dateOfBirth = '';
  String _phoneNUmber = '';
  String _streetOne = '';
  String _streetTwo = '';
  String _website = '';
  String _seedorName = '';
  String _city = '';
  String _image = '';
  String _id = '';
  String _patnerId = '';
  Uint8List _imageUrl;

  String get email {
    if (_email == '') {
      _email = 'Not yet Updated';
      return _email;
    } else {
      return _email;
    }
  }

  String get id {
    if (_id == '') {
      _id = 'Not yet Updated';
      return _id;
    } else {
      return _id;
    }
  }

  String get userName {
    if (_userName == '') {
      _userName = 'Not yet Updated';
      return _userName;
    } else {
      return _userName;
    }
  }

  String get joinDate {
    if (_joinDate == '') {
      _joinDate = 'Not yet Updated';
      return _joinDate;
    } else {
      return _joinDate;
    }
  }

  String get dateOfBirth {
    if (_dateOfBirth == '') {
      _dateOfBirth = 'Not yet Updated';
      return _dateOfBirth;
    } else {
      return _dateOfBirth;
    }
  }

  String get phoneNumber {
    if (_phoneNUmber == '') {
      _phoneNUmber = 'Not yet Updated';
      return _phoneNUmber;
    } else {
      return _phoneNUmber;
    }
  }

  String get streetOne {
    if (_streetOne == '') {
      _streetOne = 'Not yet Updated';
      return _streetOne;
    } else {
      return _streetOne;
    }
  }

  String get streetTwo {
    if (_streetTwo == '') {
      _streetTwo = 'Not yet Updated';
      return _streetTwo;
    } else {
      return _streetTwo;
    }
  }

  String get website {
    if (_website == '') {
      _website = 'Not yet Updated';
      return _website;
    } else {
      return _website;
    }
  }

  String get seedorName {
    if (_seedorName == '') {
      _seedorName = 'Not yet Updated';
      return _seedorName;
    } else {
      return _seedorName;
    }
  }

  Uint8List get imageUrl {
    if (_image == '') {
      _imageUrl = base64Decode(customBase64);
      return _imageUrl;
    } else {
      _imageUrl = base64Decode(_image);
      return _imageUrl;
    }
  }

  String get city {
    if (_city == '') {
      _city = 'Not yet Updated';
      return _city;
    } else {
      return _city;
    }
  }

  String get image {
    if (_image == '') {
      _image = customBase64;
      return _image;
    } else {
      return _image;
    }
  }

  String get patnerId {
    if (_patnerId == '') {
      _patnerId = 'Not yet Updated';
      return _patnerId;
    } else {
      return _patnerId;
    }
  }

  Future<void> getAllDetails() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? 'Not yet updated';
    _userName = prefs.getString('name') ?? 'Not yet updated';
    _joinDate = prefs.getString('start_date') ?? 'Not yet updated';
    _dateOfBirth = prefs.getString('dateodbirth') ?? 'Not yet updated';
    _phoneNUmber = prefs.getString('mobile') ?? 'Not yet updated';
    _streetOne = prefs.getString('street');
    _streetTwo = prefs.getString('street2');
    _website = prefs.getString('website') ?? 'Not yet updated';
    _seedorName = prefs.getString('seedor_name') ?? 'Not yet updated';
    _city = prefs.getString('city');
    _patnerId = prefs.getString('partner_id') ?? 'Not yet updated';
    _image = prefs.getString('image') ?? customBase64;
    _id = prefs
        .getString(
          'id',
        )
        .toString();

    notifyListeners();
  }
}
