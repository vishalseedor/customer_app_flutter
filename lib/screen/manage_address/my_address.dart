import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/provider/address/address_provider.dart';
import 'package:food_app/services/statefullwraper.dart';
import 'package:food_app/widget/address_wid/empty_address.dart';
import 'package:food_app/widget/address_wid/my_address_design.dart';
import 'package:provider/provider.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key key}) : super(key: key);
  static const routeName = 'my-address-screen';

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AddressProvider>(context, listen: false)
        .getAddressData(context)
        .then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AddressProvider>(context);
    final address = data.address;
    return StatefulWrapper(
      onInit: () {
        //
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: CustomColor.blackcolor,
                )),
            title: const Text('My Address'),
          ),
          body: data.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : data.isErrorLoading
                  ? const Center(
                      child: Text('Something went wrong'),
                    )
                  : Consumer<AddressProvider>(builder: (context, data, _) {
                      return AnimationLimiter(
                        child: ListView.builder(
                            itemCount: address.length,
                            itemBuilder: (ctx, index) {
                              return address.isNotEmpty
                                  ? AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: ScaleAnimation(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          child: FadeInAnimation(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: ChangeNotifierProvider.value(
                                                value: data.address[index],
                                                child: MyAddressDesign(
                                                  index: data.address[index]
                                                      .toString(),
                                                  addressId:
                                                      data.address[index].id,
                                                )),
                                          )))
                                  : const Center(
                                      child: Text('No address to be display'),
                                    );
                            }),
                      );
                    })),
    );
  }
}
