import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/const/theme.dart';
import 'package:food_app/models/product.dart';
import 'package:food_app/provider/address/address_provider.dart';
import 'package:food_app/provider/bottom_navigationbar_provider.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/provider/favourite_provider.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/screen/filter_screen.dart';
import 'package:food_app/screen/manage_address/add_address.dart';
import 'package:food_app/screen/show_all_products/show_all_prod_screen.dart';
import 'package:food_app/widget/categories/categories_wid.dart';
import 'package:food_app/widget/popular_product_wid/popular_product_wid.dart';
import 'package:food_app/widget/recommaded_wid.dart';
import 'package:food_app/widget/show_all_prod_design/show_all_product_design.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/categories_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routename = 'home-screen';

  final VoidCallback openDrawer;

  const HomeScreen({Key key, @required this.openDrawer}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  bool inits = true;
  bool isLoadings = true;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 5), (timer) {
    //   setState(() {
    //     isLoadings = false;
    //     print(isLoadings.toString() + ' timer All data is loading -- >>');
    //   });
    // });

    Provider.of<ProductProvider>(context, listen: false)
        .valuePart(context: context);
  }

  // void twoteo() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.getBool('page');
  //   print(prefs.getBool('page').toString() + 'inistate value');
  // }

  // Future<void> valuePart() async {
  //   // setState(() {
  //   //   isLoadings = true;
  //   // });
  //   final data = Provider.of<ProductProvider>(context, listen: false);
  //   print('hekllo hello hello');
  //   final prefs = await SharedPreferences.getInstance();
  //   print(data.data.toString() + ' confirmation');
  //   if (data.data == true) {
  //     print(isLoadings.toString() + 'All data is loading');
  //     print('count');
  //     Provider.of<ProductProvider>(context, listen: false).boolDataFalse();
  //     await Provider.of<AddressProvider>(context, listen: false)
  //         .getAddressData(context)
  //         .then((value) async {
  //       print(isLoadings.toString() + 'All data is loading');
  //       await Provider.of<FavouriteProvider>(context, listen: false)
  //           .getFavouriteProductId(context: context)
  //           .then((value) async {
  //         print(isLoadings.toString() + 'All data is loading');
  //         await Provider.of<CartProvider>(context, listen: false)
  //             .cartProductId(
  //           context: context,
  //         )
  //             .then((value) async {
  //           print(isLoadings.toString() + 'All data is loading');
  //           await Provider.of<ProductProvider>(context, listen: false)
  //               .getProductData(context)
  //               .then((value) {
  //             print(isLoadings.toString() + 'All data is loading');

  //             print(isLoadings.toString() + 'All data is loading -- >>');

  //             // Timer.periodic(Duration(seconds: 3), (timer) {
  //             //   setState(() {
  //             //     isLoadings = false;
  //             //     print(isLoadings.toString() +
  //             //         ' timer All data is loading -- >>');
  //             //   });
  //             // });
  //           });
  //         });
  //       });
  //     });
  //   } else if (prefs.getBool('page') == false) {
  //     print('false false false');
  //     setState(() {
  //       isLoadings = false;
  //     });
  //   }
  //   // setState(() {
  //   //   isLoadings = false;
  //   // });
  // }

  bool dark = false;
  List<Product> _searchList = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final theme = Provider.of<ThemeProvider>(context);
    final product = Provider.of<ProductProvider>(context);

    final favProd = Provider.of<FavouriteProvider>(context);
    final cartProd = Provider.of<CartProvider>(context);
    final address = Provider.of<AddressProvider>(context).address;
    final cart = Provider.of<CartProvider>(context).cartproduct;
    final navigation = Provider.of<BottomNavigationBarProvider>(context);
    // final address = Provider.of(context);
    // print('address   :' + address.length.toString());
    // final profile = Provider.of<ProfileProvider>(context);
    // print(profile.profile.length.toString());
    // print(profile.profile.first.name);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.whitecolor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            // _keyScaffold.currentState!.openDrawer();
            widget.openDrawer();
            // print('open');
          },
          child: Container(
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CustomColor.grey200)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(CustomImages.drawer),
            ),
          ),
        ),
        title: Text(
          'HOME',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    navigation.currentIndex = 2;
                    // Navigator.of(context).pushNamed(MyCartScreen.routeName);
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 28,
                    color: CustomColor.blackcolor,
                  )),
              Positioned(
                top: 22,
                child: Text(
                  cart.length.toString(),
                  style: const TextStyle(
                      color: CustomColor.orangecolor, fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
      // drawer: Drawer(),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColor.grey100.withOpacity(0.4)),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: ThemeData().colorScheme.copyWith(
                              primary: CustomColor.orangecolor,
                            )),
                    child: TextFormField(
                      style: CustomThemeData().clearStyle(),
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        if (product.loadingSpinner ||
                            cartProd.isLoading ||
                            favProd.isLoading) {
                        } else {
                          _searchController.text.toLowerCase();

                          setState(() {
                            _searchList = product.searchQuery(value);
                          });
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          hintText: 'Search Food..',
                          suffixIcon: InkWell(
                            onTap: () {
                              showBottomSheet(
                                  context: context,
                                  builder: (ctx) {
                                    return ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: SizedBox(
                                        height: size.height * 0.61,
                                        child: const FilterSCreen(),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(14),
                              height: size.height * 0.06,
                              width: size.width * 0.10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage(CustomImages.filter))),
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                _searchController.text.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery To :',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                address.isEmpty
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              AddAddressScreen.routeName);
                                        },
                                        child: Shimmer.fromColors(
                                          baseColor: CustomColor.orangecolor,
                                          highlightColor: CustomColor
                                              .orangecolor
                                              .withOpacity(0.4),
                                          child: Text(
                                            'Click to add your Address',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                        ))
                                    : Column(
                                        children: List.generate(
                                          address.isEmpty ? 0 : 1,
                                          (index) => ReadMoreText(
                                            address[index].name +
                                                    ',' +
                                                    address[index].addresstype +
                                                    ',' +
                                                    address[index].houseNumber +
                                                    ',' +
                                                    address[index].area ??
                                                'null'
                                                        ',' +
                                                    address[index].pincode ??
                                                'null'
                                                        ',' +
                                                    address[index]
                                                        .phoneNumber ??
                                                'Please select the address',
                                            trimLines: 1,
                                            colorClickableText:
                                                CustomColor.orangecolor,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'Show more',
                                            trimExpandedText: 'Show less',
                                            lessStyle: CustomThemeData()
                                                .expansionstyle(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            moreStyle: CustomThemeData()
                                                .expansionstyle(),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          const CategoriesWid(),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Popular Near You',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              InkWell(
                                onTap: () async {
                                  () {
                                    if (product.loadingSpinner ||
                                        cartProd.isLoading ||
                                        favProd.isLoading) {
                                    } else {
                                      Navigator.of(context).pushNamed(
                                          ShowAllProductScreen.routeName);
                                    }
                                  };
                                },
                                child: Text(
                                  'Show all',
                                  style: CustomThemeData().sliderSubtitleText(),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          product.homeScreenLoading
                              ? const Text('Loading...')
                              : PopularProductWid(),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recommended',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              InkWell(
                                onTap: () {
                                  if (product.loadingSpinner ||
                                      cartProd.isLoading ||
                                      favProd.isLoading) {
                                  } else {
                                    Navigator.of(context).pushNamed(
                                        ShowAllProductScreen.routeName);
                                  }
                                },
                                child: Text(
                                  'Show all',
                                  style: CustomThemeData().sliderSubtitleText(),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          product.homeScreenLoading
                              ? const Text('Loading...')
                              : const RecommandedProdWid()
                        ],
                      )
                    : SizedBox(
                        height: size.height,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1 / 1.5,
                                    crossAxisSpacing: size.width * 0.02,
                                    mainAxisSpacing: size.height * 0.02),
                            itemCount: _searchList.length,
                            itemBuilder: (ctx, index) {
                              return ChangeNotifierProvider.value(
                                value: _searchList[index],
                                child: const ShowAllProductDesign(),
                              );
                            }),
                      )
              ],
            )),
      ),
    );
  }
}
