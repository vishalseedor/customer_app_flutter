import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/provider/bottom_navigationbar_provider.dart';

import 'package:provider/provider.dart';

class EmptyFavouriteScreen extends StatelessWidget {
  const EmptyFavouriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<BottomNavigationBarProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite,
              size: 150,
              color: CustomColor.orangecolor,
            ),
            const Text('No Favourites Yet!'),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'Once you favourite a Workmate,\n You\'ll see them here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            ElevatedButton(
                onPressed: () {
                  navigation.currentIndex = 0;
                },
                child: const Text(
                  'ADD PRODUCT TO FAVOURITES',
                ))
          ],
        ),
      ),
    );
  }
}
