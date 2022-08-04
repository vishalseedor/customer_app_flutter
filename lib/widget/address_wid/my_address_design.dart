import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/models/address/address.dart';
import 'package:food_app/provider/address/address_provider.dart';
import 'package:food_app/screen/manage_address/add_address.dart';
import 'package:provider/provider.dart';

class MyAddressDesign extends StatefulWidget {
  final String index;
  final String addressId;
  const MyAddressDesign(
      {@required this.addressId, @required this.index, Key key})
      : super(key: key);

  @override
  State<MyAddressDesign> createState() => _MyAddressDesignState();
}

class _MyAddressDesignState extends State<MyAddressDesign> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final address = Provider.of<Addresss>(context);
    // print('susha  ' + widget.addressId);

    final addressData = Provider.of<AddressProvider>(context, listen: false);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Address Type : ',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      TextSpan(
                        text: address.addresstype,
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ])),
                  ),
                  Text(address.name),
                  Text(
                    address.houseNumber,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    address.area,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    '${address.town},${address.state},${address.pincode}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    'Phone number : ${address.phoneNumber}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: CustomColor.orangecolor,
              child: IconButton(
                  onPressed: () {
                    print(widget.addressId + 'addressId');
                    print(address.addresstype + 'address type');
                    Navigator.of(context).pushNamed(AddAddressScreen.routeName,
                        arguments: widget.addressId);
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: CustomColor.whitecolor,
                  )),
            ),
          ),
          Positioned(
            top: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: CustomColor.orangecolor,
                child: IconButton(
                  onPressed: () {
                    addressData.deleteAddress(widget.addressId, context);
                  },
                  icon: const Icon(Icons.delete_outline),
                  color: CustomColor.whitecolor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
