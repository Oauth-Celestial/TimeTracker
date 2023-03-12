import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:timetracker/Screens/OnboardingScreen/UsageAccessPage.dart';
import 'package:timetracker/Services/RouteManager.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: darkBackground,
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: size.height * 0.46,
                child: LottieBuilder.asset("assets/apps.json")),

            // Image(
            //   image: AssetImage(model.image),
            //   height: size.height * 0.45,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Manage Files And Apps",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Text(
                      "Get Detailed Report for all apps at fingertip",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: whiteText, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            // Text(
            //   model.counterText,
            //   style: Theme.of(context).textTheme.headline6,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    RouteManager.instance
                        .push(to: UsageAcessPage(), context: context);
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    color: Colors.amber,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Get Started",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: ClipOval(
                                child: Container(
                              width: 30,
                              height: 30,
                              color: whiteText,
                              child: Icon(
                                Icons.arrow_right,
                                color: Colors.black,
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 40.0,
            )
          ],
        ),
      ),
    );
  }
}
