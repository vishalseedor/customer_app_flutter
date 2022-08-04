import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/const/theme.dart';
import 'package:food_app/provider/auth_provider.dart';
import 'package:food_app/screen/LoginScreen/login_screen.dart';

import 'package:provider/provider.dart';

import '../services/dialogbox.dart';

class RFegisterScreen extends StatefulWidget {
  const RFegisterScreen({Key key}) : super(key: key);
  static const routename = 'register-screen';

  @override
  _RFegisterScreenState createState() => _RFegisterScreenState();
}

class _RFegisterScreenState extends State<RFegisterScreen> {
  // final GlobalServices _services = GlobalServices();
  final _formKey = GlobalKey<FormState>();
  final GlobalServices _services = GlobalServices();
  // DateTime datetime = DateTime.now();
  // String datetime1 = DateFormat("yyyy-MM-dd").format(DateTime.now());
  // var editProfile = ProfileModel(
  //   id: DateTime.now().toString(),
  //   name: '',
  //   phoneNumber: '',
  //   dateOfBirth: '',
  //   gender: '',
  //   joinDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
  //   email: '',
  // );

  var iniValue = {
    'name': '',
    'phonenumber': '',
    'gender': '',
    'dateofbirth': '',
    'join date': '',
    'email': '',
  };

  // bool _obscureText = true;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _userPhonenumber = TextEditingController();
  final TextEditingController _userEmail = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _userEmail.dispose();
  }

  void submit() async {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    // final isValid = _formKey.currentState.validate();
    // if (!isValid) {
    //   return;
    // }

    if (_firstName.text.isEmpty || _firstName.text.length < 3) {
      // ignore: void_checks
      return _services.customDialog(
          context, 'First Name', 'First Name required');
    } else if (_userPhonenumber.text.length != 10 ||
        _userPhonenumber.text.isEmpty) {
      // ignore: void_checks
      return _services.customDialog(
          context, 'PhoneNumber', 'Please enter valid Phonenumber');
    } else if (_userEmail.text.isEmpty || !regExp.hasMatch(_userEmail.text)) {
      // ignore: void_checks
      return _services.customDialog(
          context, 'Email', 'Please enter valid Email');
    } else {
      await Provider.of<AuthProvider>(context, listen: false).registerApicall(
        firstName: _firstName.text.toString(),
        lastName: _lastName.text.toString(),
        phoneNumber: _userPhonenumber.text.toString(),
        email: _userEmail.text.toString(),
        context: context,
      );
    }

    // if (editProfile.id != null) {
    //   Provider.of<ProfileProvider>(context, listen: false)
    //       .updateProfile(editProfile.id, editProfile);
    // } else if (editProfile.id == null) {
    // Provider.of<ProfileProvider>(context, listen: false)
    //     .addProfile(editProfile);
    // print(editProfile.id + 'id');
    // print(editProfile.name + 'name');
    // print(editProfile.phoneNumber + 'phon');
    // }

    // widget.alertId == 'id' ? Navigator.of(context).pop() : null;
  }

  @override
  Widget build(BuildContext context) {
    final isloading = Provider.of<AuthProvider>(context).isLoading;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
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
                        Text('Getting Started',
                            style: CustomThemeData().sliderTitleText()),
                        Text(
                          'Create an account to continue!',
                          style: CustomThemeData().sliderSubtitleText(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Name',
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
                            controller: _firstName,
                            onChanged: (value) {
                              value = _firstName.text.trim();
                            },
                            // onSaved: (value) {
                            //   editProfile = ProfileModel(
                            //       id: editProfile.id,
                            //       name: value.toString(),
                            //       phoneNumber: editProfile.phoneNumber,
                            //       dateOfBirth: editProfile.dateOfBirth,
                            //       gender: editProfile.gender,
                            //       joinDate: editProfile.joinDate,
                            //       email: editProfile.email);
                            // },
                            style: CustomThemeData().clearStyle(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: 'Seedor',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.person,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Name',
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
                            controller: _lastName,
                            onChanged: (value) {
                              value = _lastName.text.trim();
                            },
                            onSaved: (value) {
                              // editProfile = ProfileModel(
                              //     id: editProfile.id,
                              //     name: value.toString(),
                              //     phoneNumber: editProfile.phoneNumber,
                              //     dateOfBirth: editProfile.dateOfBirth,
                              //     gender: editProfile.gender,
                              //     joinDate: editProfile.joinDate,
                              //     email: editProfile.email);
                            },
                            style: CustomThemeData().clearStyle(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: 'Seedor',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.person,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone Number',
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
                            controller: _userPhonenumber,
                            onChanged: (value) {
                              value = _userPhonenumber.text.trim();
                            },
                            onSaved: (value) {
                              // editProfile = ProfileModel(
                              //     id: editProfile.id,
                              //     name: editProfile.name,
                              //     phoneNumber: value.toString(),
                              //     dateOfBirth: editProfile.dateOfBirth,
                              //     gender: editProfile.gender,
                              //     joinDate: editProfile.joinDate,
                              //     email: editProfile.email);
                            },
                            style: CustomThemeData().clearStyle(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            decoration: const InputDecoration(
                                hintText: 'Phone Number',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.call,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
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
                            controller: _userEmail,
                            onChanged: (value) {
                              value = _userEmail.text.trim();
                            },
                            onSaved: (value) {
                              // editProfile = ProfileModel(
                              //     id: editProfile.id,
                              //     name: editProfile.name,
                              //     phoneNumber: editProfile.phoneNumber,
                              //     dateOfBirth: editProfile.dateOfBirth,
                              //     gender: editProfile.gender,
                              //     joinDate: editProfile.joinDate,
                              //     email: value.toString());
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
                          ),
                        ),
                      )
                    ],
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Password',
                  //       style: CustomThemeData().sliderSubtitleText(),
                  //     ),
                  //     Container(
                  //       height: size.height * 0.07,
                  //       decoration: BoxDecoration(
                  //           color: CustomColor.grey100,
                  //           borderRadius: BorderRadius.circular(10)),
                  //       child: Theme(
                  //         data: Theme.of(context).copyWith(
                  //             colorScheme: ThemeData().colorScheme.copyWith(
                  //                   primary: CustomColor.orangecolor,
                  //                 )),
                  //         child: TextFormField(
                  //           controller: _userPassword,
                  //           onChanged: (value) {
                  //             value = _userPassword.text;
                  //           },
                  //           style: CustomThemeData().clearStyle(),
                  //           obscureText: _obscureText,
                  //           textInputAction: TextInputAction.next,
                  //           keyboardType: TextInputType.emailAddress,
                  //           decoration: InputDecoration(
                  //               hintText: 'Password',
                  //               suffixIcon: IconButton(
                  //                   onPressed: () {
                  //                     setState(() {
                  //                       _obscureText = !_obscureText;
                  //                     });
                  //                   },
                  //                   icon: Icon(_obscureText
                  //                       ? Icons.visibility_off
                  //                       : Icons.visibility)),
                  //               border: InputBorder.none,
                  //               focusedBorder: InputBorder.none,
                  //               prefixIcon: const Icon(
                  //                 Icons.lock,
                  //               )),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                        child: Text(isloading ? 'Loading' : ' Sign Up'),
                        onPressed: isloading ? null : submit),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?  ',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      InkWell(
                        onTap: () {
                          // profile.addProfile()
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        },
                        child: Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
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
}
