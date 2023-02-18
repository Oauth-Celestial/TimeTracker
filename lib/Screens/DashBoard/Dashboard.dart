import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: PieChart(PieChartData(sections: [
                PieChartSectionData(
                  color: Colors.blue,
                  value: 40,
                  title: '40%',
                  radius: 110,
                  titleStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff),
                    shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                  ),
                  badgeWidget: Icon(Icons.abc),
                  badgePositionPercentageOffset: 1.3,
                )
              ])),
            )
          ],
        ),
      ),
    );
  }
}
