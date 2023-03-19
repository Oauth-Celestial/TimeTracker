import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/EnableFocusModeController.dart';
import 'package:timetracker/Services/Helpers/FontStyleHelper.dart';
import 'package:timetracker/Services/Theme/ColorConstant.dart';

class EnableFocusMode extends StatelessWidget {
  final String title;
  final String description;
  final bool? hasDivider;
  final bool? showButton;
  EnableFocusMode(
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
                            child: Consumer<EnableFocusModeController>(
                                builder: (context, value, child) {
                              return CupertinoSwitch(
                                  value: value.enableFocusMode,
                                  activeColor: amber,
                                  onChanged: (value) {
                                    Provider.of<EnableFocusModeController>(
                                            context,
                                            listen: false)
                                        .addAppToFocusMode();
                                  });
                            })),
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
