import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/const/config.dart';
import 'package:food_app/models/profile.dart';
import 'package:food_app/provider/shareprefes_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../services/snackbar.dart';

class ProfileProvider with ChangeNotifier {
  final List<ProfileModel> _profile = [];
  List<ProfileModel> get profile {
    return [..._profile];
  }

  GlobalSnackBar globalSnackBar = GlobalSnackBar();

  // void addProfile(ProfileModel editProfile) {
  //   final newprofile = ProfileModel(
  //       name: editProfile.name,
  //       phoneNumber: editProfile.phoneNumber,
  //       dateOfBirth: editProfile.dateOfBirth,
  //       gender: editProfile.gender,
  //       id: DateTime.now().toString(),
  //       joinDate: editProfile.joinDate,
  //       email: editProfile.email);
  //   _profile.insert(0, newprofile);
  //   notifyListeners();
  // }

  void updateProfile(String id, ProfileModel editProfile) {
    final addressIndex = _profile.indexWhere((address) => address.id == id);
    if (addressIndex >= 0) {
      _profile[addressIndex] = editProfile;
      notifyListeners();
    }
  }

  ProfileModel findById(String id) {
    return profile.firstWhere((element) => element.id == id);
  }

  Future<ProfileModel> profileDataget(BuildContext context) async {
    ProfileModel parsed;
    try {
      var headers = {
        'Cookie': 'session_id=478b90980916cb4a1f65763ada7eed8774df466f'
      };
      final prefs = Provider.of<UserDetails>(context, listen: false);
      // prefs.getAllDetails();

      var response = await http.get(
          Uri.parse(
              'http://eiuat.seedors.com:8290/customer-app/userprofile?clientid=$client_id&username=${prefs.email}'),
          headers: headers);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        parsed = ProfileModel.fromJson(jsonData);
      } else {
        globalSnackBar.generalSnackbar(
            context: context, text: 'Something went wrong');
      }
    } on HttpException catch (e) {
      print('error in profile -->' + e.message.toString());
      globalSnackBar.generalSnackbar(
          context: context, text: 'Something went wrong');
    }
    return parsed;
  }
}
