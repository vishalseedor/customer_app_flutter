import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';

import 'package:food_app/models/product.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/provider/favourite_provider.dart';

import 'package:food_app/screen/product_detail_screen.dart';
import 'package:food_app/services/dialogbox.dart';
import 'package:food_app/services/snackbar.dart';
import 'package:provider/provider.dart';

import '../../const/image_base64.dart';
import '../../provider/product_provider.dart';

class ShowAllProductDesign extends StatefulWidget {
  const ShowAllProductDesign({Key key}) : super(key: key);

  @override
  State<ShowAllProductDesign> createState() => _ShowAllProductDesignState();
}

class _ShowAllProductDesignState extends State<ShowAllProductDesign> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
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
              print(data[j].id +
                  '  Fav product is true  ' +
                  product[i].productId);
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

    Size size = MediaQuery.of(context).size;
    final product = Provider.of<Product>(context);
    final favprod = Provider.of<FavouriteProvider>(context);
    GlobalServices _services = GlobalServices();
    final cart = Provider.of<CartProvider>(context);
    final cartProduct = cart.cartproduct;

    final fav = favprod.favourite;

    GlobalSnackBar _snackbar = GlobalSnackBar();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
            arguments: product.productId);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColor.grey100),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: size.height * 0.15,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: MemoryImage(product.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // print(favprodu.fav[0].id + 'product id');
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
                    },
                    child: CircleAvatar(
                      // radius: 20,
                      backgroundColor: product.isFavourite
                          ? CustomColor.dryOrange
                          : CustomColor.whitecolor,
                      child: loading
                          ? CupertinoActivityIndicator(
                              color: CustomColor.orangecolor,
                              radius: 15,
                              animating: true,
                            )
                          : Icon(
                              product.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: product.isFavourite
                                  ? CustomColor.orangecolor
                                  : CustomColor.blackcolor,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  AutoSizeText(
                    product.subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  AutoSizeText(
                    '₹ ' + product.price.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        child: ElevatedButton(
                          child:
                              Text(product.isCart ? 'In cart' : 'Add to Cart'),
                          onPressed: () {
                            if (product.isCart == true) {
                              _services.customDialog(context, product.title,
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
                                  cart.cartIconButtton(context: context);
                                  product.isCart = true;
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
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
