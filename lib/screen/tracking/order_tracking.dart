import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';

class OrderTracking extends StatelessWidget {
  static const routeName = 'order-tracking';
  const OrderTracking({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Track Order'),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColor.orangecolor),
                    borderRadius: BorderRadius.circular(3),
                    color: CustomColor.orangecolor,
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.done,
                    color: CustomColor.whitecolor,
                  )),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                const Text('Ordered')
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              height: size.height * 0.15,
              child: const VerticalDivider(
                color: CustomColor.grey100,
                thickness: 2,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColor.orangecolor),
                    borderRadius: BorderRadius.circular(3),
                    color: CustomColor.orangecolor,
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.done,
                    color: CustomColor.whitecolor,
                  )),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                const Text('In Process')
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              height: size.height * 0.15,
              child: const VerticalDivider(
                color: CustomColor.grey100,
                thickness: 2,
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget trackingBox(BuildContext context, String text) {
    Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            border: Border.all(color: CustomColor.orangecolor),
            borderRadius: BorderRadius.circular(3),
            color: CustomColor.orangecolor,
          ),
          child: const Center(
              child: Icon(
            Icons.done,
            color: CustomColor.whitecolor,
          )),
        ),
        SizedBox(
          width: size.width * 0.1,
        ),
        Text(text)
      ],
    );
  }
}
