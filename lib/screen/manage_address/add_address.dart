import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/theme.dart';
import 'package:food_app/models/address/address.dart';

import 'package:food_app/provider/address/address_provider.dart';
import 'package:food_app/services/dialogbox.dart';
import 'package:food_app/services/location.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class AddAddressScreen extends StatefulWidget {
  static const routeName = 'Add-Address';
  final String alertId;
  const AddAddressScreen({Key key, this.alertId}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _housenumberController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _addresstypeController = TextEditingController();

  String selectedValue = "private";
  var isInit = true;

  Position position;
  List<Placemark> placemark;
  String addresId;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phonenumber.dispose();
    _pincodeController.dispose();
    _housenumberController.dispose();
    _areaController.dispose();
    _landmarkController.dispose();
    _townController.dispose();
    _stateController.dispose();
    _addresstypeController.dispose();
  }

  var editAddress = Addresss(
      id: '',
      name: '',
      phoneNumber: '',
      pincode: '',
      houseNumber: '',
      area: '',
      landmark: '',
      town: '',
      state: '',
      addresstype: '');
  var iniValue = {
    'name': '',
    'phonenumber': '',
    'pincode': '',
    'housenumber': '',
    'area': '',
    'landmark': '',
    'town': '',
    'state': '',
    'addresstype': '',
  };

  final GlobalServices _services = GlobalServices();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<CurrentLocation>(context, listen: false).determinePosition();
    // print(widget.alertId);
  }

  @override
  void didChangeDependencies() {
    // final addressId = ModalRoute.of(context)!.settings.arguments as String;
    // print('one' + addressId);

    if (isInit) {
      addresId = ModalRoute.of(context).settings.arguments as String;
      print(addresId.toString() + 'sushalt');
      if (addresId != null) {
        editAddress = Provider.of<AddressProvider>(context, listen: false)
            .findById(addresId);
        // print('sush' + addressId);
        iniValue = {
          'name': '',
          'phonenumber': '',
          'pincode': '',
          'housenumber': '',
          'area': '',
          'landmark': '',
          'town': '',
          'state': '',
          'addresstype': '',
        };
        _nameController.text = editAddress.name;
        _phonenumber.text = editAddress.phoneNumber;
        _pincodeController.text = editAddress.pincode;
        _housenumberController.text = editAddress.houseNumber;
        _areaController.text = editAddress.area;
        _landmarkController.text = editAddress.landmark;
        _townController.text = editAddress.town;
        _stateController.text = editAddress.state ?? 'Tamilnadu';
        _addresstypeController.text = selectedValue;
      }
    }
    isInit = false;

    super.didChangeDependencies();
  }

  void submit() {
    print(addresId.toString() + 'addressId from page');
    print(editAddress.id.toString() + 'addressid from edit');
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    if (addresId == editAddress.id) {
      print('edit address add');

      Provider.of<AddressProvider>(context, listen: false)
          .updateAddressData(editAddress, context)
          .then((value) {
        Provider.of<AddressProvider>(context, listen: false)
            .getAddressData(context)
            .then((value) {
          Navigator.of(context).pop();
        });
      });
    } else if (addresId == null) {
      print('new address add');
      Provider.of<AddressProvider>(context, listen: false)
          .addAddressData(editAddress, context)
          .then((value) {
        Provider.of<AddressProvider>(context, listen: false)
            .getAddressData(context)
            .then((value) {
          Navigator.of(context).pop();
        });
      });
    }

    widget.alertId == 'id' ? Navigator.of(context).pop() : null;
  }

  Future<void> getCurrentLocation() async {
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = newPosition;

    placemark =
        (await placemarkFromCoordinates(position.latitude, position.longitude));
    Placemark pMark = placemark[0];

    _pincodeController.text = pMark.postalCode;
    _areaController.text = pMark.thoroughfare;
    _townController.text = pMark.locality;
    _stateController.text = pMark.administrativeArea;
    _housenumberController.text = pMark.name;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final addressId = ModalRoute.of(context)!.settings.arguments as String;
    // print('add' + addressId);
    Size size = MediaQuery.of(context).size;

    // final addAddress = Provider.of<AddressProvider>(context);
    // print('sush' + editAddress.id + 'sushalt');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: CustomColor.blackcolor,
            )),
        title: Text(editAddress.id == '' ? 'Add Address' : 'Edit Address'),
        // actions: [Text(finalAddress)],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height * 0.065,
                  child: ElevatedButton(
                    child: const Text('Use My Current Location'),
                    onPressed: () {
                      CurrentLocation().determinePosition();
                      getCurrentLocation();
                    },
                  ),
                ),
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
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        child: Column(
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
                                      colorScheme: ThemeData()
                                          .colorScheme
                                          .copyWith(
                                            primary: CustomColor.orangecolor,
                                          )),
                                  child: phoneNumber()),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title('Pincode'),
                            Container(
                              height: size.height * 0.065,
                              decoration: BoxDecoration(
                                  color: CustomColor.grey100,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Theme(
                                  data: Theme.of(context).copyWith(
                                      colorScheme: ThemeData()
                                          .colorScheme
                                          .copyWith(
                                            primary: CustomColor.orangecolor,
                                          )),
                                  child: pincode()),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Flat,House no,Building,Company'),
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
                          child: houseNumber()),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Area,Street,Sector,Village'),
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
                          child: arealocation()),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Landmark ( Optional )'),
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
                          child: landmark()),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Town / City'),
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
                          child: townCity()),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('State'),
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
                          child: state()),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('Select Address Type'),
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
                          child: addressType(context)),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.065,
                  child: ElevatedButton(
                    child: Text(
                        editAddress.id == '' ? 'Add Address' : 'Edit Address'),
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
      controller: _nameController,
      // initialValue: iniValue['name'],
      style: CustomThemeData().clearStyle(),
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
        editAddress = Addresss(
            id: editAddress.id,
            name: value.toString(),
            phoneNumber: editAddress.phoneNumber,
            pincode: editAddress.pincode,
            houseNumber: editAddress.houseNumber,
            area: editAddress.area,
            landmark: editAddress.landmark,
            town: editAddress.town,
            state: editAddress.state,
            addresstype: editAddress.addresstype);
      },
      // onChanged: (val) {
      //   val = _nameController.text.toString();
      // },
    );
  }

  Widget phoneNumber() {
    return TextFormField(
      controller: _phonenumber,
      // initialValue: iniValue['phonenumber'],
      style: CustomThemeData().clearStyle(),
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
            Icons.person_outline,
          )),
      validator: (value) {
        if (value.isEmpty) {
          return _services.customDialog(
              context, 'Phone Number', 'Please add your Phone Number');
        } else if (value.length != 10) {
          return _services.customDialog(context, 'Phone Number',
              'Please enter your correct mobile number');
        }
        return null;
      },
      onSaved: (value) {
        editAddress = Addresss(
            id: editAddress.id,
            name: editAddress.name,
            phoneNumber: value.toString(),
            pincode: editAddress.pincode,
            houseNumber: editAddress.houseNumber,
            area: editAddress.area,
            landmark: editAddress.landmark,
            town: editAddress.town,
            state: editAddress.state,
            addresstype: editAddress.addresstype);
      },
      // onChanged: (val) {
      //   val = _phonenumber.text;
      // },
    );
  }

  Widget pincode() {
    return TextFormField(
      controller: _pincodeController,
      // initialValue: iniValue['pincode'],
      style: CustomThemeData().clearStyle(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      decoration: const InputDecoration(
          hintText: 'Pincode',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.location_on_outlined,
          )),
      validator: (value) {
        if (value.isEmpty) {
          return _services.customDialog(
              context, 'Pincode', 'Please add your Pincode');
        } else if (value.length != 6) {
          return _services.customDialog(
              context, 'Pincode', 'Please enter your correct Pincode');
        }
        return null;
      },
      onSaved: (value) {
        editAddress = Addresss(
            id: editAddress.id,
            name: editAddress.name,
            phoneNumber: editAddress.phoneNumber,
            pincode: value.toString(),
            houseNumber: editAddress.houseNumber,
            area: editAddress.area,
            landmark: editAddress.landmark,
            town: editAddress.town,
            state: editAddress.state,
            addresstype: editAddress.addresstype);
      },
      // onChanged: (val) {
      //   val = _pincodeController.text;
      // },
    );
  }

  Widget houseNumber() {
    return TextFormField(
      // initialValue: iniValue['housenumber'],
      controller: _housenumberController,
      style: CustomThemeData().clearStyle(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          hintText: 'Flat,House no,Building,Company',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.home_outlined,
          )),
      validator: (value) {
        if (value.isEmpty) {
          return _services.customDialog(context, 'House/ Companyname',
              'Please enter your House or Companyname');
        }
        return null;
      },
      onSaved: (value) {
        editAddress = Addresss(
            id: editAddress.id,
            name: editAddress.name,
            phoneNumber: editAddress.phoneNumber,
            pincode: editAddress.pincode,
            houseNumber: value.toString(),
            area: editAddress.area,
            landmark: editAddress.landmark,
            town: editAddress.town,
            state: editAddress.state,
            addresstype: editAddress.addresstype);
      },
      // onChanged: (val) {
      //   val = _housenumberController.text.toString();
      // },
    );
  }

  Widget arealocation() {
    return TextFormField(
      // initialValue: iniValue['area'],
      controller: _areaController,
      style: CustomThemeData().clearStyle(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          hintText: 'Area,Street,Sector,Village',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.location_city,
          )),
      validator: (value) {
        if (value.isEmpty) {
          return _services.customDialog(
              context, 'Area,Street', 'Please enter your Area or Street');
        }
        return null;
      },
      onSaved: (value) {
        editAddress = Addresss(
            id: editAddress.id,
            name: editAddress.name,
            phoneNumber: editAddress.phoneNumber,
            pincode: editAddress.pincode,
            houseNumber: editAddress.houseNumber,
            area: value.toString(),
            landmark: editAddress.landmark,
            town: editAddress.town,
            state: editAddress.state,
            addresstype: editAddress.addresstype);
      },
      // onChanged: (val) {
      //   val = _areaController.text.toString();
      // },
    );
  }

  Widget landmark() {
    return TextFormField(
      // initialValue: iniValue['landmark'],
      controller: _landmarkController,
      style: CustomThemeData().clearStyle(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          hintText: 'e.g Near apollo hospital',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.location_city,
          )),
      onSaved: (value) {
        editAddress = Addresss(
            id: editAddress.id,
            name: editAddress.name,
            phoneNumber: editAddress.phoneNumber,
            pincode: editAddress.pincode,
            houseNumber: editAddress.houseNumber,
            area: editAddress.area,
            landmark: value.toString(),
            town: editAddress.town,
            state: editAddress.state,
            addresstype: editAddress.addresstype);
      },
      // onChanged: (val) {
      //   val = _landmarkController.text.toString();
      // },
    );
  }

  Widget townCity() {
    return TextFormField(
      controller: _townController,
      // initialValue: iniValue['town'],
      style: CustomThemeData().clearStyle(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          hintText: 'Town / City',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.location_city,
          )),
      // onChanged: (val) {
      //   val = _townController.text.toString();
      // },
      validator: (value) {
        if (value.isEmpty) {
          return _services.customDialog(
              context, 'Town or City', 'Please enter your Town or City');
        }
        return null;
      },
      onSaved: (value) {
        editAddress = Addresss(
            id: editAddress.id,
            name: editAddress.name,
            phoneNumber: editAddress.phoneNumber,
            pincode: editAddress.pincode,
            houseNumber: editAddress.houseNumber,
            area: editAddress.area,
            landmark: editAddress.landmark,
            town: value.toString(),
            state: editAddress.state,
            addresstype: editAddress.addresstype);
      },
    );
  }

  Widget state() {
    return TextFormField(
      // initialValue: iniValue['state'],
      controller: _stateController,
      style: CustomThemeData().clearStyle(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          hintText: 'State',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.location_city,
          )),
      validator: (value) {
        if (value.isEmpty) {
          return _services.customDialog(
              context, 'State', 'Please Enter your State');
        }
        return null;
      },
      onSaved: (value) {
        editAddress = Addresss(
            id: editAddress.id,
            name: editAddress.name,
            phoneNumber: editAddress.phoneNumber,
            pincode: editAddress.pincode,
            houseNumber: editAddress.houseNumber,
            area: editAddress.area,
            landmark: editAddress.landmark,
            town: editAddress.town,
            state: value.toString(),
            addresstype: editAddress.addresstype);
      },
      // onChanged: (val) {
      //   val = _stateController.text.toString();
      // },
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        child: Text(
          "private",
          style: CustomThemeData().clearStyle(),
        ),
        value: "private",
      ),
      DropdownMenuItem(
        child: Text(
          "delivery",
          style: CustomThemeData().clearStyle(),
        ),
        value: "delivery",
      ),
      DropdownMenuItem(
        child: Text(
          "invoice",
          style: CustomThemeData().clearStyle(),
        ),
        value: "invoice",
      ),
      DropdownMenuItem(
          child: Text(
            "contact",
            style: CustomThemeData().clearStyle(),
          ),
          value: "contact"),
      DropdownMenuItem(
          child: Text(
            "other",
            style: CustomThemeData().clearStyle(),
          ),
          value: "other"),
    ];
    return menuItems;
  }

  Widget addressType(BuildContext context) {
    return DropdownButtonFormField(
        style: CustomThemeData().clearStyle(),
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.location_city_outlined),
            border: InputBorder.none,
            focusedBorder: InputBorder.none),
        dropdownColor: CustomColor.grey100,
        value: editAddress.name == '' ? selectedValue : editAddress.addresstype,
        onChanged: (String newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
        onSaved: (value) {
          editAddress = Addresss(
              id: editAddress.id,
              name: editAddress.name,
              phoneNumber: editAddress.phoneNumber,
              pincode: editAddress.pincode,
              houseNumber: editAddress.houseNumber,
              area: editAddress.area,
              landmark: editAddress.landmark,
              town: editAddress.town,
              state: editAddress.state,
              addresstype: value.toString());
        },
        items: dropdownItems);
  }
}
