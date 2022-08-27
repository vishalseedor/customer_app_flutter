import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_app/provider/filter_provider.dart';
import 'package:food_app/screen/filter_emptyscreen.dart';
import 'package:food_app/widget/show_all_prod_design/show_all_product_design.dart';
import 'package:provider/provider.dart';

import '../const/color_const.dart';
import '../widget/filter_product_design.dart';

class FilterProductScreen extends StatelessWidget {
  const FilterProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<FilterProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Filter Product'),),
      body: filter.filterProducts.isEmpty
            ? const FilterEmptyScreen()
            
            : Consumer<FilterProvider>(builder: (context, data, child) {
                print(data.filterProducts.length);
                return Container(
                    color: CustomColor.whitecolor,
                    child: AnimationLimiter(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,childAspectRatio: 2/3),
                          itemCount: data.filterProducts.length,
                          itemBuilder: (ctx, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 300),
                              child: ScaleAnimation(
                                duration: const Duration(milliseconds: 300),
                                child: FadeInAnimation(
                                  duration: const Duration(milliseconds: 300),
                                  child: ChangeNotifierProvider.value(
                                      value: data.filterProducts[index],
                                      child: FilterProductDesign()),
                                ),
                              ),
                            );
                          }),
                    ));
              })
    );
  }
}