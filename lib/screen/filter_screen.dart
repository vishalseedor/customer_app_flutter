import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/provider/categories_provider.dart';

import 'package:provider/provider.dart';

class FilterSCreen extends StatefulWidget {
  const FilterSCreen({Key key}) : super(key: key);
  static const routeName = 'filter-screen';

  @override
  _FilterSCreenState createState() => _FilterSCreenState();
}

class _FilterSCreenState extends State<FilterSCreen> {
  RangeValues values = const RangeValues(1, 1000);
  RangeLabels labels = const RangeLabels('1', "1000");

  List<Map<String, dynamic>> rating = [
    {
      'rating': 1.0,
      'value': false,
    },
    {
      'rating': 2.0,
      'value': false,
    },
    {
      'rating': 3.0,
      'value': false,
    },
    {
      'rating': 4.0,
      'value': false,
    },
    {
      'rating': 5.0,
      'value': false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final productCategory = Provider.of<CategoriesProvider>(context).categories;
    // final productRating = Provider.of<ProductProvider>(context).product;

    Widget text(String title) {
      return Container(alignment: Alignment.centerLeft, child: Text(title));
    }

    return Scaffold(
      body: Container(
        height: size.height,
        margin: const EdgeInsets.all(10),
        // color: CustomColor.blackcolor,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter Your Search',
                      // style: Theme.of(context).textTheme.headline1,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          CustomImages.cancelGrey,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                text('Price Range'),
                // SizedBox(
                //   height: size.height * 0.0,
                // ),
                Row(
                  children: [
                    Text(
                      '${values.start.toInt().toString()}₹',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Flexible(
                      child: RangeSlider(
                          divisions: 10,
                          activeColor: CustomColor.orangecolor,
                          inactiveColor: CustomColor.grey200,
                          min: 1,
                          max: 1000,
                          values: values,
                          labels: labels,
                          onChanged: (value) {
                            setState(() {
                              values = value;
                              labels = RangeLabels(
                                  "${value.start.toInt().toString()}₹",
                                  "${value.end.toInt().toString()}₹");
                            });
                          }),
                    ),
                    Text(
                      '${values.end.toInt().toString()}₹',
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                text('Tags'),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: List.generate(
                      productCategory.length,
                      (index) => InkWell(
                            onTap: () {
                              setState(() {
                                productCategory[index].isSelected =
                                    !productCategory[index].isSelected;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              height: size.height * 0.05,
                              decoration: BoxDecoration(
                                  color: productCategory[index].isSelected
                                      ? CustomColor.orangecolor
                                      : CustomColor.grey100,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  productCategory[index].title,
                                  style: TextStyle(
                                      color:
                                          productCategory[index].isSelected ==
                                                  true
                                              ? CustomColor.whitecolor
                                              : CustomColor.blackcolor,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          )),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                text('Rating'),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: List.generate(
                      rating.length,
                      (index) => InkWell(
                            onTap: () {
                              setState(() {
                                rating[index]['value'] =
                                    !rating[index]['value'];
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              height: size.height * 0.05,
                              width: size.width * 0.2,
                              decoration: BoxDecoration(
                                  color: rating[index]['value']
                                      ? CustomColor.orangecolor
                                      : CustomColor.grey100,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      rating[index]['rating'].toString(),
                                      style: TextStyle(
                                          color: rating[index]['value'] == true
                                              ? CustomColor.whitecolor
                                              : CustomColor.blackcolor,
                                          fontSize: 14),
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 15,
                                      color: rating[index]['value'] == true
                                          ? CustomColor.whitecolor
                                          : CustomColor.blackcolor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.065,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Apply'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
