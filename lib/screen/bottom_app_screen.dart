import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/provider/bottom_navigationbar_provider.dart';

import 'package:food_app/screen/FavouriteScreen/favourite_screen.dart';
import 'package:food_app/screen/cart_screen/cart_screen.dart';

import 'package:food_app/screen/home&drawer/drawer_home_screen.dart';

import 'package:food_app/screen/profile/profile_screen.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/favourite_provider.dart';
import '../provider/product_provider.dart';

class BottomAppScreen extends StatefulWidget {
  const BottomAppScreen({Key key}) : super(key: key);
  static const routeName = 'Bottom-app-screen';

  @override
  _BottomAppScreenState createState() => _BottomAppScreenState();
}

class _BottomAppScreenState extends State<BottomAppScreen> {
  PageController _pageController;

  final List<Widget> _pages = const [
    DrawerHomeScreen(),
    FavouriteScreen(),
    MyCartScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomappbar = Provider.of<BottomNavigationBarProvider>(context);
    final productData = Provider.of<ProductProvider>(context);
    final favProd = Provider.of<FavouriteProvider>(context);
    final cartProd = Provider.of<CartProvider>(context);
    return Scaffold(
        body: _pages[bottomappbar.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomappbar.currentIndex,
          onTap: (val) {
            if (productData.loadingSpinner ||
                favProd.isLoading ||
                cartProd.isLoading) {
            } else {
              bottomappbar.currentIndex = val;
            }
          },
          selectedIconTheme:
              const IconThemeData(color: CustomColor.orangecolor),
          unselectedIconTheme: const IconThemeData(color: CustomColor.grey300),
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '',
            ),
          ],
        ));
  }
}
