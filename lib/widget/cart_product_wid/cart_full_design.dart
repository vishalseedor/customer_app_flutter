import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/models/address/address.dart';
import 'package:food_app/provider/address/address_provider.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/provider/order_provider.dart';
import 'package:food_app/screen/manage_address/add_address.dart';
import 'package:food_app/screen/order/order_screen.dart';
import 'package:food_app/services/dialogbox.dart';
import 'package:food_app/services/payment/stripe_payment.dart';
import 'package:food_app/services/snackbar.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import 'cart_product_design.dart';

class CartScreenDesign extends StatefulWidget {
  const CartScreenDesign({Key key}) : super(key: key);

  @override
  State<CartScreenDesign> createState() => _CartScreenDesignState();
}

class _CartScreenDesignState extends State<CartScreenDesign> {
  // const CartScreenDesign({Key? key}) : super(key: key);
  Addresss selectedAddress;
  bool onlinepayment = true;
  bool offlinepayment = false;
  bool screenRefresh = false;
  Timer timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {});
      }
    });

    final address = Provider.of<AddressProvider>(context).address;

    address.isEmpty ? selectedAddress = null : selectedAddress = address[0];

    // selectedAddress = address[0];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  Future<void> orderApiCall() async {
    print('start data + -->');

    final data = Provider.of<CartProvider>(context, listen: false);
    final cartproduct = data.cartproduct;
    List<String> listLineItem = [];
    var order = Provider.of<OrderProvider>(context, listen: false);
    String lineItem = 'gdhd';

    // print('selected address id + ' + selectedAddress.id);
    String addressdetails = selectedAddress.name +
        ',' +
        selectedAddress.houseNumber +
        ',' +
        selectedAddress.area +
        ',' +
        selectedAddress.pincode +
        ',' +
        selectedAddress.phoneNumber +
        ',' +
        selectedAddress.town +
        ',' +
        selectedAddress.state +
        ',' +
        selectedAddress.addresstype;

    for (var i = 0; i < cartproduct.length; i++) {
      lineItem =
          '{\"price\": \"${cartproduct[i].price}\", \"discount\": \"\0", \"productid\": \"${cartproduct[i].id}\", \"quantity\": \"${cartproduct[i].quantity}\",\"productName\": \"${cartproduct[i].title}\"}';
      // print(lineItem);
      listLineItem.add(lineItem);
    }
    // print('lineItem :: --> ${listLineItem.toString()}');
    // print(addressdetails + 'address data value');
    // print('address data value -->>' +
    //     selectedAddress.state +
    //     selectedAddress.addresstype);
    order.postOrderApi(
        amount: data.totalAmount.toString(),
        grandTotal: data.totalprice.toString(),
        paymentType:
            onlinepayment == true ? 'Pay with Card' : 'Cash on delivery',
        shippingCharge: data.shippingcharge.toString(),
        addressId: selectedAddress.id,
        context: context,
        addressDetails: addressdetails,
        lineItem: listLineItem.toString());
  }

  final GlobalServices _services = GlobalServices();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget _seeMoreAddress() {
      return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AddAddressScreen.routeName);
          },
          child: const CircleAvatar(
            backgroundColor: CustomColor.orangecolor,
            radius: 30,
            child: Icon(
              Icons.add,
              color: CustomColor.whitecolor,
            ),
          ));
    }

    final data = Provider.of<CartProvider>(context);
    final cartproduct = data.cartproduct;
    final total = data.totalAmount;
    final address = Provider.of<AddressProvider>(context).address;

    void paywithcard(String amount) async {
      try {
        // ProgressDialog dialog = ProgressDialog(context: context);
        print('payment gate way started');
        await StripeServices.payment(amount).then((value) {
          orderApiCall().then((value) {
            // data.removeAllCartProd(context: context);
            data.removeAllCartProd(context: context);
          });
        });

        // Provider.of<OrderProvider>(context, listen: false)
        //     .addorder(
        //       cartproduct: data.cartproduct.toList(),
        //       amount: data.totalprice,
        //       id: '',
        //       grandtotal: data.totalprice,
        //       itemTotal: data.totalAmount,
        //       payment: 'Strip payment',
        //       shipping: data.shippingcharge,
        //       deliveryAddress: selectedAddress,
        //       deliveryStatus: 'Ordered',
        //     )
        //     ;

        // dialog.close();
        // Navigator.of(context).pushNamed(OrderScreen.routeName);

        // dialog.close();

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: const SizedBox(
        //       height: 40,
        //       child: Center(
        //         child: Text('payment successful'),
        //       ),
        //     ),

        //     margin: const EdgeInsets.all(10),
        //     shape:
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //     backgroundColor: CustomColor.orangecolor,
        //     duration: const Duration(milliseconds: 2000),
        //     behavior: SnackBarBehavior.floating,
        //     //   action: SnackBarAction(
        //     //     textColor: CustomColor.whitecolor,
        //     //     label: 'View cart',
        //     //     onPressed: () {},
        //     //   ),
        //   ),
        // );
      } catch (error) {
        print(error.toString());
        // GlobalSnackBar().generalSnackbar(text: 'Something went worng');
      }
    }

    void cashOnDelivery(String amount) {
      orderApiCall().then((value) {
        data.removeAllCartProd(context: context);
        // data.removeAllCartProd(
        //   context: context,
        // );
      });
      // Provider.of<OrderProvider>(context, listen: false).addorder(
      //   cartproduct: data.cartproduct.toList(),
      //   amount: data.totalprice,
      //   id: '',
      //   grandtotal: data.totalprice,
      //   itemTotal: data.totalAmount,
      //   payment: 'Cash on delivery',
      //   shipping: data.shippingcharge,
      //   deliveryAddress: selectedAddress,
      //   deliveryStatus: 'Ordered',
      // );
    }

    Widget addressWid() {
      final addressWidget = List.generate(
          address.length,
          (index) => GestureDetector(
                onTap: null,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  width: size.width * 0.4,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedAddress == address[index]
                              ? CustomColor.orangecolor
                              : CustomColor.whitecolor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox(
                        width: size.width * 0.45,
                        child: Card(
                            margin: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    address[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    address[index].houseNumber,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    address[index].area,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    address[index].phoneNumber,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    address[index].state,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Radio(
                          activeColor: CustomColor.orangecolor,
                          value: address[index],
                          groupValue: selectedAddress,
                          onChanged: (val) {
                            setState(() {
                              selectedAddress = val;
                            });
                            // print(selectedAddress.toString());
                          }),
                    ],
                  ),
                ),
              ))
        ..add(_seeMoreAddress());
      return SizedBox(
          height: size.height * 0.2,
          width: size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: addressWidget,
          ));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery To :',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                address.isEmpty
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AddAddressScreen.routeName);
                        },
                        child: Shimmer.fromColors(
                          baseColor: CustomColor.orangecolor,
                          highlightColor:
                              CustomColor.orangecolor.withOpacity(0.4),
                          child: Text(
                            'Click to add your Address',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ))
                    : Column(
                        children: List.generate(
                          address.isEmpty ? 0 : 1,
                          (index) => Text(
                            selectedAddress.name +
                                    ',' +
                                    selectedAddress.houseNumber +
                                    ',' +
                                    selectedAddress.area +
                                    ',' +
                                    selectedAddress.pincode +
                                    ',' +
                                    selectedAddress.phoneNumber +
                                    ',' +
                                    selectedAddress.town ??
                                'null'
                                        ',' +
                                    selectedAddress.state ??
                                'null'
                                        ',' +
                                    selectedAddress.addresstype ??
                                'Please select the address',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      )
              ],
            ),
          ),
          address.isEmpty
              ? const Text('Their is no address to be selected')
              : addressWid(),
          AnimationLimiter(
              child: Column(
            children: List.generate(
                cartproduct.length,
                (index) => AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 300),
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 300),
                        child: FadeInAnimation(
                            duration: const Duration(milliseconds: 300),
                            child: ChangeNotifierProvider.value(
                                value: cartproduct.toList()[index],
                                child: CartProductDesign(
                                  index: index,
                                  productId: cartproduct[index].id,
                                  screenRefresh: screenRefresh,
                                ))),
                      ),
                    )),
          )),
          SizedBox(
            height: size.height * 0.02,
          ),
          total > 500
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Card(
                          color: CustomColor.greencolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.done,
                            size: 20,
                            color: CustomColor.whitecolor,
                          )),
                      Text(
                        'Free delivery applied',
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Card(
                          color: CustomColor.greencolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.done,
                            size: 20,
                            color: CustomColor.whitecolor,
                          )),
                      Text(
                        'Delivery Charge',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const Spacer(),
                      Text('₹ ' + data.shippingcharge.toString())
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Item Total',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '₹' + data.totalAmount.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Taxes & charges',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '₹' + data.totalTax.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery charges',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '₹' + data.shippingcharge.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grand Total',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      '₹' + data.totalprice,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
                const Divider(
                  color: CustomColor.grey200,
                ),
                Container(
                    width: size.width,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Your Payment Method',
                      style: Theme.of(context).textTheme.subtitle1,
                    )),
                ListTile(
                  onTap: () {
                    setState(() {
                      offlinepayment = true;
                      onlinepayment = false;
                    });
                  },
                  leading: Image.asset(
                    CustomImages.cashonDelivery,
                    width: size.width * 0.1,
                    height: size.height * 0.05,
                  ),
                  title: Text(
                    'Cash on Delivery',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  trailing: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: offlinepayment == true
                              ? CustomColor.orangecolor
                              : CustomColor.grey300,
                        ),
                        color: CustomColor.whitecolor,
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundColor: offlinepayment == true
                            ? CustomColor.orangecolor
                            : CustomColor.grey300,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      onlinepayment = true;
                      offlinepayment = false;
                    });
                  },
                  leading: Image.asset(
                    CustomImages.onlinePayment,
                    width: size.width * 0.1,
                    height: size.height * 0.05,
                  ),
                  title: Text(
                    'pay with card',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  trailing: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: onlinepayment == true
                              ? CustomColor.orangecolor
                              : CustomColor.grey300,
                        ),
                        color: CustomColor.whitecolor,
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundColor: onlinepayment == true
                            ? CustomColor.orangecolor
                            : CustomColor.grey300,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.065,
                  child: ElevatedButton(
                      onPressed: () {
                        if (address.isEmpty) {
                          _services.addressDialog(
                              context: context,
                              title: 'Address Empty',
                              content: 'Please add your Address');
                        } else {
                          if (onlinepayment == true) {
                            //  print('sushalt ::' + data.totalprice.toString() );
                            paywithcard(data.totalprice.toString());
                          } else if (offlinepayment == true) {
                            cashOnDelivery(data.totalprice.toString());
                          }
                        }
                      },
                      child: Text(address.isEmpty
                          ? 'Select Your Address'
                          : 'Check Out')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
