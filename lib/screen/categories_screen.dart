import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';

import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/widget/categories/category_product_design.dart';
import 'package:provider/provider.dart';

class CategoriesProductScreen extends StatefulWidget {
  const CategoriesProductScreen({Key key}) : super(key: key);
  static const routeName = 'categories-screen';

  @override
  _CategoriesProductState createState() => _CategoriesProductState();
}

class _CategoriesProductState extends State<CategoriesProductScreen> {
  @override
  Widget build(BuildContext context) {
    final categories = ModalRoute.of(context).settings.arguments as String;
    final categorydata =
        Provider.of<ProductProvider>(context).categoryProduct(categories);

    Size size = MediaQuery.of(context).size;
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
          title: Text(categories),
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.5,
                crossAxisSpacing: size.width * 0.02,
                mainAxisSpacing: size.height * 0.02),
            itemCount: categorydata.length,
            itemBuilder: (ctx, index) {
              return ChangeNotifierProvider.value(
                  value: categorydata[index],
                  child: const CategoryProductDesign());
            }));
  }
}
