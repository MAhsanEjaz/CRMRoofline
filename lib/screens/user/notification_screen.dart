import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leadmanagementsystem/constants.dart';

import 'package:leadmanagementsystem/controllers/login_controller.dart';
import 'package:leadmanagementsystem/controllers/update_project_controller.dart';
import 'package:leadmanagementsystem/main.dart';

import 'package:leadmanagementsystem/projects/project_details_page.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  LoginController loginController = Get.put(LoginController());
  UpdateProjectController updateProjectController =
      Get.put(UpdateProjectController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loginController.getProjectUpdateNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GetBuilder(
          init: loginController,
          builder: (controller) {
            return (controller.notificationData.isEmpty &&
                    controller.emptyList == false)
                ? const Center(
                    child: CircularProgressIndicator(color: appColor))
                : controller.emptyList == true
                    ? const Center(
                        child: Text('Notification not found'),
                      )
                    : SafeArea(
                        child: Column(
                          children: [
                            for (var l in controller.notificationData)
                              ListTile(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) => const AlertDialog(
                                              content:
                                                  Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                CircularProgressIndicator()
                                              ])));

                                  await updateProjectController
                                      .getProjectById(l.projectId);
                                  Navigator.pop(context);

                                  Get.to(ProjectDetailsPage(
                                    project: updateProjectController
                                        .projectUpdateModel!.updateProjectData!,
                                    updateProject: l.comment!
                                            .contains('project assignment!')
                                        ? false
                                        : true,
                                    receverId: l.senderId!,
                                    token: l.semderFcmToken ?? '',
                                    senderName: l.senderName!,
                                    // projectId: l.projectId,
                                  ));

                                  print('receverId0--->${l.recieverId}');
                                },
                                leading: const CircleAvatar(
                                  backgroundImage: AssetImage('images/man.png'),
                                ),
                                title: Row(
                                  children: [
                                    Text(l.senderName.toString()),
                                    const Spacer(),
                                    Text(
                                      DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(l.createdDate
                                              .toString())), // Adjust the format as needed
                                    ),
                                  ],
                                ),
                                subtitle: Text(l.comment ?? ''),
                              )
                          ],
                        ),
                      );
          }),
    );
  }
}
