import 'package:flutter/material.dart';
import 'package:food_app/const/color_const.dart';
import 'package:food_app/const/images.dart';
import 'package:food_app/const/theme.dart';
import 'package:food_app/provider/slider_provider.dart';
import 'package:food_app/screen/LoginScreen/login_screen.dart';
import 'package:provider/provider.dart';

class SliderSCreen extends StatefulWidget {
  const SliderSCreen({Key key}) : super(key: key);
  static const routeName = 'Slider_Screen';

  @override
  _SliderSCreenState createState() => _SliderSCreenState();
}

class _SliderSCreenState extends State<SliderSCreen> {
  int currentIndex = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final slider = Provider.of<SliderProivider>(context).slider;
    return Scaffold(
        body: Column(
      children: [
        ClipRRect(
          // borderRadius: BorderRadius.vertical(
          //     bottom: Radius.elliptical(size.width, size.height * 0.25)),
          child: SizedBox(
            height: size.height * 0.7,
            // decoration: BoxDecoration(
            //   color: CustomColor.orangecolor.withOpacity(0.3),
            // ),
            child: PageView.builder(
                itemCount: slider.length,
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                size.width, size.height * 0.25)),
                        child: Container(
                          height: size.height * 0.5,
                          decoration: BoxDecoration(
                            color: CustomColor.orangecolor.withOpacity(0.3),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    CustomImages.seedorLogo,
                                    width: size.width * 0.16,
                                    height: size.height * 0.06,
                                  ),
                                  Text(
                                    'FOOD APP',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                              Image.asset(
                                slider[index].imageUrl,
                                width: size.width * 0.57,
                                height: size.height * 0.25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      Text(
                        slider[index].title,
                        style: CustomThemeData().sliderTitleText(),
                      ),
                      Text(
                        slider[index].subtitle,
                        style: CustomThemeData().sliderSubtitleText(),
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                }),
          ),
        ),
        SizedBox(
          height: size.height * 0.07,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                slider.length,
                (index) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: currentIndex == index
                          ? size.width * 0.06
                          : size.width * 0.03,
                      height: size.height * 0.013,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColor.orangecolor),
                    ))),
        SizedBox(
          height: size.height * 0.05,
        ),
        currentIndex == slider.length - 1
            ? Container(
                margin: const EdgeInsets.all(10),
                height: size.height * 0.07,
                width: size.width,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: const Text('Let\'s Get Started')))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: size.width * 0.25),
                              child: Text(
                                'Skip',
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.start,
                              ),
                            ))),
                    Expanded(
                        child: SizedBox(
                            height: size.height * 0.07,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                },
                                child: const Text('Next')))),
                  ],
                ),
              )
      ],
    ));
  }
}
