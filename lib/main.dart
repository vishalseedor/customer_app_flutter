import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_app/const/key.dart';
import 'package:food_app/const/theme.dart';
import 'package:food_app/provider/address/address_data.dart';

import 'package:food_app/provider/address/address_provider.dart';
import 'package:food_app/provider/auth_provider.dart';
import 'package:food_app/provider/bottom_navigationbar_provider.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/provider/categories_provider.dart';
import 'package:food_app/provider/device_info.dart';
import 'package:food_app/provider/favourite_provider.dart';
import 'package:food_app/provider/order_provider.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/provider/profile_provider.dart';
import 'package:food_app/provider/review_provider.dart';
import 'package:food_app/provider/shareprefes_provider.dart';
import 'package:food_app/provider/slider_provider.dart';
import 'package:food_app/provider/theme_provider.dart';
import 'package:food_app/screen/FavouriteScreen/favourite_screen.dart';
import 'package:food_app/screen/LoginScreen/login_screen.dart';
import 'package:food_app/screen/bottom_app_screen.dart';
import 'package:food_app/screen/cart_screen/cart_screen.dart';
import 'package:food_app/screen/categories_screen.dart';
import 'package:food_app/screen/home&drawer/drawer_home_screen.dart';
import 'package:food_app/screen/filter_screen.dart';

import 'package:food_app/screen/manage_address/add_address.dart';
import 'package:food_app/screen/manage_address/my_address.dart';
import 'package:food_app/screen/order/order_details_screen/order_details_screen.dart';
import 'package:food_app/screen/order/order_screen.dart';

import 'package:food_app/screen/password_recovery.dart';
import 'package:food_app/screen/product_detail_screen.dart';
import 'package:food_app/screen/profile/edit_profile_screen.dart';
import 'package:food_app/screen/register_screen.dart';
import 'package:food_app/screen/reset_password.dart';
import 'package:food_app/screen/show_all_products/show_all_prod_screen.dart';
import 'package:food_app/screen/slider_screen.dart';
import 'package:food_app/screen/splashscreen.dart';
import 'package:food_app/screen/successful_password.dart';
import 'package:food_app/screen/tracking/googletracking.dart';
import 'package:food_app/services/location.dart';
import 'package:food_app/widget/categories/categories_wid.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripeKey;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider _themeProvider = ThemeProvider();
  void getCurrentTheme() async {
    _themeProvider.darkThemeval =
        await _themeProvider.darkthemePrefernce.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: DeviceInformation()),
        ChangeNotifierProvider(create: (ctx) => SliderProivider()),
        ChangeNotifierProvider(create: (ctx) => CategoriesProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
        ChangeNotifierProvider(create: (ctx) => FavouriteProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => AddressProvider()),
        ChangeNotifierProvider(create: (ctx) => CurrentLocation()),
        ChangeNotifierProvider(create: (ctx) => OrderProvider()),
        ChangeNotifierProvider(create: (ctx) => ProfileProvider()),
        ChangeNotifierProvider(create: (ctx) => ReviewProvider()),
        ChangeNotifierProvider(create: (ctx) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (ctx) => _themeProvider),
        ChangeNotifierProvider(create: (ctx) => AddressData()),
        ChangeNotifierProvider.value(value: UserDetails()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: CustomThemeData().themeDataOne(context),
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
        routes: {
          'splash_screen': (context) => const SplashScreen(),
          'Slider_Screen': (context) => const SliderSCreen(),
          'login-screen': (context) => const LoginScreen(),
          'register-screen': (context) => const RFegisterScreen(),
          'password-recovery': (context) => const PasswordRecoveryScreen(),
          'reset-password': (context) => const ResetPasswordScreen(),
          'successful-password': (context) => const SuccessfullPasswordScreen(),
          'home-drawer-screen': (context) => const DrawerHomeScreen(),
          'categories-pro': (context) => const CategoriesWid(),
          'categories-screen': (context) => const CategoriesProductScreen(),
          'product-detail-screen': (context) => const ProductDetailsScreen(),
          'filter-screen': (context) => const FilterSCreen(),
          'mycart_screen': (context) => const MyCartScreen(),
          'favourite-screen': (context) => const FavouriteScreen(),
          'Bottom-app-screen': (context) => const BottomAppScreen(),
          'Add-Address': (context) => const AddAddressScreen(),
          'my-address-screen': (context) => const MyAddressScreen(),
          'Order-screen': (context) => const OrderScreen(),
          'order-details': (context) => const OrderDetailsSCreen(),
          'edit-profile-screen': (context) => const EditProfileScreen(),
          'show-all-product': (context) => const ShowAllProductScreen(),
          'googlemap-traking': (context) => const GoogleMapTracking(),
        },
      ),
    );
  }
}
