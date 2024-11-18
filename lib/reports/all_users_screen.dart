import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/controllers/report_controller.dart';
import 'package:leadmanagementsystem/screens/tasks_list_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  ReportController reportController = Get.put(ReportController());
  List<bool> isExpand = [];

  getFunctionality() async {
    await reportController.getAllUsersService();

    isExpand =
        List.generate(reportController.usersData.length, (index) => false);
  }

  @override
  void initState() {
    super.initState();
    getFunctionality();
  }

  List<ChartData> projectData = [];
  List<ChartData> taskData = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: reportController,
        builder: (controller) {
          if (controller.tasksNumberData != null &&
              controller.tasksNumberData!.taskNumber != null &&
              controller.tasksNumberData!.projectsNumber != null) {
            projectData = [
              ChartData(
                  'Projects',
                  controller.tasksNumberData?.projectsNumber?.toDouble() ?? 0.0,
                  const Color(0xFFff9a00)),
            ];
            taskData = [
              ChartData(
                  'Tasks',
                  controller.tasksNumberData?.taskNumber?.toDouble() ?? 0.0,
                  const Color(0xFFe76f51)),
            ];
          }

          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: const Text(
                'Reports',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              backgroundColor: appColor,
              elevation: 5,
              centerTitle: true,
            ),
            body: controller.usersData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (int i = 0;
                              i < controller.usersData.length;
                              i++) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 10,
                                shadowColor: Colors.black54,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  onTap: () async {
                                    await controller.getTasksNumberService(
                                        controller.usersData[i].sId.toString(),
                                        context);

                                    // Collapse all other items except the current one
                                    for (int j = 0; j < isExpand.length; j++) {
                                      if (i != j) {
                                        isExpand[j] = false;
                                      }
                                    }
                                    // Toggle the current item
                                    isExpand[i] = !isExpand[i];

                                    setState(() {});
                                  },
                                  trailing: Icon(
                                    isExpand[i] == true
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 30,
                                    color: appColor,
                                  ),
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor:
                                        Colors.blueAccent.withOpacity(0.2),
                                    child: const Icon(CupertinoIcons.person,
                                        color: Colors.blueAccent, size: 30),
                                  ),
                                  title: Text(
                                    controller.usersData[i].name.toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  subtitle: Text(
                                    controller.usersData[i].email.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              )
                                  .animate()
                                  .slideY(duration: 500.ms)
                                  .fadeIn(duration: 500.ms),
                            ),
                            if (isExpand[i])
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 12,
                                  shadowColor: Colors.black54,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: SfCircularChart(
                                                onChartTouchInteractionDown: (val){
                                                    controller.getProjectData(
                                                      context,
                                                      controller
                                                          .usersData[i].sId
                                                          .toString());
                                                },
                                                enableMultiSelection: true,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                legend: Legend(
                                                  isVisible: true,
                                                  position:
                                                      LegendPosition.bottom,
                                                  overflowMode:
                                                      LegendItemOverflowMode
                                                          .wrap,
                                                ),
                                                series: <CircularSeries>[
                                                  DoughnutSeries<ChartData,
                                                      String>(
                                                    enableTooltip: true,
                                                    explodeAll: true,
                                                    legendIconType:
                                                        LegendIconType
                                                            .seriesType,
                                                    explode: true,
                                                    explodeOffset: '1.5',
                                                    dataSource: projectData,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y,
                                                    pointColorMapper:
                                                        (ChartData data, _) =>
                                                            data.color,
                                                    dataLabelSettings:
                                                        const DataLabelSettings(
                                                            useSeriesColor:
                                                                true,
                                                            connectorLineSettings:
                                                                ConnectorLineSettings(
                                                              length: '33',
                                                              type:
                                                                  ConnectorType
                                                                      .curve,
                                                            ),
                                                            isVisible: true,
                                                            showCumulativeValues:
                                                                true,
                                                            showZeroValue:
                                                                true),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: SfCircularChart(
                                                onChartTouchInteractionDown: (v) {
                                                  Get.to(TaskListPage(
                                                      getTasksNyIndividualUsers:
                                                          true,
                                                      userId: controller
                                                          .usersData[i].sId
                                                          .toString()));
                                                },
                                                enableMultiSelection: true,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                legend: Legend(
                                                  isResponsive: true,
                                                  isVisible: true,
                                                  position:
                                                      LegendPosition.bottom,
                                                  overflowMode:
                                                      LegendItemOverflowMode
                                                          .wrap,
                                                ),
                                                series: <CircularSeries>[
                                                  DoughnutSeries<ChartData,
                                                      String>(
                                                    enableTooltip: true,
                                                    explodeAll: true,
                                                    legendIconType:
                                                        LegendIconType
                                                            .seriesType,
                                                    explode: true,
                                                    explodeOffset: '1.5',
                                                    dataSource: taskData,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y,
                                                    pointColorMapper:
                                                        (ChartData data, _) =>
                                                            data.color,
                                                    dataLabelSettings:
                                                        const DataLabelSettings(
                                                            useSeriesColor:
                                                                true,
                                                            connectorLineSettings:
                                                                ConnectorLineSettings(
                                                              length: '33',
                                                              type:
                                                                  ConnectorType
                                                                      .curve,
                                                            ),
                                                            isVisible: true,
                                                            showCumulativeValues:
                                                                true,
                                                            showZeroValue:
                                                                true),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // rowProjectsAndTask(
                                        //     'Projects',
                                        //     controller
                                        //         .tasksNumberData!.projectsNumber
                                        //         .toString(), () {
                                        //   controller.getProjectData(
                                        //       context,
                                        //       controller.usersData[i].sId
                                        //           .toString());
                                        // }),
                                        // const Divider(),
                                        // rowProjectsAndTask(
                                        //     'Tasks',
                                        //     controller
                                        //         .tasksNumberData!.taskNumber
                                        //         .toString(), () {
                                        //   Get.to(TaskListPage(
                                        //       getTasksNyIndividualUsers: true,
                                        //       userId: controller
                                        //           .usersData[i].sId
                                        //           .toString()));
                                        // }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ]
                        ],
                      ),
                    ),
                  ),
          );
        });
  }

  Widget rowProjectsAndTask(String? title, String? length, Function()? onTap) {
    return InkWell(
      onTap: (onTap),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15),
        child: Row(
          children: [
            SizedBox(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: appColor,
                elevation: 7,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    length!,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '$title',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
