import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/models/favourite.dart';
import 'package:food_app/provider/favourite_provider.dart';
import 'package:food_app/screen/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../const/image_base64.dart';
import '../../provider/product_provider.dart';

class FavouriteDesign extends StatefulWidget {
  final String productId;

  // ignore: use_key_in_widget_constructors
  const FavouriteDesign({
    @required this.productId,
  });

  @override
  State<FavouriteDesign> createState() => _FavouriteDesignState();
}

class _FavouriteDesignState extends State<FavouriteDesign> {
  bool loading = false;
  String productVarient;

  Future<void> getProductvarient() {
    final product = Provider.of<ProductProvider>(context, listen: false);
    for (var i = 0; i < product.product.length; i++) {
      if (widget.productId == product.product[i].productId) {
        setState(() {
          productVarient = product.product[i].varient.toString();
        });
      }
    }
  }

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

    void makeFavProdfaslse(String id) {
      final data = Provider.of<ProductProvider>(context, listen: false);
      for (var i = 0; i < data.product.length; i++) {
        if (id == data.product[i].productId) {
          data.product[i].isFavourite = false;
        }
      }
    }

    Size size = MediaQuery.of(context).size;
    final fav = Provider.of<Favourite>(context);
    final favproduct = Provider.of<FavouriteProvider>(context);
    // final base64 = fav.imageUrl == '' ? customBase64 : fav.imageUrl;
    // var image = base64Decode(base64);

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) async {
        setState(() {
          loading = true;
        });
        await Provider.of<FavouriteProvider>(context, listen: false)
            .deleteFavourite(
          prodId: widget.productId,
          context: context,
        )
            .then((value) async {
          await Provider.of<FavouriteProvider>(context, listen: false)
              .getFavouriteProductId(
            context: context,
          )
              .then((value) {
            setState(() {
              loading = false;
            });
            print(value.toString() + 'helo helo');
            favIconButtton();
            makeFavProdfaslse(widget.productId);
            // categorydata.isFavourite = false;
          });
        });
      },
      background: Container(
        color: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          getProductvarient().then((value) {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: {
                  'productId': widget.productId,
                  'productVarientId': productVarient
                });
          });
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          // height: size.height * 0.15,
          // width: size.width,
          decoration: BoxDecoration(
            color: CustomColor.whitecolor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: CustomColor.dryOrange),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: size.width * 0.22,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: MemoryImage(
                                fav.imageUrl,
                              ),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(fav.productTitle),
                        Text('Price : ₹' + fav.productPrice.toString(),
                            style: Theme.of(context).textTheme.subtitle2),
                        Text(
                          fav.productCategory,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await Provider.of<FavouriteProvider>(context,
                              listen: false)
                          .deleteFavourite(
                        prodId: widget.productId,
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
                          makeFavProdfaslse(widget.productId);
                          // categorydata.isFavourite = false;
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: CustomColor.redcolor,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
