import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/provider/order_provider.dart';
import 'package:food_app/screen/order/order_empty_screen.dart';
import 'package:food_app/widget/order_wid/order_design.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = 'Order-screen';
  const OrderScreen({Key key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderProvider>(context, listen: false)
        .getAllOrdered(context: context);
    // print('check order api call -->>');
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<OrderProvider>(context).orderproduct;
    // product.update('address': null);

    // for (var i = 0; i <= product.values.toList()[i].cart.length; i++)
    final loading = Provider.of<OrderProvider>(context);
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
          title: const Text('Ordered Product'),
        ),
        body: loading.islOading
            ? Center(
                child: CircularProgressIndicator(
                  color: CustomColor.orangecolor,
                ),
              )
            : product.isEmpty
                ? const OrderEmptyScreen()
                : ListView.builder(
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      // var val = product[index].cart;
                      return ChangeNotifierProvider.value(
                          value: product[index], child: const OrderUiDesign());
                    }));
  }
}
