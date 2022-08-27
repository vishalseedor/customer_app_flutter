import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
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

class CategoryProductDesign extends StatefulWidget {
  const CategoryProductDesign({Key key}) : super(key: key);

  @override
  State<CategoryProductDesign> createState() => _CategoryProductDesignState();
}

class _CategoryProductDesignState extends State<CategoryProductDesign> {
  bool loading = false;
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

  @override
  Widget build(BuildContext context) {
    GlobalServices _services = GlobalServices();
    GlobalSnackBar _snackbar = GlobalSnackBar();
    Size size = MediaQuery.of(context).size;
    final categorydata = Provider.of<Product>(context);
    final cart = Provider.of<CartProvider>(context);

    final favprod = Provider.of<FavouriteProvider>(context);
    final fav = favprod.favourite;
    // final base64 =
    //     categorydata.imageUrl == '' ? customBase64 : categorydata.imageUrl;
    // var image = base64Decode(base64);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
            arguments: {
              'productId': categorydata.productId,
              'productVarientId': categorydata.varient
            });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColor.grey100),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: size.height * 0.15,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: MemoryImage(
                    categorydata.imageUrl,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (loading) {
                        print('loading');
                      } else {
                        if (categorydata.isFavourite == false) {
                          setState(() {
                            loading = true;
                          });

                          await Provider.of<FavouriteProvider>(context,
                                  listen: false)
                              .addFavouriteProductPostApi(
                                  context: context,
                                  productId: categorydata.productId)
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
                        } else if (categorydata.isFavourite == true) {
                          setState(() {
                            loading = true;
                          });
                          await Provider.of<FavouriteProvider>(context,
                                  listen: false)
                              .deleteFavourite(
                            prodId: categorydata.productId,
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
                              categorydata.isFavourite = false;
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
                      backgroundColor: categorydata.isFavourite
                          ? CustomColor.dryOrange
                          : CustomColor.whitecolor,
                      child: Icon(
                        categorydata.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: categorydata.isFavourite
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
                    categorydata.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  AutoSizeText(
                    categorydata.subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  AutoSizeText('₹ ' + categorydata.price.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: size.height * 0.04,
                        child: ElevatedButton(
                            onPressed: () {
                              if (categorydata.isCart == true) {
                                _services.customDialog(
                                    context,
                                    categorydata.title,
                                    'This product is already in cart');
                              } else {
                                cart
                                    .cartProductPost(
                                        context: context,
                                        productId: categorydata.productId,
                                        quantity: 1)
                                    .then((value) {
                                  cart
                                      .cartProductId(context: context)
                                      .then((value) {
                                    cart.cartIconButtton(context: context);
                                    categorydata.isCart = true;
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
                            child: Text(categorydata.isCart
                                ? 'In Cart  '
                                : 'Add to cart')),
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
