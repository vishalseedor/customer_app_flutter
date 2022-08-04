import 'package:flutter/material.dart';

import 'package:food_app/models/product.dart';
import 'package:food_app/provider/product_provider.dart';

import 'package:food_app/widget/recommanded_product/recommanded_ui.dart';
import 'package:provider/provider.dart';

class RecommandedProdWid extends StatelessWidget {
  const RecommandedProdWid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productData = Provider.of<ProductProvider>(context);
    List<Product> product = productData.product;
    return Consumer<ProductProvider>(builder: (context, data, _) {
      return SizedBox(
        height: size.height * 0.25,
        // width: size.width * 0.85,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.product.length,
            itemBuilder: (ctx, index) {
              return ChangeNotifierProvider.value(
                  value: data.product[index], child: const RecommandedDesign());
            }),
      );
    });
  }
}
