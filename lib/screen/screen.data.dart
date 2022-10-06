import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';

class ScreenDataScreen extends StatelessWidget {
  const ScreenDataScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Text('Screen data is overloading data'),
            Column(
              children: [
                Text(
                  'something went wrong',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColor.blackcolor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
