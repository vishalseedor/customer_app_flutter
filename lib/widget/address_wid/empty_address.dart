import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/screen/manage_address/add_address.dart';

class AddressEmptyScreen extends StatelessWidget {
  const AddressEmptyScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 140,
            color: CustomColor.orangecolor,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          const Text('NO SAVED ADDRESS'),
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(
            'Please Add your address to deliver a product',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AddAddressScreen.routeName);
              },
              child: const Text('ADD YOUR ADDRESS'))
        ],
      ),
    );
  }
}
