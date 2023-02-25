import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

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
                    height: size.height * 0.5,
                    child: LottieBuilder.asset("assets/Report.json"))
                .animate()
                .fadeIn(delay: Duration(milliseconds: 500)),

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
                    "Boost Productivity",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ).animate().fadeIn(delay: Duration(milliseconds: 800)),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text(
                      "Restrict App Usage with Limited time app access",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ).animate().fadeIn(delay: Duration(milliseconds: 800)),
                  ),
                ],
              ),
            ),
            // Text(
            //   model.counterText,
            //   style: Theme.of(context).textTheme.headline6,
            // ),
            const SizedBox(
              height: 80.0,
            )
          ],
        ),
      ),
    );
  }
}
