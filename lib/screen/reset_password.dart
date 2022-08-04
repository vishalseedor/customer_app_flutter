import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/theme.dart';
import 'package:food_app/screen/successful_password.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key key}) : super(key: key);
  static const routename = 'reset-password';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            const CircleAvatar(
              radius: 40,
              backgroundColor: CustomColor.orangecolor,
              child: Center(child: Text('LOGO')),
            ),
            Container(
              alignment: Alignment.center,
              width: size.width,
              child: Column(
                children: [
                  Text(
                    'Reset your password',
                    style: CustomThemeData().sliderTitleText(),
                  ),
                  Text(
                    'At least 7 characters, with uppercase and \n lowercase letters',
                    textAlign: TextAlign.center,
                    style: CustomThemeData().sliderSubtitleText(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Password',
                  style: CustomThemeData().sliderSubtitleText(),
                ),
                Container(
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                      color: CustomColor.grey100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: ThemeData().colorScheme.copyWith(
                              primary: CustomColor.orangecolor,
                            )),
                    child: TextFormField(
                      style: CustomThemeData().clearStyle(),
                      obscureText: _obscureText,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.lock,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirm Password',
                  style: CustomThemeData().sliderSubtitleText(),
                ),
                Container(
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                      color: CustomColor.grey100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: ThemeData().colorScheme.copyWith(
                              primary: CustomColor.orangecolor,
                            )),
                    child: TextFormField(
                      style: CustomThemeData().clearStyle(),
                      obscureText: _obscureText,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.lock,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.07,
              child: ElevatedButton(
                child: const Text('Reset password'),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(SuccessfullPasswordScreen.routename);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
