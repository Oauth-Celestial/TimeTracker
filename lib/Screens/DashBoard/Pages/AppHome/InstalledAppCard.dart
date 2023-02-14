import 'package:flutter/material.dart';

class InstalledAppCard extends StatelessWidget {
  int index;
  InstalledAppCard({required this.index});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            ClipOval(
              child: Container(
                width: 45,
                height: 45,
                color: Colors.black,
                child: ClipOval(
                  child: Image.asset(
                    'assets/luffy.jpg',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Clash Of Clans",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "34 Mins",
              style: TextStyle(
                  color: index % 2 == 0 ? Colors.greenAccent : Colors.redAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
