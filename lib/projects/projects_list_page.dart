import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:leadmanagementsystem/admin_module/add_project_page.dart';
import 'package:leadmanagementsystem/controllers/report_controller.dart';
import 'package:leadmanagementsystem/projects/project_details_page.dart';
import 'package:leadmanagementsystem/projects/projects_widget.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/controllers/add_project_controller.dart';
import 'package:leadmanagementsystem/models/projects_model.dart';
import 'package:leadmanagementsystem/widgets/custom_widgets.dart';

class ProjectListPage extends StatefulWidget {
  String? projectId;
  String userId;

  bool findProjectsByUsers;

  ProjectListPage(
      {this.projectId,
      required this.findProjectsByUsers,
      required this.userId});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  AddProjectController addProjectController = Get.find();
  ReportController reportController = Get.put(ReportController());

  getProjectList() {
    addProjectController.getProjects(context);
  }

  @override
  void initState() {
    super.initState();
    getProjectList();
  }

  @override
  Widget build(BuildContext context) {
    return widget.findProjectsByUsers == true
        ? GetBuilder(
            init: reportController,
            builder: (controller) {
              return Scaffold(
                appBar: mAppbar("Projects"),
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (reportController.projectsData.isEmpty)
                          const Center(
                              child: CircularProgressIndicator(color: appColor))
                        else
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Title',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Client Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Status',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                for (var l in controller.projectsData)
                                  TableRow(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => ProjectDetailsPage(
                                                project: l,
                                                updateProject: false,
                                                receverId: '',
                                                token: '',
                                                senderName: '',
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(l.title!),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(l.clientName!),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(l.status!),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),

                        // : Padding(
                        //     padding: const EdgeInsets.all(12.0),
                        //     child: ListView.builder(
                        //       physics: const NeverScrollableScrollPhysics(),
                        //       shrinkWrap: true,
                        //       itemCount: controller.projectsData.length,
                        //       itemBuilder: (context, index) {
                        //         final project =
                        //             controller.projectsData[index];
                        //         return Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: 8.0),
                        //           child: GestureDetector(
                        //             onTap: () {
                        //               // Handle project detail navigation
                        //               Get.to(() => ProjectDetailsPage(
                        //                     project: project,
                        //                     updateProject: false,
                        //                     receverId: '',
                        //                     token: '',
                        //                     senderName: '',
                        //                   ));
                        //             },
                        //             child: ProjectsWidget(project: project),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ),
                      ],
                    )
                        .animate()
                        .untint()
                        .scale()
                        .move(delay: 100.ms, duration: 1600.ms),
                  ),
                ),
              );
            })
        : Obx(() {
            return Scaffold(
              appBar: mAppbar("Projects"),
              body: addProjectController.projectData.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(color: appColor))
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView.builder(
                        itemCount: addProjectController.projectData.length,
                        itemBuilder: (context, index) {
                          final project =
                              addProjectController.projectData[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                // Handle project detail navigation
                                Get.to(() => ProjectDetailsPage(
                                      project: project,
                                      updateProject: false,
                                      receverId: '',
                                      token: '',
                                      senderName: '',
                                    ));
                              },
                              child: ProjectsWidget(project: project),
                            ),
                          );
                        },
                      ),
                    ),
              backgroundColor: Colors.grey[200],
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Get.to(AddProjectPage(
                      reciverId: '',
                      token: '',
                      senderName: '',
                    ));
                  },
                  backgroundColor: appColor,
                  label: const Text(
                    "Add Project",
                  )),
            );
          });
  }
}
