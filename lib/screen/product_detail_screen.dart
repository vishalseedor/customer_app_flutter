import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/const/theme.dart';
import 'package:food_app/provider/bottom_navigationbar_provider.dart';

import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/provider/favourite_provider.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/screen/bottom_app_screen.dart';

import 'package:food_app/services/dialogbox.dart';
import 'package:food_app/services/snackbar.dart';

import 'package:food_app/widget/categories/related_product_wid.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';

import '../const/image_base64.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key key}) : super(key: key);
  static const routeName = 'product-detail-screen';

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  void favIconButtton() {
    var data = Provider.of<FavouriteProvider>(context, listen: false).fav;
    // print('fav product lemngth ${data.length}');
    final product =
        Provider.of<ProductProvider>(context, listen: false).product;

    if (data.isNotEmpty) {
      for (var i = 0; i < product.length; i++) {
        print(product.length.toString() + 'product length');
        for (var j = 0; j < data.length; j++) {
          print(data.length.toString() + 'data length');
          if (product[i].productId == data[j].id) {
            print(
                data[j].id + '  Fav product is true  ' + product[i].productId);
            product[i].isFavourite = true;
          } else {
            print('Fav product is false' + product[i].productId);

            // product[i].isFavourite = false;
          }
        }
      }
    } else if (data.isEmpty) {
      print('data empty in favourite');
      for (var i = 0; i < product.length; i++) {
        product[i].isFavourite = false;
      }
    }
  }

  void cartIconButtton() {
    // var data = Provider.of<FavouriteProvider>(context, listen: false).fav;
    final cart = Provider.of<CartProvider>(context, listen: false);
    // print('fav product lemngth ${data.length}');
    final product =
        Provider.of<ProductProvider>(context, listen: false).product;

    if (cart.cartproduct.isNotEmpty) {
      for (var i = 0; i < product.length; i++) {
        print(product.length.toString() + 'product length');
        for (var j = 0; j < cart.cartproduct.length; j++) {
          print(cart.cartproduct.length.toString() + 'cart length');

          if (product[i].productId == cart.cartproduct[j].id) {
            print(cart.cartproduct[j].toString() +
                '  Cart product is true  ' +
                product[i].productId);
            product[i].isCart = true;
          } else {
            print('Fav product is false' + product[i].productId);

            // product[i].isFavourite = false;
          }
        }
      }
    } else if (cart.cartproduct.isEmpty) {
      print('data empty in favourite');
      for (var i = 0; i < product.length; i++) {
        product[i].isCart = false;
      }
    }
  }

  int currentindex = 0;
  bool loading = false;

  int currentPosition = 0;
  @override
  Widget build(BuildContext context) {
    GlobalSnackBar _snackbar = GlobalSnackBar();
    //This productId get from the home screen.
    final productId = ModalRoute.of(context).settings.arguments;
    //This step is used to find the product with their ID.
    final productDetails =
        Provider.of<ProductProvider>(context).findById(productId);
    //Here i have store the category in on variable
    final category = productDetails.categories;
// Here i have compare the category and store in list
    final productCategory =
        Provider.of<ProductProvider>(context).categoryProduct(category);
    //This one is use as favourite button
    final favobutton = Provider.of<FavouriteProvider>(context);
    // This one is use as cart
    final cart = Provider.of<CartProvider>(context);
    // final cartquantity = Provider.of<CartModel>(context);
    //List of Product
    final cartProduct = cart.cartproduct;
    Size size = MediaQuery.of(context).size;
    final navigation = Provider.of<BottomNavigationBarProvider>(context);

    GlobalServices _services = GlobalServices();
    // final base64 =
    //     productDetails.imageUrl == '' ? customBase64 : productDetails.imageUrl;
    // var image = base64Decode(base64);

    // final snackBar = SnackBar(
    //   content: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       SizedBox(
    //           height: 40,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text('${cartProduct.length + 1}  ITEM'),
    //               Row(
    //                 children: [
    //                   Text('₹' + cart.totalprice.toString()),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   const Text(
    //                     'plus taxes',
    //                     style: TextStyle(
    //                         fontSize: 12, color: CustomColor.whitecolor),
    //                   )
    //                 ],
    //               )
    //             ],
    //           )),
    //       InkWell(
    //           onTap: () {
    //             Navigator.of(context).pushNamed(MyCartScreen.routeName);
    //             ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //             // Navigator.of(context).pop();
    //           },
    //           child: Text('VIEW CART', style: CustomThemeData().drawerStyle()))
    //     ],
    //   ),
    //   margin: const EdgeInsets.all(10),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   backgroundColor: CustomColor.orangecolor,
    //   behavior: SnackBarBehavior.floating,
    //   // action: SnackBarAction(
    //   //   textColor: CustomColor.whitecolor,
    //   //   label: 'View cart',
    //   //   onPressed: () {},
    //   // ),
    // );

    return Scaffold(
      // backgroundColor: CustomColor.dryOrange,
      appBar: AppBar(
        backgroundColor: CustomColor.whitecolor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            // _keyScaffold.currentState!.openDrawer();
            Navigator.of(context).pop();
            // print('open');
          },
          child: Container(
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CustomColor.grey200)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                CustomImages.arrowLeft,
              ),
            ),
          ),
        ),
        title: const Text('Details'),
        // title: Text(
        //   'DETAILS',
        //   style: Theme.of(context).textTheme.bodyText2,
        // ),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.of(context).pop(navigation.currentIndex = 2);
                Navigator.of(context).pushNamed(BottomAppScreen.routeName);
                navigation.currentIndex = 2;
              },
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    color: CustomColor.blackcolor,
                    size: 32,
                  ),
                  Positioned(
                    bottom: 2,
                    child: Text(
                      cart.cartproduct.length.toString(),
                      style: const TextStyle(
                          color: CustomColor.orangecolor, fontSize: 10),
                    ),
                  )
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: CustomColor.whitecolor,
                height: size.height * 0.4,
                // margin:
                //     const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PinchZoom(
                      child: Container(
                        margin: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: CustomColor.dryOrange,
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: MemoryImage(productDetails.imageUrl),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    // PageView.builder(
                    //     onPageChanged: (val) {
                    //       setState(() {
                    //         currentPosition = val;
                    //       });
                    //     },
                    //     itemCount: productDetails.imageUrl.length,
                    //     itemBuilder: (ctx, index) {
                    //       return PinchZoom(
                    //         child: Container(
                    //           margin: const EdgeInsets.all(25),
                    //           decoration: BoxDecoration(
                    //               color: CustomColor.dryOrange,
                    //               // shape: BoxShape.circle,
                    //               borderRadius: BorderRadius.circular(20),
                    //               image: DecorationImage(
                    //                   image: NetworkImage(
                    //                       productDetails.imageUrl[index]),
                    //                   fit: BoxFit.fill)),
                    //         ),
                    //       );
                    //     }),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(
                    //       productDetails.imageUrl.length,
                    //       (index) => Container(
                    //             width: 10,
                    //             height: 10,
                    //             margin: const EdgeInsets.only(right: 10),
                    //             decoration: BoxDecoration(
                    //                 shape: BoxShape.circle,
                    //                 color: currentPosition == index
                    //                     ? CustomColor.orangecolor
                    //                     : Colors.grey),
                    //           )),
                    // )
                  ],
                )),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: CustomColor.whitecolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(productDetails.title)),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        productDetails.description,
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productDetails.colories + ' 🔥Calories',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        // Row(
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //         cart.addToCart(
                        //             id: productDetails.productId,
                        //             title: productDetails.title,
                        //             price: productDetails.price,
                        //             imageUrl: productDetails.imageUrl[0],
                        //             quantity: productDetails.quantity);
                        //       },
                        //       child: Container(
                        //           width: size.width * 0.1,
                        //           height: size.height * 0.04,
                        //           decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 color: CustomColor.orangecolor),
                        //             shape: BoxShape.circle,
                        //             color: CustomColor.whitecolor,
                        //           ),
                        //           child: Center(
                        //               child: Icon(
                        //             Icons.add,
                        //             color: CustomColor.orangecolor,
                        //           ))),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: ListView.builder(
                        //         itemBuilder: (ctx,index){
                        //           return  ChangeNotifierProvider.value(value:cartquantity[index],child: Text(''), );
                        //         },
                        //        )
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         cart.decreaseCount(
                        //             id: productDetails.productId,
                        //             title: productDetails.title,
                        //             price: productDetails.price,
                        //             imageUrl: productDetails.imageUrl[0],
                        //             quantity: productDetails.quantity);
                        //       },
                        //       child: Container(
                        //           width: size.width * 0.1,
                        //           height: size.height * 0.04,
                        //           decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 color: CustomColor.orangecolor),
                        //             shape: BoxShape.circle,
                        //             color: CustomColor.whitecolor,
                        //           ),
                        //           child: Center(
                        //               child: Icon(
                        //             Icons.remove,
                        //             color: CustomColor.orangecolor,
                        //           ))),
                        //     ),
                        //   ],
                        // ),
                        // Container(
                        //   height: size.height * 0.04,
                        //   width: size.width * 0.13,
                        //   decoration: BoxDecoration(
                        //       color: CustomColor.orangecolor,
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       // const Icon(
                        //       //   Icons.star,
                        //       //   color: CustomColor.whitecolor,
                        //       //   size: 18,
                        //       // ),

                        //       // Text(
                        //       //   productDetails.rating.toString(),
                        //       //   style: CustomThemeData().drawerStyle(),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          width: size.width * 0.18,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.timer,
                                size: 15,
                              ),
                              Text(
                                productDetails.timer.toString(),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Mins',
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ],
                          ),
                        ),
                        Text(
                          'Free Shipping',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      children: [
                        const Text('Size : '),
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        currentindex = index;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      width: size.width * 0.1,
                                      height: size.height * 0.05,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: currentindex == index
                                              ? CustomColor.orangecolor
                                              : CustomColor.whitecolor,
                                          border: Border.all(
                                              color: CustomColor.orangecolor)),
                                      child: Center(
                                          child: AutoSizeText(
                                        '14',
                                        style: TextStyle(
                                            color: currentindex == index
                                                ? CustomColor.whitecolor
                                                : CustomColor.blackcolor),
                                      )),
                                    ),
                                  )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                        width: size.width,
                        alignment: Alignment.centerLeft,
                        child: const Text('Product Review')),
                    Column(
                        children: List.generate(
                      productDetails.review.length,
                      (index) => ListTile(
                        leading: Container(
                          height: size.height * 0.07,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 17,
                              ),
                              Text(
                                productDetails.rating.toString(),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          productDetails.review[index].reviewTitle,
                          style: CustomThemeData().sliderSubtitleText(),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: size.width,
              alignment: Alignment.centerLeft,
              child: const Text('Related Product'),
            ),
            Container(
              height: size.height * 0.3,
              margin: const EdgeInsets.only(left: 10),
              child: Consumer<ProductProvider>(builder: (context, data, _) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.product.length,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                          value: data.product[index],
                          child: const RelatatedProdWid());
                    });
              }),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: CustomColor.whitecolor,
        elevation: 0,
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                if (loading) {
                  print('loading');
                } else {
                  if (productDetails.isFavourite == false) {
                    setState(() {
                      loading = true;
                    });

                    await Provider.of<FavouriteProvider>(context, listen: false)
                        .addFavouriteProductPostApi(
                            context: context, productId: productId)
                        .then((value) {
                      Provider.of<FavouriteProvider>(context, listen: false)
                          .getFavouriteProductId(
                        context: context,
                      )
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                        favIconButtton();
                      });
                    });

                    // favprodu.addToFavourite(
                    //     id: product.productId,
                    //     title: product.title,
                    //     price: product.price,
                    //     image: base64Decode(customBase64),
                    //     subtitle: product.subtitle);
                  } else if (productDetails.isFavourite == true) {
                    setState(() {
                      loading = true;
                    });
                    await Provider.of<FavouriteProvider>(context, listen: false)
                        .deleteFavourite(
                      prodId: productId,
                      context: context,
                    )
                        .then((value) async {
                      await Provider.of<FavouriteProvider>(context,
                              listen: false)
                          .getFavouriteProductId(
                        context: context,
                      )
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                        print(value.toString() + 'helo helo');
                        favIconButtton();
                        productDetails.isFavourite = false;
                      });
                    });
                  }
                  print('normal data');
                  // print(product.productId + 'product id');
                  // print(favprodu.fav[0].id + 'product id');

                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                height: size.height * 0.06,
                width: size.width * 0.14,
                decoration: BoxDecoration(
                    color: productDetails.isFavourite
                        ? CustomColor.dryOrange
                        : CustomColor.whitecolor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: CustomColor.orangecolor)),
                child: Center(
                    child: loading
                        ? CupertinoActivityIndicator(
                            radius: 15,
                            color: CustomColor.orangecolor,
                            animating: true,
                          )
                        : Icon(
                            productDetails.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: productDetails.isFavourite
                                ? CustomColor.orangecolor
                                : CustomColor.blackcolor,
                          )),
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                width: size.width,
                height: size.height * 0.06,
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag),
                      Text(productDetails.isCart ? 'Already in bag' : 'Bag It'),
                    ],
                  ),
                  onPressed: () {
                    if (productDetails.isCart) {
                      _services.customDialog(context, productDetails.title,
                          'This product is already in cart');
                    } else {
                      cart
                          .cartProductPost(
                              context: context,
                              productId: productDetails.productId,
                              quantity: 1)
                          .then((value) {
                        cart.cartProductId(context: context).then((value) {
                          cartIconButtton();
                          productDetails.isCart = true;
                        });
                      });

                      // cart.addToCart(
                      //     id: product.productId,
                      //     title: product.title,
                      //     price: product.price.roundToDouble(),
                      //     imageUrl: base64Decode(customBase64),
                      //     quantity: product.quantity);
                      ScaffoldMessenger.of(context).showSnackBar(
                          _snackbar.customSnackbar(context: context));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
