import 'dart:convert';

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

class RelatatedProdWid extends StatefulWidget {
  const RelatatedProdWid({Key key}) : super(key: key);

  @override
  State<RelatatedProdWid> createState() => _RelatatedProdWidState();
}

class _RelatatedProdWidState extends State<RelatatedProdWid> {
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
    final productCategory = Provider.of<Product>(context);
    final favbutton = Provider.of<FavouriteProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;
    GlobalServices _services = GlobalServices();
    GlobalSnackBar _snackbar = GlobalSnackBar();
    // final base64 = productCategory.imageUrl == ''
    //     ? customBase64
    //     : productCategory.imageUrl;
    // var image = base64Decode(base64);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: {
          'productId': productCategory.productId,
          'productVarientId': productCategory.varient
        });
      },
      child: SizedBox(
        width: size.width * 0.48,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(5),
          color: CustomColor.whitecolor,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.13,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    productCategory.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      productCategory.title,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                    Text(
                      'Price : ₹' + productCategory.price.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: size.height * 0.04,
                          child: ElevatedButton(
                              onPressed: () {
                                if (cart.cartproduct
                                    .contains(productCategory.productId)) {
                                  _services.customDialog(
                                      context,
                                      productCategory.title,
                                      'This product is already in cart');
                                } else {
                                  cart.addToCart(
                                      id: productCategory.productId,
                                      // title: productCategory.title,
                                      // price:
                                      //     productCategory.price.roundToDouble(),
                                      // imageUrl: productCategory.imageUrl,
                                      quantity: productCategory.quantity);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      _snackbar.customSnackbar(
                                          context: context));
                                }
                              },
                              child: Text(cart.cartproduct
                                      .contains(productCategory.productId)
                                  ? 'In Cart  '
                                  : 'Add to cart')),
                        ),
                        InkWell(
                            onTap: () async {
                              if (loading) {
                                print('loading');
                              } else {
                                if (productCategory.isFavourite == false) {
                                  setState(() {
                                    loading = true;
                                  });

                                  await Provider.of<FavouriteProvider>(context,
                                          listen: false)
                                      .addFavouriteProductPostApi(
                                          context: context,
                                          productId: productCategory.productId)
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
                                } else if (productCategory.isFavourite ==
                                    true) {
                                  setState(() {
                                    loading = true;
                                  });
                                  await Provider.of<FavouriteProvider>(context,
                                          listen: false)
                                      .deleteFavourite(
                                    prodId: productCategory.productId,
                                    context: context,
                                  )
                                      .then((value) async {
                                    await Provider.of<FavouriteProvider>(
                                            context,
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
                                      productCategory.isFavourite = false;
                                    });
                                  });
                                }
                                print('normal data');
                                // print(product.productId + 'product id');
                                // print(favprodu.fav[0].id + 'product id');

                              }
                            },
                            child: loading
                                ? CupertinoActivityIndicator(
                                    animating: true,
                                    color: CustomColor.orangecolor,
                                    radius: 15,
                                  )
                                : Icon(
                                    productCategory.isFavourite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: productCategory.isFavourite
                                        ? CustomColor.orangecolor
                                        : CustomColor.blackcolor,
                                  ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
