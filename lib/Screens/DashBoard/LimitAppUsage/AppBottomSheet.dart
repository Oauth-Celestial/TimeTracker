import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSheet() {
  return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(),
        );
      });
}


// Widget timerPicker(BuildContext context) {
//   return CupertinoTimerPicker(
//     mode: CupertinoTimerPickerMode.hms,
//     minuteInterval: 1,
//     secondInterval: 1,
//     initialTimerDuration: initialTimer,
//     onTimerDurationChanged: (Duration changeTimer) {
//       setState(() {
//         initialTimer = changeTimer;
//         time =
//             '${changeTimer.inHours} hrs ${changeTimer.inMinutes % 60} mins ${changeTimer.inSeconds % 60} secs';
//       });
//     },
//   );
// }