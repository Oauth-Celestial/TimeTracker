import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timetracker/Controller/OnBoardingController.dart';
import 'package:timetracker/Screens/OnboardingScreen/FirstPage.dart';
import 'package:timetracker/Screens/OnboardingScreen/SecondPage.dart';
import 'package:timetracker/Screens/OnboardingScreen/ThirdPage.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            LiquidSwipe(
                enableSideReveal: true,
                slideIconWidget: const Icon(Icons.arrow_back_ios),
                enableLoop: false,
                onPageChangeCallback: ((activePageIndex) {
                  Provider.of<OnBoardingController>(context, listen: false)
                      .changeOnBoardingPage(activePageIndex);
                }),
                waveType: WaveType.liquidReveal,
                pages: [FirstPage(), SecondPage(), ThirdPage()]),
            Consumer<OnBoardingController>(builder: (context, value, child) {
              return Positioned(
                bottom: 30,
                child: AnimatedSmoothIndicator(
                  count: 3,
                  activeIndex: value.currentPage,
                  curve: Curves.bounceIn,
                  // onDotClicked: (index) {
                  //   Provider.of<OnBoardingController>(context, listen: false)
                  //       .changeOnBoardingPage(index);
                  // },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
