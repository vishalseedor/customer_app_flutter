import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/provider/categories_provider.dart';
import 'package:food_app/screen/categories_screen.dart';
import 'package:food_app/services/statefullwraper.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/image_base64.dart';
import '../../provider/cart_provider.dart';
import '../../provider/favourite_provider.dart';
import '../../provider/product_provider.dart';

class CategoriesWid extends StatelessWidget {
  static const routeName = 'categories-pro';

  const CategoriesWid({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final categories = Provider.of<CategoriesProvider>(context);
    final product = Provider.of<ProductProvider>(context);

    final favProd = Provider.of<FavouriteProvider>(context);
    final cartProd = Provider.of<CartProvider>(context);

    return StatefulWrapper(
      onInit: () {
        Provider.of<CategoriesProvider>(context).getAllategoryProd(context);
      },
      child: Consumer<CategoriesProvider>(builder: (context, data, _) {
        return categories.loadingSpinner
            ? SizedBox(
                width: size.width,
                height: size.height * 0.07,
                child: Shimmer.fromColors(
                    baseColor: Colors.grey[50],
                    highlightColor: Colors.grey[300],
                    child: Container(
                      width: size.width,
                      color: CustomColor.whitecolor,
                    )),
              )
            : SizedBox(
                height: size.height * 0.07,
                width: size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.categories.length,
                    itemBuilder: (ctx, index) {
                      // final base64 = data.categories[index].image == ''
                      //     ? customBase64
                      //     : data.categories[index].image;
                      // var image = base64Decode(base64);

                      return Container(
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                            color: CustomColor.white300,
                            borderRadius: BorderRadius.circular(10)),
                        margin:
                            const EdgeInsets.only(right: 10, top: 2, bottom: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: InkWell(
                          onTap: () {
                            if (product.loadingSpinner ||
                                cartProd.isLoading ||
                                favProd.isLoading) {
                            } else {
                              Navigator.of(context).pushNamed(
                                  CategoriesProductScreen.routeName,
                                  arguments: data.categories[index].id);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: CustomColor.whitecolor,
                                  backgroundImage: data.categories[index].image
                                              .toString() ==
                                          'null'
                                      ? const AssetImage(CustomImages.appLogo)
                                      : MemoryImage(
                                          data.categories[index].image),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  data.categories[index].title,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
      }),
    );

    // return SizedBox(
    //   height: size.height * 0.07,
    //   child: FutureBuilder<List<Categories>>(
    //       future: CategoriesProvider().getAllategoryProd(context),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return SizedBox(
    //             width: size.width,
    //             height: 100.0,
    //             child: Shimmer.fromColors(
    //                 baseColor: Colors.grey[50],
    //                 highlightColor: Colors.grey[300],
    //                 child: Container(
    //                   width: size.width,
    //                   color: CustomColor.whitecolor,
    //                 )),
    //           );
    //         } else if (snapshot.hasError) {
    //           return const Center(
    //             child: Padding(
    //               padding: EdgeInsets.only(bottom: 60),
    //               child: Text('Something went wrong'),
    //             ),
    //           );
    //         } else if (snapshot.data == null) {
    //           return const Padding(
    //             padding: EdgeInsets.only(bottom: 60),
    //             child: Center(
    //               child: Text('No data avalible'),
    //             ),
    //           );
    //         } else if (snapshot.hasData) {
    //           return Consumer<CategoriesProvider>(
    //             builder: (context,data,_) {
    //               return ListView.builder(
    //                   scrollDirection: Axis.horizontal,
    //                   itemCount: data.categories.length,
    //                   itemBuilder: (ctx, index) {
    //                     return Container(
    //                       width: size.width * 0.24,
    //                       decoration: BoxDecoration(
    //                           color: CustomColor.white300,
    //                           borderRadius: BorderRadius.circular(10)),
    //                       margin:
    //                           const EdgeInsets.only(right: 10, top: 2, bottom: 2),
    //                       child: InkWell(
    //                         onTap: () {
    //                           Navigator.of(context).pushNamed(
    //                               CategoriesProductScreen.routeName,
    //                               arguments: snapshot.data[index].id);
    //                         },
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                           children: [
    //                             Text(
    //                               data.categories[index].title,
    //                               style: Theme.of(context).textTheme.subtitle2,
    //                               overflow: TextOverflow.ellipsis,
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     );
    //                   });
    //             }
    //           );
    //         }
    //         return const Center(
    //           child: Padding(
    //             padding: EdgeInsets.only(bottom: 60),
    //             child: Text('Something went wrong'),
    //           ),
    //         );
    //       }),
    // );
  }
}
