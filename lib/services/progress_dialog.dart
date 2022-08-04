import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';

// ignore: must_be_immutable
class ProgressDialog extends StatelessWidget {
  String message;
   ProgressDialog({Key key,this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColor.whitecolor,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColor.whitecolor,
          borderRadius: BorderRadius.circular(10),

        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
             const SizedBox(
                width: 15,
              ),
            const  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
              const SizedBox(width: 15,),
              Text(message,style: Theme.of(context).textTheme.caption,)
            ],
          ),
        ),
      ),
    );
  }
}
