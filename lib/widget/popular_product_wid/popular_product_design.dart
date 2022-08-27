import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/models/product.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/provider/favourite_provider.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/screen/product_detail_screen.dart';
import 'package:food_app/services/dialogbox.dart';
import 'package:food_app/services/snackbar.dart';
import 'package:provider/provider.dart';

import '../../const/image_base64.dart';

class PopularProductDesign extends StatefulWidget {
  final int index;
  const PopularProductDesign({@required this.index, Key key}) : super(key: key);

  @override
  State<PopularProductDesign> createState() => _PopularProductDesignState();
}

class _PopularProductDesignState extends State<PopularProductDesign> {
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('inistate value');
    favIconButtton();
    cartIconButtton();
  }

  void favIconButtton() {
    var data = Provider.of<FavouriteProvider>(context, listen: false).fav;
    // final cart = Provider.of<CartProvider>(context);
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

  @override
  Widget build(BuildContext context) {
    print(widget.index.toString() + 'index data in page');
    Size size = MediaQuery.of(context).size;
    final product = Provider.of<Product>(context);
    // final cartProduct = Provider.of<CartModel>(context);
    final favprodu = Provider.of<FavouriteProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    final cartproduct = cart.cartproduct;
    GlobalSnackBar _snackbar = GlobalSnackBar();
    GlobalServices _services = GlobalServices();

    // final base64 = product.imageUrl == '' ? customBase64 : product.imageUrl;
    // var image = base64Decode(base64);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          onTap: () {
            print('hghgcg');
            print(product.productId);
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: {
                  'productId': product.productId,
                  'productVarientId': product.varient
                });
          },
          child: Container(
            margin: EdgeInsets.only(
              right: size.width * 0.03,
              top: size.height * 0.06,
            ),
            height: size.height * 0.3,
            width: size.width * 0.45,
            decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.grey.shade100,
                //       // blurRadius: 0.2,
                //       offset: Offset(1, 1)),
                //   BoxShadow(
                //       color: Colors.grey.shade100,
                //       // blurRadius: 0.1,
                //       offset: Offset(1, 1))
                // ],
                color: CustomColor.whitecolor,
                borderRadius: BorderRadius.circular(10)),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(0),
              color: CustomColor.whitecolor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  AutoSizeText(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  AutoSizeText('₹' + product.price.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // AutoSizeText(
                      //   "   " + product.colories + ' 🔥Calories',
                      //   style: Theme.of(context).textTheme.caption,
                      // ),
                      Container(
                          width: size.width * 0.25,
                          height: size.height * 0.04,
                          decoration: BoxDecoration(
                              color: CustomColor.orangecolor,
                              borderRadius: BorderRadius.circular(10)),
                          child:
                              // ? Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       GestureDetector(
                              //           onTap: () {

                              //               cart.decreaseCount(
                              //                   id: product.productId,
                              //                   title: product.title,
                              //                   price: product.price,
                              //                   imageUrl: product.imageUrl[0],
                              //                   quantity: product.quantity);

                              //           },
                              //           child: const Icon(
                              //             Icons.remove,
                              //             color: CustomColor.whitecolor,
                              //           )),
                              //       Text(
                              //         cart.cartproduct.values
                              //             .toList()[index]
                              //             .quantity
                              //             .toString(),
                              //         style: CustomThemeData().drawerStyle(),
                              //       ),
                              //       GestureDetector(
                              //           onTap: () {
                              //             cart.addToCart(
                              //                 id: product.productId,
                              //                 title: product.title,
                              //                 price: product.price,
                              //                 imageUrl: product.imageUrl[0],
                              //                 quantity: product.quantity);
                              //           },
                              //           child: const Icon(
                              //             Icons.add,
                              //             color: CustomColor.whitecolor,
                              //           )),
                              //     ],
                              //   )
                              ElevatedButton(
                                  child: Text(product.isCart == true
                                      ? 'In cart'
                                      : 'Add to cart'),
                                  onPressed: () {
                                    if (product.isCart == true) {
                                      _services.customDialog(
                                          context,
                                          product.title,
                                          'This product is already in cart');
                                    } else {
                                      cart
                                          .cartProductPost(
                                              context: context,
                                              productId: product.productId,
                                              quantity: 1)
                                          .then((value) {
                                        cart
                                            .cartProductId(context: context)
                                            .then((value) {
                                          cartIconButtton();
                                          product.isCart = true;
                                        });
                                      });

                                      // cart.addToCart(
                                      //     id: product.productId,
                                      //     title: product.title,
                                      //     price: product.price.roundToDouble(),
                                      //     imageUrl: base64Decode(customBase64),
                                      //     quantity: product.quantity);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              _snackbar.customSnackbar(
                                                  context: context));
                                    }
                                  })),
                      IconButton(
                          onPressed: () async {
                            if (loading) {
                              print('loading');
                            } else {
                              if (product.isFavourite == false) {
                                setState(() {
                                  loading = true;
                                });

                                await Provider.of<FavouriteProvider>(context,
                                        listen: false)
                                    .addFavouriteProductPostApi(
                                        context: context,
                                        productId: product.productId)
                                    .then((value) {
                                  Provider.of<FavouriteProvider>(context,
                                          listen: false)
                                      .getFavouriteProductId(context: context)
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
                              } else if (product.isFavourite == true) {
                                setState(() {
                                  loading = true;
                                });
                                await Provider.of<FavouriteProvider>(context,
                                        listen: false)
                                    .deleteFavourite(
                                  prodId: product.productId,
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
                                    product.isFavourite = false;
                                  });
                                });
                              }
                              print('normal data');
                              // print(product.productId + 'product id');
                              // print(favprodu.fav[0].id + 'product id');

                            }
                            // if (favprodu.fav.isEmpty) {
                            // } else {
                            //   if (product.isFavourite) {
                            //     print('contain fav prod data');
                            //     // Provider.of<FavouriteProvider>(context,
                            //     //         listen: false)
                            //     //     .addFavouriteProductPostApi(
                            //     //         context: context,
                            //     //         productId: product.productId);

                            //   } else if (!favprodu.fav[widget.index].id
                            //       .contains(product.productId)) {
                            //     print('not contain fav prod data');

                            //   }
                            // }
                          },
                          icon: loading
                              ? const CupertinoActivityIndicator(
                                  color: CustomColor.orangecolor,
                                  radius: 14,
                                )
                              : Icon(
                                  product.isFavourite == true
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: product.isFavourite
                                      ? CustomColor.orangecolor
                                      : CustomColor.blackcolor,
                                  size: size.width * 0.06,
                                )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: size.width * 0.1,
          child: Container(
            height: size.height * 0.16,
            width: size.width * 0.32,
            decoration: BoxDecoration(
                color: CustomColor.dryOrange,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: MemoryImage(product.imageUrl), fit: BoxFit.fill)),
          ),
        ),
      ],
    );
  }
}
