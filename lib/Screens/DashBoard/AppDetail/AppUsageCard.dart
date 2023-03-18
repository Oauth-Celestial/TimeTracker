import 'package:flutter/material.dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class AppUsageCard extends StatelessWidget {
  final String title;
  final String description;
  final bool? hasDivider;
  final bool? showButton;
  AppUsageCard(
      {required this.title,
      required this.description,
      this.hasDivider,
      this.showButton});
  @override
  Widget build(BuildContext context) {
    double leftPadding = 15;
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Container(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: FontStyleHelper.shared
                              .getPopppinsBold(whiteText, 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          description,
                          style: FontStyleHelper.shared
                              .getPopppinsMedium(whiteText, 16),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                    if (showButton ?? false)
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(stops: [
                                0.3,
                                1.0
                              ], colors: [
                                Colors.amber,
                                Colors.yellowAccent
                              ])),
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.arrow_right_alt,
                                color: whiteText,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                if (hasDivider ?? false) ...[
                  Padding(
                    padding: EdgeInsets.only(left: 3, right: 10),
                    child: Divider(
                      color: Colors.white,
                    ),
                  )
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
