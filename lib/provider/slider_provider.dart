import 'package:flutter/material.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/models/slider.dart';

class SliderProivider with ChangeNotifier {
  final List<SliderContent> _slider = [
    SliderContent(
        id: 'a',
        title: 'Choose a Favourite Food',
        subtitle:
            'When your order Eat Street, we\'ll hook you up with \n exclusivge coupone, spendes and rewards',
        imageUrl: CustomImages.sliderdTwo),
    SliderContent(
        id: 'b',
        title: 'Recive the Greate Food',
        subtitle:
            'You\'ll recieve thje greate food within a hour.And \n get free dekivery credits for every order',
        imageUrl: CustomImages.sliderThree),
    SliderContent(
        id: 'c',
        title: 'Choose a Favourite Food',
        subtitle:
            'We make food ordering faster, simple and free-no \n matter if you order online or cash',
        imageUrl: CustomImages.sliderOne)
  ];
  List<SliderContent> get slider {
    return [..._slider];
  }
}
