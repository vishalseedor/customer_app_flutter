import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/provider/shareprefes_provider.dart';
import 'package:food_app/screen/bottom_app_screen.dart';

import 'package:food_app/screen/slider_screen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);
  static const routeName = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).boolDataTrue();
    final loginData = Provider.of<UserDetails>(context, listen: false);
    loginData.getAllDetails().then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        print(loginData.email + ' email value');
        loginData.email == 'Not yet updated'
            ? Navigator.of(context).pushReplacementNamed(SliderSCreen.routeName)
            : Navigator.of(context).pushReplacementNamed(
                BottomAppScreen.routeName,
              );
      });
    });
  }

  bool value;
  void apiCallBack() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('page', true);
    value = prefs.getBool('page');

    print(value.toString() + 'helo helo helo');
    print('splash screen start');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.13,
                  width: size.width * 0.25,
                  decoration: const BoxDecoration(
                      color: CustomColor.blackcolor,
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: AssetImage(CustomImages.seedorLogo),
                          fit: BoxFit.fill)),
                  // child: Image.asset(
                  //   CustomImages.seedorLogo,
                  //   fit: BoxFit.fill,
                  // ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: size.height * 0.1,
            child: const Text('FOOD APP',
                style: TextStyle(
                    color: CustomColor.blackcolor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
