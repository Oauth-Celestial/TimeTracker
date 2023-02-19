import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Model/DoughnutDataModel%20.dart';
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
            String timeSpend = DateHelper.instance
                .getFormattedTimeFromSeconds(value.totalScreenTime);
            List<PieChartDataModel> data = value.pieData;
            if (value.hasLoaded) {
              return ListView(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  // Stack(
                  //   children: [
                  //     Container(
                  //       height: 300,
                  //     ),
                  //     Positioned.fill(
                  //       child: Align(
                  //         alignment: Alignment.center,
                  //         child: Container(
                  //           height: 200,
                  //           child: PieChart(
                  //             PieChartData(
                  //               borderData: FlBorderData(show: false),
                  //               pieTouchData: PieTouchData(
                  //                 touchCallback: (p0, p1) {},
                  //               ),
                  //               sections: [
                  //                 for (int i = 0; i < data.length; i++) ...[
                  //                   PieChartSectionData(

                  //                     color: getRandomColor(),
                  //                     value: data[i].timeSpent,
                  //                     title: data[i].timeSpent.toString(),
                  //                     radius: 80,
                  //                     titleStyle: TextStyle(
                  //                       fontSize: 10,
                  //                       fontWeight: FontWeight.bold,
                  //                       color: const Color(0xffffffff),
                  //                       shadows: [
                  //                         Shadow(
                  //                             color: Colors.black,
                  //                             blurRadius: 2)
                  //                       ],
                  //                     ),
                  //                     badgeWidget: ClipOval(
                  //                       child: Image.memory(
                  //                         data[i].bytes!,
                  //                         width: 30,
                  //                         height: 30,
                  //                       ),
                  //                     ),
                  //                     badgePositionPercentageOffset: 1.3,
                  //                   ),
                  //                 ]
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Container(
                    height: 300,
                    child: Stack(
                      children: [
                        SfCircularChart(
                            onChartTouchInteractionDown: (tapArgs) {
                              print("Chart Pressed");
                            },
                            title: ChartTitle(
                              text: "Today'S Screen Time \n ${timeSpend}",
                              textStyle: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            // legend: Legend(
                            //     textStyle: TextStyle(
                            //         color: Colors.amber,
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 12),
                            //     isVisible: true,
                            //     isResponsive: true,
                            //     overflowMode: LegendItemOverflowMode.scroll),
                            series: <CircularSeries>[
                              DoughnutSeries<DoughnutData, String>(
                                  pointColorMapper: (datum, index) =>
                                      getRandomColor(),

                                  // dataLabelSettings: DataLabelSettings(
                                  //     isVisible: true,
                                  //     overflowMode: OverflowMode.shift),

                                  enableTooltip: true,
                                  dataSource: value.graphData,
                                  xValueMapper: (DoughnutData data, _) =>
                                      data.x,
                                  yValueMapper: (DoughnutData data, _) =>
                                      data.y,

                                  // Radius of doughnut's inner circle

                                  innerRadius: '90%')
                            ]),
                      ],
                    ),
                  ),
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
                            value.cardData.length,
                            (index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.black,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      value.cardData[index].icon ?? Container(),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        value.cardData[index].title ?? "",
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
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

// chart_components: ^1.0.1