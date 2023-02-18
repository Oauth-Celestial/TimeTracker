import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Model/PieDataModel.dart';
import 'package:timetracker/Services/ColorHelper.dart';
import 'package:timetracker/Services/DateHelper.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<InstalledAppController>(context, listen: false).getAllApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Consumer<InstalledAppController>(
              builder: (context, value, child) {
            List<PieChartDataModel> data = value.pieData;
            if (value.hasLoaded) {
              return ListView(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 300,
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                borderData: FlBorderData(show: false),
                                pieTouchData: PieTouchData(
                                  touchCallback: (p0, p1) {},
                                ),
                                sections: [
                                  for (int i = 0; i < data.length; i++) ...[
                                    PieChartSectionData(
                                      color: getRandomColor(),
                                      value: data[i].value,
                                      radius: 80,
                                      titleStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xffffffff),
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 2)
                                        ],
                                      ),
                                      badgeWidget: ClipOval(
                                        child: Image.memory(
                                          data[i].bytes!,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      badgePositionPercentageOffset: 1.3,
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Todays Screen Time",
                        style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        DateHelper.instance
                            .getFormattedTimeFromSeconds(value.totalScreenTime),
                        style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            4,
                            (index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.black,
                                ),
                              );
                            },
                          )),
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
