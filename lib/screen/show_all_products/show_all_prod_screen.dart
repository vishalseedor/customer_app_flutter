import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/widget/show_all_prod_design/show_all_product_design.dart';
import 'package:provider/provider.dart';

class ShowAllProductScreen extends StatelessWidget {
  const ShowAllProductScreen({Key key}) : super(key: key);
  static const routeName = 'show-all-product';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productdata = Provider.of<ProductProvider>(context);
    final product = productdata.product;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: CustomColor.blackcolor,
              )),
          title: const Text('All Product'),
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.5,
                crossAxisSpacing: size.width * 0.02,
                mainAxisSpacing: size.height* 0.02),
            itemCount: product.length,
            itemBuilder: (ctx, index) {
              return ChangeNotifierProvider.value(
                  value: product[index], child: const ShowAllProductDesign());
            }));
  }
}
