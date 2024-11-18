import 'package:crmroofline/constants.dart';
import 'package:crmroofline/widgets/custom_text_field.dart';
import 'package:crmroofline/widgets/history_widget.dart';
import 'package:crmroofline/widgets/home_time_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';



class WorkerHistoryPage extends StatefulWidget {
  const WorkerHistoryPage({super.key});

  @override
  State<WorkerHistoryPage> createState() => _WorkerHistoryPageState();
}

class _WorkerHistoryPageState extends State<WorkerHistoryPage> {
  int index = 0;

  TextEditingController searchControl = TextEditingController();

  List<Map<String, String>> offersData = [
    {
      'date': '10/05/2020',
      'id': 'task#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
    {
      'date': '10/05/2020',
      'id': 'task#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
    {
      'date': '10/05/2020',
      'id': 'task#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
    {
      'date': '10/05/2020',
      'id': 'task#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        actions: <Widget>[
          PopupMenuButton(
            iconColor: Colors.black,
            itemBuilder: (BuildContext context) => <PopupMenuItem>[
              const PopupMenuItem(
                value: 1,
                child: Text('First Item'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Second Item'),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text('Third Item'),
              ),
            ],
          ),
        ],
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Jobs',
            style: TextStyle(color: blackColor),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Container(
            decoration: const BoxDecoration(),
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      HistoryWidget(
                        txt: 'active',
                        color: index == 0 ? true : false,
                        onTap: () {
                          index = 0;
                          setState(() {});
                        },
                      ),
                      HistoryWidget(
                        txt: 'open',
                        color: index == 1 ? true : false,
                        onTap: () {
                          index = 1;
                          setState(() {});
                        },
                      ),
                      HistoryWidget(
                        txt: 'history',
                        color: index == 2 ? true : false,
                        onTap: () {
                          index = 2;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  CustomTextField(
                    prefixIcon: CupertinoIcons.search,
                    hint: 'Search Jobs',
                    controller: searchControl,
                    onChanged: (val) {
                      searchControl.text = val;
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Row(
                    children: [
                      const Text(
                        '3 jobs actives',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Row(
                          children: [
                            SizedBox(width: 8),
                            Text(
                              'In Progress',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_drop_down,
                              color: whiteColor,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                for (var l in offersData)
                  HomeTimeWidget(
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                l['date'].toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              // SizedBox(
                              //     width:
                              //     MediaQuery.sizeOf(context).width /
                              //         3.5),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0, vertical: .5),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time_filled,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            l['days'].toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(width: 4)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 5),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.blue.shade100),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: .5),
                                  child: Text(
                                    l['status'].toString(),
                                    style:
                                        TextStyle(color: Colors.blue.shade500),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            l['id'].toString(),
                            style: const TextStyle(
                                color: Colors.black38, fontSize: 12),
                          ),
                          Text(
                            l['title'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 15,
                              ),
                              const SizedBox(width: 5),
                              RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: l['location'],
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 13))
                              ]))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 22.0),
                                    child: Container(
                                      height: 22,
                                      width: 22,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?cs=srgb&dl=pexels-soldiervip-1391498.jpg&fm=jpg'),
                                              fit: BoxFit.fill),
                                          color: Colors.blue,
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                  Positioned(
                                    left: 11,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        height: 22,
                                        width: 22,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRe5DWJI8MqOw8ggi_0tdxdWqqpPHLT_WQZtZwomHftOw&s'),
                                                fit: BoxFit.fill),
                                            color: Colors.black,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 22,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        height: 22,
                                        width: 22,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://img.freepik.com/free-photo/young-beautiful-girl-posing-black-leather-jacket-park_1153-8104.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1716681600&semt=ais_user'),
                                                fit: BoxFit.fill),
                                            color: Colors.pink,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 8),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('3 people',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.5)),
                                  Text('Kello, Json, Peter',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11)),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          // SizedBox(
                          //   // width: MediaQuery.sizeOf(context).width / 1.5,
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           child: ElevatedButton(
                          //               onPressed: () {},
                          //               style: ElevatedButton.styleFrom(
                          //                   backgroundColor: Colors.white,
                          //                   shape: RoundedRectangleBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(10),
                          //                       side: const BorderSide(
                          //                           color: appColor)),
                          //                   surfaceTintColor: Colors.white),
                          //               child: Text(
                          //                 'Detail'.toUpperCase(),
                          //                 style:
                          //                     const TextStyle(color: appColor),
                          //               ))),
                          //       const SizedBox(width: 20),
                          //       Expanded(
                          //           child: ElevatedButton(
                          //               onPressed: () {},
                          //               style: ElevatedButton.styleFrom(
                          //                   backgroundColor: appColor,
                          //                   shape: RoundedRectangleBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(10),
                          //                       side: const BorderSide(
                          //                           color: appColor)),
                          //                   surfaceTintColor: Colors.white),
                          //               child: Text(
                          //                 'Accept'.toUpperCase(),
                          //                 style: const TextStyle(
                          //                     color: Colors.white),
                          //               ))),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        backgroundColor: Colors.green,
        minX: 0,
        maxX: 3,
        minY: 0,
        maxY: 6,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              // showTitles: true,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                );
                Widget text;
                switch (value.toInt()) {
                  case 0:
                    text = const Text('MAR', style: style);
                    break;
                  case 1:
                    text = const Text('JUN', style: style);
                    break;
                  case 2:
                    text = const Text('SEP', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: text,
                );
              },
              // reservedSize: 32,
              // margin: 8,
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Colors.black26,
              strokeWidth: .2,
            );
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: Colors.black26,
              strokeWidth: .2,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: const Color(0xff37434d),
            width: 1,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 3),
              const FlSpot(1, 1),
              const FlSpot(2, 4),
              const FlSpot(3, 3),
            ],
            isCurved: true,
            color: const Color(0xff23b6e6),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: true,
            ),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xff23b6e6).withOpacity(0.3),
            ),
          ),
        ],
        lineTouchData: const LineTouchData(
          touchTooltipData: LineTouchTooltipData(
              // tooltipBgColor: Colors.blueAccent,
              ),
          // touchCallback: (LineTouchResponse touchResponse) {},
          handleBuiltInTouches: true,
        ),
      ),
    );
  }
}

class BarChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        backgroundColor: appColor,
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // tooltipBgColor: Colors.blueAccent,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.toString(),
                TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        // titlesData: FlTitlesData(
        //   show: true,
        //   rightTitles: AxisTitles(
        //     sideTitles: SideTitles(showTitles: false),
        //   ),
        //   topTitles: AxisTitles(
        //     sideTitles: SideTitles(showTitles: false),
        //   ),
        //   bottomTitles: AxisTitles(
        //     sideTitles: SideTitles(
        //       showTitles: true,
        //       getTitlesWidget: (double value, TitleMeta meta) {
        //         const style = TextStyle(
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 14,
        //         );
        //         switch (value.toInt()) {
        //           case 0:
        //             return Text('Mn', style: style);
        //           case 1:
        //             return Text('Te', style: style);
        //           case 2:
        //             return Text('Wd', style: style);
        //           case 3:
        //             return Text('Tu', style: style);
        //           case 4:
        //             return Text('Fr', style: style);
        //           case 5:
        //             return Text('St', style: style);
        //           case 6:
        //             return Text('Sn', style: style);
        //           default:
        //             return Text('', style: style);
        //         }
        //       },
        //       reservedSize: 28,
        //     ),
        //   ),
        //   leftTitles: AxisTitles(
        //     sideTitles: SideTitles(
        //       showTitles: true,
        //       getTitlesWidget: (double value, TitleMeta meta) {
        //         const style = TextStyle(
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 14,
        //         );
        //         if (value == 0) {
        //           return Text('', style: style);
        //         } else if (value == 5) {
        //           return Text('5K', style: style);
        //         } else if (value == 10) {
        //           return Text('10K', style: style);
        //         } else {
        //           return Container();
        //         }
        //       },
        //       reservedSize: 28,
        //       interval: 1,
        //     ),
        //   ),
        // ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: _buildBarGroups(),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(
          toY: 5,
          color: Colors.cyan,
          width: 16,
        ),
        BarChartRodData(
          toY: 3,
          color: Colors.pink,
          width: 16,
        ),
      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(
          toY: 8,
          color: Colors.cyan,
          width: 16,
        ),
        BarChartRodData(
          toY: 6,
          color: Colors.pink,
          width: 16,
        ),
      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(
          toY: 6,
          color: Colors.cyan,
          width: 16,
        ),
        BarChartRodData(
          toY: 4,
          color: Colors.pink,
          width: 16,
        ),
      ]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(
          toY: 7,
          color: Colors.cyan,
          width: 16,
        ),
        BarChartRodData(
          toY: 2,
          color: Colors.pink,
          width: 16,
        ),
      ]),
      BarChartGroupData(x: 4, barRods: [
        BarChartRodData(
          toY: 10,
          color: Colors.cyan,
          width: 16,
        ),
        BarChartRodData(
          toY: 8,
          color: Colors.pink,
          width: 16,
        ),
      ]),
      BarChartGroupData(x: 5, barRods: [
        BarChartRodData(
          toY: 6,
          color: Colors.cyan,
          width: 16,
        ),
        BarChartRodData(
          toY: 4,
          color: Colors.pink,
          width: 16,
        ),
      ]),
      BarChartGroupData(x: 6, barRods: [
        BarChartRodData(
          toY: 4,
          color: Colors.cyan,
          width: 16,
        ),
        BarChartRodData(
          toY: 3,
          color: Colors.pink,
          width: 16,
        ),
      ]),
    ];
  }
}
