import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leadmanagementsystem/admin_module/managers/managers_page.dart';
import 'package:leadmanagementsystem/main.dart';
import 'package:leadmanagementsystem/projects/projects_list_page.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/reports/all_users_screen.dart';
import 'package:leadmanagementsystem/reports/reports_main_screen.dart';
import 'package:leadmanagementsystem/screens/data_sheets_screen.dart';
import 'package:leadmanagementsystem/screens/login_screen.dart';
import 'package:leadmanagementsystem/screens/tasks_list_page.dart';
import 'package:leadmanagementsystem/screens/user/add_user_screen.dart';
import 'package:leadmanagementsystem/screens/user/profile_screen.dart';
import 'package:leadmanagementsystem/screens/worker/change_password_screen.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
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
                Icons.dashboard, // Changed Icon
                color: appColor,
              ),
              title: const Text("Dashboard"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Get.to(ProfileScreen());
              },
              leading: const Icon(
                Icons.person, // Changed Icon
                color: appColor,
              ),
              title: const Text("Profile"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Get.back();
                Get.to(ProjectListPage(
                  findProjectsByUsers: false,
                  userId: '',
                ));
              },
              leading: const Icon(
                Icons.work_outline, // Changed Icon
                color: appColor,
              ),
              title: const Text("Project"),
            ),
          ),
          if (loginStorage.getUserRole() == 'Group Director-CEO')
            Card(
              child: ListTile(
                onTap: () {
                  Get.back();
                  Get.to(const ManagersPage());
                },
                leading: const Icon(
                  Icons.group, // Changed Icon
                  color: appColor,
                ),
                title: const Text("View Users"),
              ),
            ),
          if (loginStorage.getUserRole() == 'Group Director-CEO' ||
              loginStorage.getUserRole() == 'Company Director' ||
              loginStorage.getUserRole() == 'Country Head')
            Card(
              child: ListTile(
                onTap: () {
                  Get.back();
                  Get.to(const AddUserScreen());
                },
                leading: const Icon(
                  Icons.person_add_alt_1, // Changed Icon
                  color: appColor,
                ),
                title: const Text("Add User"),
              ),
            )
          else
            SizedBox.shrink(),
          Card(
            child: ListTile(
              onTap: () {
                Get.back();
                Get.to(const ChangePasswordScreen());
              },
              leading: const Icon(
                Icons.lock_outline, // Changed Icon
                color: appColor,
              ),
              title: const Text("Change Password"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Get.to(TaskListPage(
                  getTasksNyIndividualUsers: false,
                ));
              },
              leading: const Icon(
                Icons.task, // Changed Icon
                color: appColor,
              ),
              title: const Text("Tasks"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Get.to(const DataSheetScreens());
              },
              leading: const Icon(
                Icons.report, // Changed Icon
                color: appColor,
              ),
              title: const Text("Data Sheets"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                // Get.snackbar("Coming Soon", "Under Development");

                // Get.to(const AllUsersScreen());
                Get.to(const ReportsMainScreen());
              },
              leading: const Icon(
                Icons.report, // Changed Icon
                color: appColor,
              ),
              title: const Text("Reports"),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () async {
                loginStorage.clearStorageData();

                Get.offAll(const LoginScreen());
              },
              leading: const Icon(
                Icons.exit_to_app, // Changed Icon
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
