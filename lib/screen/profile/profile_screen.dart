import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/image_base64.dart';
import 'package:food_app/models/profile.dart';
import 'package:food_app/provider/profile_provider.dart';
import 'package:food_app/provider/shareprefes_provider.dart';

import 'package:provider/provider.dart';

import '../../services/statefullwraper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    @override
        // final profile = Provider.of<ProfileProvider>(context).profile;
        // final addressData = Provider.of<AddressProvider>(context).address;

        // String address = addressData.first.name +
        //     ',' +
        //     addressData.first.addresstype +
        //     ',' +
        //     addressData.first.houseNumber +
        //     ',' +
        //     addressData.first.area +
        //     ',' +
        //     addressData.first.pincode +
        //     ',' +
        //     addressData.first.phoneNumber;
        Size size = MediaQuery.of(context).size;
    final userDetails = Provider.of<UserDetails>(context);
    final base64 = userDetails.image == '' ? customBase64 : userDetails.image;
    var image = base64Decode(base64);
    // return profile.isEmpty
    //     ? const Center(
    //         child: Text('Profile Not yet Update'),
    //       )
    //     :
    return StatefulWrapper(
      onInit: () {
        userDetails.getAllDetails();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            height: size.height,
            child: FutureBuilder<ProfileModel>(
                future: Provider.of<ProfileProvider>(context, listen: false)
                    .profileDataget(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 160),
                        child: CupertinoActivityIndicator(
                          color: CustomColor.orangecolor,
                          animating: true,
                          radius: 20,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: Text('Something went wrong'),
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Center(
                        child: Text('No data avalible'),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(children: [
                        CircleAvatar(
                          backgroundColor: CustomColor.blackcolor,
                          backgroundImage: MemoryImage(image),
                          radius: 80,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        profileText(
                            context: context,
                            title: 'Email :',
                            subtitle: snapshot.data.email),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        profileText(
                            context: context,
                            title: 'User Name :',
                            subtitle: snapshot.data.name),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        profileText(
                            context: context,
                            title: 'Seedor Name :',
                            subtitle: userDetails.seedorName),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        profileText(
                            context: context,
                            title: 'Phone Number :',
                            subtitle: snapshot.data.mobile),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        profileText(
                            context: context,
                            title: 'website :',
                            subtitle: userDetails.website),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Address :',
                                style: Theme.of(context).textTheme.headline4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.04,
                            ),
                            snapshot.data.city == "" &&
                                    snapshot.data.street == "" &&
                                    snapshot.data.streetTwo == ""
                                ? Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Not yet Updated',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data.street,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          snapshot.data.streetTwo,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          snapshot.data.city,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // Text(
                                        //   addressData.first.town + ',',
                                        //   style:
                                        //       Theme.of(context).textTheme.headline4,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                        // addressData.first.landmark.isEmpty
                                        //     ? Container()
                                        //     : Text(
                                        //         addressData.first.landmark + ',',
                                        //         style: Theme.of(context)
                                        //             .textTheme
                                        //             .headline4,
                                        //         overflow: TextOverflow.ellipsis,
                                        //       ),
                                        // Text(
                                        //   addressData.first.state + ',',
                                        //   style:
                                        //       Theme.of(context).textTheme.headline4,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                        // Text(
                                        //   addressData.first.pincode + ',',
                                        //   style:
                                        //       Theme.of(context).textTheme.headline4,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                        // Text(
                                        //   addressData.first.phoneNumber + ',',
                                        //   style:
                                        //       Theme.of(context).textTheme.headline4,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                        // InkWell(
                                        //     onTap: () {
                                        //       Navigator.of(context).pushNamed(
                                        //           AddAddressScreen.routeName,
                                        //           arguments: addressData.first.id);
                                        //     },
                                        //     child: Text(
                                        //       'Edit',
                                        //       style: Theme.of(context)
                                        //           .textTheme
                                        //           .subtitle1,
                                        //     ))
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        // SizedBox(
                        //   width: size.width,
                        //   height: size.height * 0.065,
                        //   child: ElevatedButton(
                        //     child: const Text('Edit'),
                        //     onPressed: () {
                        //       Navigator.of(context).pushNamed(
                        //           EditProfileScreen.routeName,
                        //           arguments: profile.first.id);
                        //     },
                        //   ),
                        // ),

                        // Text(profile.last.dateOfBirth),
                        // Text(profile.last.gender)
                      ]),
                    );
                  }
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget profileText({String title, String subtitle, BuildContext context}) {
    // Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.headline4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
