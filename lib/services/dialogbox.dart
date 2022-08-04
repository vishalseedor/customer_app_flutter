import 'package:flutter/material.dart';
import 'package:food_app/screen/manage_address/add_address.dart';

class GlobalServices {
  customDialog(BuildContext context, String title, String subtitle) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title),
            content: Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }

  addressDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
  }) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title),
            content: Text(
              content,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const AddAddressScreen(
                              alertId: 'id',
                            )));
                  },
                  child: const Text('Add')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }
}
