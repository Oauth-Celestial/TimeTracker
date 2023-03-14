import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Screens/DashBoard/Pages/DashBoard/Dashboard.dart';
import 'package:timetracker/Screens/OnboardingScreen/OnboardingHome.dart';
import 'package:timetracker/Services/RouteManager.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  void initState() {
    super.initState();

    Provider.of<InstalledAppController>(context, listen: false).getAllApps();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              child: Container(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: LottieBuilder.asset("assets/Meditate.json",
                      repeat: false, onLoaded: (composition) {
                    _controller?.duration = composition.duration;

                    _controller?.forward().whenComplete(() async {
                      print("dONE");
                      final prefs = await SharedPreferences.getInstance();

                      var hasOnboarded = prefs.getBool('hasOnBoarded');
                      if (hasOnboarded ?? false) {
                        RouteManager.instance
                            .push(to: DashBoardPage(), context: context);
                      } else {
                        RouteManager.instance
                            .push(to: OnboardingPage(), context: context);
                      }
                    });
                  }),
                ),
              )).animate().scale(delay: Duration(milliseconds: 300)),
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            child: Shimmer.fromColors(
              baseColor: Colors.amber,
              highlightColor: Colors.yellow,
              child: Text(
                'Limit IT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().fadeIn(delay: Duration(seconds: 3)),
          ),
        ],
      )),
    );
  }
}
