import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/provider/favourite_provider.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/services/statefullwraper.dart';
import 'package:food_app/widget/popular_product_wid/popular_product_design.dart';
import 'package:provider/provider.dart';

import '../../const/color_const.dart';

class PopularProductWid extends StatelessWidget {
  const PopularProductWid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productData = Provider.of<ProductProvider>(context);
    final favProd = Provider.of<FavouriteProvider>(context);
    final cartProd = Provider.of<CartProvider>(context);
    final product = productData.product;
    // final cart = Provider.of<CartProvider>(context);

    return Container(
      margin: const EdgeInsets.all(2),
      height: size.height * 0.35,
      child: StatefulWrapper(
        onInit: () {},
        child: AnimationLimiter(
          child: Consumer<ProductProvider>(builder: (context, data, _) {
            return ListView.builder(
                itemCount: data.product.length,
                padding: const EdgeInsets.symmetric(vertical: 5),
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  print(index.toString() + 'index value too');
                  return data.product.isEmpty
                      ? const Center(
                          child: Text('No Product to show...'),
                        )
                      : AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 300),
                          child: SlideAnimation(
                            horizontalOffset: 110,
                            child: ChangeNotifierProvider.value(
                                value: data.product[index],
                                child: PopularProductDesign(
                                  index: index,
                                )),
                          ),
                        );
                });
          }),
        ),
      ),
    );
  }
}
