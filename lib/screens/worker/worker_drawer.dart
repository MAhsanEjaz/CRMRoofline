import 'package:crmroofline/constants.dart';
import 'package:crmroofline/projects/projects_list_page.dart';
import 'package:crmroofline/screens/login_screen.dart';
import 'package:crmroofline/screens/tasks_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class WorkerDrawer extends StatefulWidget {
  const WorkerDrawer({super.key});

  @override
  State<WorkerDrawer> createState() => _WorkerDrawerState();
}

class _WorkerDrawerState extends State<WorkerDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset('images/roofline.jpg'),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Get.back();
              },
              leading: const Icon(
                CupertinoIcons.home,
                color: appColor,
              ),
              title: const Text("Dashboard"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Get.to(TaskListPage(
                    getTasksNyIndividualUsers: false, userId: null));
                // Get.back();
              },
              leading: const Icon(
                CupertinoIcons.create,
                color: appColor,
              ),
              title: const Text("Tasks"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Get.to(ProjectListPage(
                  findProjectsByUsers: false,
                  userId: '',
                ));
              },
              leading: const Icon(
                CupertinoIcons.wand_rays,
                color: appColor,
              ),
              title: const Text("Project"),
            ),
          ),
          // Card(
          //   child: ListTile(
          //     onTap: () {
          //       Get.to(ProjectListPage());
          //     },
          //     leading: const Icon(
          //       CupertinoIcons.news,
          //       color: appColor,
          //     ),
          //     title: const Text("Reports"),
          //   ),
          // ),
          Card(
            child: ListTile(
              onTap: () {
                Get.off(const LoginScreen());
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.redAccent,
              ),
              title: const Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }
}
