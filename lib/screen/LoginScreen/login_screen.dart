import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/const/theme.dart';
import 'package:food_app/provider/auth_provider.dart';
import 'package:food_app/provider/device_info.dart';

import 'package:food_app/screen/password_recovery.dart';

import 'package:food_app/screen/register_screen.dart';
import 'package:food_app/services/dialogbox.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  static const routeName = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _useremail = TextEditingController();
  final TextEditingController _userPasword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _useremail.dispose();
    _userPasword.dispose();
  }

  @override
  void initState() {
    super.initState();

    Provider.of<DeviceInformation>(context, listen: false)
        .initPlatformStatesss();
  }

  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final GlobalServices _services = GlobalServices();

  void submit() async {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }

    if (_useremail.text.isEmpty || !regExp.hasMatch(_useremail.text)) {
      // ignore: void_checks
      return _services.customDialog(
          context, 'Email', 'Please enter valid Email');
    } else if (_userPasword.text.isEmpty) {
      // ignore: void_checks
      return _services.customDialog(
          context, 'Password', 'Please enter valid Password');
    } else {
      _formKey.currentState.save();

      await Provider.of<AuthProvider>(context, listen: false).loginapiCall(
        email: _useremail.text,
        password: _userPasword.text,
        // deviceName: device.deviceName,
        // deviveId: device.deviceId,
        context: context,
      );
      print('loginapiCall');
    }

    //
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final loading = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: CustomColor.orangecolor,
                    child: Center(
                        child: Text(
                      'LOGO',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width,
                    child: Column(
                      children: [
                        Text(
                          'Let\'s Sign You In',
                          style: CustomThemeData().sliderTitleText(),
                        ),
                        Text(
                          'Welcome back, you\'ve been missed!',
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
                        'Email',
                        style: CustomThemeData().sliderSubtitleText(),
                      ),
                      useremail(),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: CustomThemeData().sliderSubtitleText(),
                      ),
                      userpassword(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(PasswordRecoveryScreen.routeName);
                            },
                            child: Text(
                              'Forget Password?',
                              style: CustomThemeData().sliderSubtitleText(),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      child: Text(loading.isLoading ? 'Loading' : ' Sign In'),
                      onPressed: () {
                        submit();
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?  ',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RFegisterScreen.routename);
                        },
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              CustomImages.facebook,
                              width: 25,
                              height: 25,
                            ),
                          ),
                          const Text('Continue With Facebook')
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(CustomColor.grey100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              CustomImages.google,
                              width: 25,
                              height: 25,
                            ),
                          ),
                          const Text(
                            'Continue With Google',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget useremail() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      decoration: BoxDecoration(
          color: CustomColor.grey100, borderRadius: BorderRadius.circular(10)),
      child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: CustomColor.orangecolor,
                )),
        child: TextFormField(
          controller: _useremail,
          onChanged: (value) {
            value = _useremail.text.trim();
          },
          style: CustomThemeData().clearStyle(),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              hintText: 'seedorsoft@gmail.com',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: Icon(
                Icons.email_outlined,
              )),
          // validator: validateEmail,
          // onSaved: (val) {
          //   val = _useremail.text;
          // },
        ),
      ),
    );
  }

  Widget userpassword() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      decoration: BoxDecoration(
          color: CustomColor.grey100, borderRadius: BorderRadius.circular(10)),
      child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: CustomColor.orangecolor,
                )),
        child: TextFormField(
          controller: _userPasword,
          onChanged: (value) {
            value = _userPasword.text.trim();
          },
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
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: const Icon(
                Icons.lock,
              )),
          // validator: validatePassword,
          // onSaved: (val) {
          //   val = _userPasword.text;
          // },
        ),
      ),
    );
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return _services.customDialog(
          context, 'Email', 'Please Enter correct Email');
    } else if (!regExp.hasMatch(value)) {
      return _services.customDialog(
          context, 'Email', 'Please Enter valid Email');
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return _services.customDialog(
          context, 'Password', 'Password must required');
    } else if (value.length < 4) {
      return _services.customDialog(
          context, 'Password', 'Password must be at least 4 characters');
    }
    return null;
  }
}
