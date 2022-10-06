import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';

class CustomThemeData {
  themeDataOne(BuildContext context) {
    return ThemeData(
      hintColor: CustomColor.grey300,
      fontFamily: 'Cairo',
      scaffoldBackgroundColor: CustomColor.whitecolor,
      primaryColor: CustomColor.orangecolor,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: CustomColor.blackcolor,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        elevation: 0,
        backgroundColor: CustomColor.whitecolor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(CustomColor.orangecolor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))))),
      textTheme: const TextTheme(
          headline4: TextStyle(
              color: CustomColor.blackcolor,
              fontSize: 15,
              fontWeight: FontWeight.w500),
          bodyText1: TextStyle(
              color: CustomColor.orangecolor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          bodyText2: TextStyle(
              color: CustomColor.blackcolor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          subtitle1: TextStyle(
              color: CustomColor.orangecolor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          headline3: TextStyle(
            color: CustomColor.grey400,
            fontSize: 14,
          ),
          subtitle2: TextStyle(
            color: CustomColor.grey500,
            fontSize: 16,
          ),
          caption: TextStyle(
            color: CustomColor.grey400,
            fontSize: 13,
          ),
          headline1: TextStyle(
              color: CustomColor.blackcolor,
              fontSize: 17,
              fontWeight: FontWeight.bold),
          headline2: TextStyle(
              color: CustomColor.blackcolor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          headline5: TextStyle(fontSize: 15, color: CustomColor.grey500)),
    );
  }

  sliderTitleText() {
    return const TextStyle(
      color: CustomColor.blackcolor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  drawerStyle() {
    return const TextStyle(
      color: CustomColor.whitecolor,
      fontSize: 14,
    );
  }

  sliderSubtitleText() {
    return const TextStyle(
      color: CustomColor.grey300,
      fontSize: 14,
    );
  }

  expansionstyle() {
    return const TextStyle(
      color: CustomColor.orangecolor,
      fontSize: 12,
    );
  }

  clearStyle() {
    return const TextStyle(color: CustomColor.blackcolor, fontSize: 13);
  }
}
