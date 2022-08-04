import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/theme.dart';

import 'package:food_app/provider/profile_provider.dart';
import 'package:food_app/services/dialogbox.dart';

import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);
  static const routeName = 'edit-profile-screen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var isInit = true;
  // var editProfile = ProfileModel(
  //   name: '',
  //   phoneNumber: '',
  //   dateOfBirth: '',
  //   gender: '',
  //   id: '',
  //   joinDate: '',
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

  final TextEditingController _personName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _dateofbirth = TextEditingController();
  final TextEditingController _joinDate = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final GlobalServices _services = GlobalServices();
  final _formKey = GlobalKey<FormState>();

  // final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    _personName.dispose();
    _phoneNumber.dispose();
    _dateofbirth.dispose();
    _email.dispose();
    super.dispose();
  }

  String selectedValue = 'Male';

  @override
  void initState() {
    // final data = Provider.of<ProfileProvider>(context, listen: false).profile;
    super.initState();
    // _personName.text = data.first.name;
    // _email.text = data.first.email;
    // _phoneNumber.text = data.first.phoneNumber;
    // _dateofbirth.text = data.first.dateOfBirth;
    // _joinDate.text = data.first.joinDate;
  }

  @override
  void didChangeDependencies() {
    // final profileId = ModalRoute.of(context).settings.arguments as String;
    // print('one' + addressId);

    // final data = Provider.of<ProfileProvider>(context, listen: false).profile;

    // selectedValue = editProfile.id == '' ? data.first.gender : selectedValue;

    // print(profileIdval + 'val');
    if (isInit) {
      final profileId = ModalRoute.of(context).settings.arguments as String;

      if (profileId != '') {
        // print('sushalt');
        Provider.of<ProfileProvider>(context, listen: false)
            .findById(profileId);
        // print('sush' + addressId);
        iniValue = {
          'name': '',
          'phonenumber': '',
          'gender': '',
          'dateofbirth': '',
          'join date': '',
          'email': '',
        };
        // _personName.text = data.first.name;
        // _email.text = data.first.email;
        // _phoneNumber.text = data.first.phoneNumber;
        // _dateofbirth.text = data.first.dateOfBirth;
        // // selectedValue = data.first.gender;
        // _joinDate.text = data.first.joinDate;
      }
    }
    isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final val = Provider.of<ProfileProvider>(context).profile;
    void submit() {
      // final isValid = _formKey.currentState.validate();
      // if (!isValid) {
      //   return;
      // }
      // _formKey.currentState.save();

      // if (val.first.id != '') {
      //   // print('sushalt upda');
      //   // print(editProfile.id);
      //   Provider.of<ProfileProvider>(context, listen: false)
      //       .updateProfile(val.first.id, editProfile);
      // } else if (editProfile.id == '') {
      //   // print('sushalt upda');
      //   // print(editProfile.id);
      //   Provider.of<ProfileProvider>(context, listen: false)
      //       .updateProfile(editProfile.id, editProfile);
      // }

      // Navigator.of(context).pop();
      // // widget.alertId == 'id' ? Navigator.of(context).pop() : null;
    }

    Size size = MediaQuery.of(context).size;
    // String birthDateInString = '';
    // DateTime birthDate;
    // final data = Provider.of<ProfileProvider>(context).profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Full Name'),
                    Container(
                      height: size.height * 0.065,
                      decoration: BoxDecoration(
                          color: CustomColor.grey100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: CustomColor.orangecolor,
                                  )),
                          child: personName()),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Phone Number'),
                    Container(
                      height: size.height * 0.065,
                      decoration: BoxDecoration(
                          color: CustomColor.grey100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: CustomColor.orangecolor,
                                  )),
                          child: phoneNumber()),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Date of Birth'),
                    Container(
                      height: size.height * 0.065,
                      decoration: BoxDecoration(
                          color: CustomColor.grey100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: CustomColor.orangecolor,
                                  )),
                          child: dateOfBith()),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Join Date'),
                    Container(
                      height: size.height * 0.065,
                      decoration: BoxDecoration(
                          color: CustomColor.grey100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: CustomColor.orangecolor,
                                  )),
                          child: joinDate()),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Email'),
                    Container(
                      height: size.height * 0.065,
                      decoration: BoxDecoration(
                          color: CustomColor.grey100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: CustomColor.orangecolor,
                                  )),
                          child: userEmail()),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.065,
                  child: ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      submit();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget title(String text) {
    return Text(
      text,
      style: const TextStyle(color: CustomColor.blackcolor, fontSize: 13),
    );
  }

  Widget personName() {
    return TextFormField(
      controller: _personName,
      // initialValue: iniValue['name'],
      style: CustomThemeData().sliderSubtitleText(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          hintText: 'Full Name',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.person_outline,
          )),
      validator: (value) {
        if (value.isEmpty) {
          return _services.customDialog(
              context, 'Full Name', 'Please add your Name');
        }
        return null;
      },
      onSaved: (value) {
        // editProfile = ProfileModel(
        //   id: editProfile.id,
        //   name: value.toString(),
        //   phoneNumber: editProfile.phoneNumber,
        //   dateOfBirth: editProfile.dateOfBirth,
        //   email: editProfile.email,
        //   gender: editProfile.gender,
        //   joinDate: editProfile.joinDate,
        // );
      },
    );
  }

  Widget phoneNumber() {
    return TextFormField(
        controller: _phoneNumber,
        // initialValue: iniValue['name'],
        style: CustomThemeData().sliderSubtitleText(),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        decoration: const InputDecoration(
            hintText: 'Phone Number',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.call,
            )),
        validator: (value) {
          if (value.isEmpty) {
            return _services.customDialog(
                context, 'Phone Number', 'Please add your Mobile Number');
          }
          return null;
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
        });
  }

  Widget dateOfBith() {
    return TextFormField(
        controller: _dateofbirth,
        // initialValue: iniValue['name'],
        style: CustomThemeData().sliderSubtitleText(),
        // textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        onTap: () async {
          var date = await showDatePicker(
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeData().copyWith(
                    colorScheme: const ColorScheme.light(
                        primary: CustomColor.orangecolor,
                        background: CustomColor.orangecolor),
                    //Head background

                    dialogBackgroundColor: Colors.white, //Background color
                  ),
                  child: child,
                );
              },
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));
          _dateofbirth.text = date.toString().substring(0, 10);
        },
        decoration: const InputDecoration(
            hintText: 'Date of Birth',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.date_range,
            )),
        validator: (value) {
          if (value.isEmpty) {
            return _services.customDialog(
                context, 'Date of Birth', 'Please add your Date of Birth');
          }
          return null;
        },
        onSaved: (value) {
          // editProfile = ProfileModel(
          //     id: editProfile.id,
          //     name: editProfile.name,
          //     phoneNumber: editProfile.phoneNumber,
          //     dateOfBirth: value.toString(),
          //     gender: editProfile.gender,
          //     joinDate: editProfile.joinDate,
          //     email: editProfile.email);
        });
  }

  Widget joinDate() {
    return TextFormField(
        readOnly: true,
        controller: _joinDate,
        // initialValue: iniValue['name'],
        style: CustomThemeData().sliderSubtitleText(),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            hintText: 'Join Date',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.date_range,
            )),
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return _services.customDialog(
        //         context, 'Phone Number', 'Please add your Mobile Number');
        //   }
        //   return null;
        // },
        onSaved: (value) {
          // editProfile = ProfileModel(
          //     id: editProfile.id,
          //     name: editProfile.name,
          //     phoneNumber: editProfile.phoneNumber,
          //     dateOfBirth: editProfile.dateOfBirth,
          //     gender: editProfile.gender,
          //     joinDate: value.toString(),
          //     email: editProfile.email);
        });
  }

  Widget userEmail() {
    return TextFormField(
        readOnly: true,
        controller: _email,
        // initialValue: iniValue['name'],
        style: CustomThemeData().sliderSubtitleText(),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            hintText: 'Email',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.email_outlined,
            )),
        validator: (value) {
          if (value.isEmpty) {
            return _services.customDialog(
                context, 'Email', 'Please add your Email');
          }
          return null;
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
        });
  }
}
