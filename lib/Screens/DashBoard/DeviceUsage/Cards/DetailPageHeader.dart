import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/DeviceUsageController.dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class DetailPageHeader extends StatelessWidget {
  String title;
  String description;
  String lottiePath;
  bool? isDailyUsage;
  DetailPageHeader(
      {required this.title,
      required this.description,
      required this.lottiePath,
      this.isDailyUsage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.8,
          child: Container(
            height: 200,
            child: Container(
              child: LottieBuilder.asset(lottiePath),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.5),
          ])),
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: Container()),
              // "Today's Device Usage"
              Text(
                title,
                style: FontStyleHelper.shared.getPopppinsBold(whiteText, 20),
              ),
              SizedBox(
                height: 10,
              ),
              if (isDailyUsage ?? false) ...[
                Consumer<DeviceUsageController>(
                    builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            value.appUsage,
                            style: FontStyleHelper.shared
                                .getPopppinsBold(whiteText, 18),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ] else ...[
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description,
                      style:
                          FontStyleHelper.shared.getPopppinsBold(whiteText, 18),
                    ),
                  ),
                ),
              ],

              SizedBox(
                height: 30,
              )
            ])
                    .animate()
                    .moveX(
                        delay: Duration(milliseconds: 500), begin: -100, end: 0)
                    .fadeIn(delay: Duration(milliseconds: 400)),
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: 300))
      ],
    );
  }
}
