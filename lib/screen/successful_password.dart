import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/const/theme.dart';

import 'LoginScreen/login_screen.dart';

class SuccessfullPasswordScreen extends StatelessWidget {
  static const routename = 'successful-password';

  const SuccessfullPasswordScreen({Key key}) : super(key: key);
  // const SuccessfullPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              const CircleAvatar(
                radius: 40,
                backgroundColor: CustomColor.orangecolor,
                child: Center(
                    child: Text(
                  'LOGO',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: CustomColor.whitecolor),
                )),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width,
                child: Column(
                  children: [
                    Text(
                      'Congratulations!',
                      style: CustomThemeData().sliderTitleText(),
                    ),
                    Text(
                      'You successfully reset your password. \n Now you are good to go',
                      textAlign: TextAlign.center,
                      style: CustomThemeData().sliderSubtitleText(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Image.asset(CustomImages.successful),
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  height: size.height * 0.07,
                  width: size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: const Text('Jump Into Log In')))
            ],
          ),
        ),
      ),
    );
  }
}
