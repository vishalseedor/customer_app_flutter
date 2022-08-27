import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/const/theme.dart';
import 'package:food_app/provider/bottom_navigationbar_provider.dart';
import 'package:food_app/provider/shareprefes_provider.dart';
import 'package:food_app/screen/LoginScreen/login_screen.dart';

import 'package:food_app/screen/manage_address/add_address.dart';
import 'package:food_app/screen/manage_address/my_address.dart';
import 'package:food_app/screen/order/order_screen.dart';
import 'package:food_app/screen/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  final VoidCallback closeDrawer;

  const DrawerScreen({Key key, @required this.closeDrawer}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserDetails>(context, listen: false).getAllDetails();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = Provider.of<UserDetails>(context);

    Widget drawerIcon(String title, IconData icon, Function onTap) {
      return ListTile(
        onTap: () {
          onTap();
        },
        leading: Icon(
          icon,
          color: CustomColor.white200,
        ),
        title: Text(
          title,
          style: CustomThemeData().drawerStyle(),
        ),
      );
    }

    final navigation = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      backgroundColor: CustomColor.orangecolor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: widget.closeDrawer,
                  child: Image.asset(
                    CustomImages.cancelimage,
                    width: 20,
                    height: 20,
                  )),
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                width: size.width * 0.6,
                height: size.height * 0.1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: MemoryImage(data.imageUrl),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              data.userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: CustomThemeData().drawerStyle(),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const ProfileScreen()));
                              },
                              child: AutoSizeText(
                                data.email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CustomThemeData().drawerStyle(),
                              ),
                            ),
                            // Text(
                            //   'View Profile',
                            //   style: CustomThemeData().drawerStyle(),
                            // )
                          ],
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              drawerIcon('Home', Icons.home_outlined, widget.closeDrawer),
              drawerIcon('My Cart', Icons.shopping_cart_outlined, () {
                navigation.currentIndex = 2;
              }),
              drawerIcon('My Favourite', Icons.favorite_border_outlined, () {
                navigation.currentIndex = 1;
              }),
              drawerIcon('Add Address', Icons.add_location, () {
                Navigator.of(context).pushNamed(AddAddressScreen.routeName);
              }),
              drawerIcon('My Address', Icons.location_history_outlined, () {
                Navigator.of(context).pushNamed(MyAddressScreen.routeName);
              }),
              drawerIcon('My Order', Icons.shopping_cart_outlined, () {
                Navigator.of(context).pushNamed(OrderScreen.routeName);
              }),
              SizedBox(
                height: size.height * 0.03,
              ),
              SizedBox(
                width: size.width * 0.55,
                child: Divider(
                  color: CustomColor.whitecolor.withOpacity(0.2),
                  thickness: 1,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              // drawerIcon('Track Your Order', Icons.art_track_sharp, () {}),
              // SizedBox(
              //   width: size.width * 0.7,
              //   child: ListTile(
              //     leading: Text(''),
              //     title: Text(
              //       'Light Theme',
              //       style: CustomThemeData().drawerStyle(),
              //     ),
              //     trailing: Transform.scale(
              //         scale: 0.6,
              //         child: CupertinoSwitch(value: true, onChanged: (val) {})),
              //   ),
              // ),
              drawerIcon('Invite a Friend', Icons.person_add_outlined, () {
                Share.share('https://play.google.com/store/apps',
                    subject: 'FOOD APP');
              }),
              drawerIcon('Help Center', Icons.help_outline, () {}),
              // drawerIcon('Settings', Icons.settings_outlined, () {}),
              drawerIcon('Logout', Icons.logout_outlined, () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear().then((value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen(),
                    ),
                    (route) => false,
                  );
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
