import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/controllers/task_controller.dart';
import 'package:leadmanagementsystem/screens/task_details_page.dart';
import 'package:leadmanagementsystem/screens/worker/add_task_screen.dart';
import 'package:leadmanagementsystem/task_widget.dart';
import 'package:leadmanagementsystem/widgets/custom_text_field.dart';
import 'package:leadmanagementsystem/widgets/custom_widgets.dart';

class TaskListPage extends StatefulWidget {
  bool getTasksNyIndividualUsers;

  String? userId;

  TaskListPage({required this.getTasksNyIndividualUsers, this.userId});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final searchCont = TextEditingController();
  final taskCont = Get.put(TaskController());

  getTaskList() {
    if (widget.getTasksNyIndividualUsers == true) {
      taskCont.getTasks(widget.userId);
    } else {
      taskCont.getTasks(null);
    }
  }

  @override
  void initState() {
    super.initState();

    getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppbar("Tasks List"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: searchCont,
                hint: "Search Tasks",
                prefixIcon: Icons.search,
                onChanged: (p0) {
                  taskCont.searchTasks(p0);
                },
              ),
              GetBuilder<TaskController>(
                init: taskCont,
                builder: (controller) {
                  if (controller.loading.isTrue) {
                    return showSpinkit();
                  } else if (controller.filteredTasksList.isEmpty) {
                    return const Center(child: Text("No Tasks Found"));
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.filteredTasksList.length,
                    itemBuilder: (context, index) {
                      final task = controller.filteredTasksList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(TaskDetailPage(task: task));
                        },
                        child: TaskWidget(task: task),
                      );
                    },
                  )
                      .animate()
                      .untint()
                      .scale()
                      .move(delay: 300.ms, duration: 600.ms);
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddTaskScreen());
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
