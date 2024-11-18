import 'dart:developer';
import 'dart:io';

import 'package:crmroofline/constants.dart';
import 'package:crmroofline/controllers/add_project_controller.dart';
import 'package:crmroofline/controllers/task_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool expand = false;

  List<String> estimationTime = ['1 hr', '2 hr', '4 hr', '6 hr', '8 hr'];
  List<String> priorityList = ['Low', 'Medium', 'High'];
  List<String> statusList = ['Not Started', 'In Progress', 'Completed'];

  int? currentIndex;
  String? filePath;

  uploadDocument() async {
    final filePicker =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (filePicker != null) {
      filePicker.files.forEach((element) {
        taskCont.filePath.value = element.path.toString();
        taskCont.fileName.value = element.name.toString();
        setState(() {});
      });
    }
  }

  final taskCont = Get.put(TaskController());
  final projCont = Get.find<AddProjectController>();

  bool isTaskNameError = false;
  bool isDescriptionError = false;
  bool isDateTimeError = false;
  bool isEstimatedTimeError = false;
  bool isProjectError = false;
  bool isPriorityError = false;
  bool isStatusError = false;

  String taskNameErrorString = '';
  String descriptionErrorString = '';
  String dateTimeErrorString = '';
  String estimatedTimeErrorString = '';
  String projectErrorString = '';
  String priorityErrorString = '';
  String statusErrorString = '';

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: mAppbar("Add Task"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hint: 'Task',
                  controller: taskCont.taskNameCont,
                  prefixIcon: CupertinoIcons.text_quote,
                  prefixColor: Theme.of(context).primaryColor,
                ),
                if (isTaskNameError) formErrorText(error: taskNameErrorString),
                CustomTextField(
                  hint: 'Description',
                  controller: taskCont.taskDescCont,
                  maxLines: 3,
                  prefixIcon: CupertinoIcons.text_quote,
                  prefixColor: Theme.of(context).primaryColor,
                ),
                if (isDescriptionError)
                  formErrorText(error: descriptionErrorString),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimePicker(
                    dateHintText: "Select Date",
                    fieldHintText: "Selct Datetime",
                    timeHintText: "Select Time",
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        focusColor: Theme.of(context).primaryColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey))),
                    initialValue: "Select DateTime",
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                    icon: const Icon(CupertinoIcons.calendar),
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    onChanged: (val) {
                      log('object-->$val');

                      if (val != '') {
                        taskCont.taskDateTime.value = val;
                      }
                    },
                    validator: (val) {
                      log(val!);
                      return null;
                    },
                    onSaved: (val) => log(val!),
                  ),
                ),
                if (isDateTimeError) formErrorText(error: dateTimeErrorString),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionPanelList(
                    dividerColor: appColor,
                    materialGapSize: 0,
                    expandedHeaderPadding: const EdgeInsets.all(0),
                    elevation: expand ? 1 : 0,
                    expansionCallback: (int, od) {
                      expand = od;
                      setState(() {});
                    },
                    children: [
                      ExpansionPanel(
                          backgroundColor: Colors.grey.shade200,
                          canTapOnHeader: true,
                          isExpanded: expand,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Estimated Time',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ));
                          },
                          body: Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              children: [
                                for (int i = 0; i < estimationTime.length; i++)
                                  EstimationTimeWidget(
                                    txt: estimationTime[i],
                                    color: currentIndex == i ? true : false,
                                    onTap: () {
                                      taskCont.estimatedTime.value =
                                          estimationTime[i].toString();

                                      log('estimnate--->${taskCont.estimatedTime.value}');
                                      currentIndex = i;
                                      setState(() {});
                                    },
                                  )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                if (isEstimatedTimeError)
                  formErrorText(error: estimatedTimeErrorString),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(.2),
                        border: Border.all(color: Colors.black38)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5),
                      child: DropdownButton(
                          underline: const SizedBox.shrink(),
                          isExpanded: true,
                          hint: Text(taskCont.project.value == ''
                              ? "Select Project"
                              : taskCont.project.value),
                          // ignore: invalid_use_of_protected_member
                          items: projCont.projectData.value.map((e) {
                            return DropdownMenuItem(
                                value: e.name, child: Text(e.name.toString()));
                          }).toList(),
                          onChanged: (e) {
                            taskCont.project.value = e!;
                          }),
                    ),
                  ),
                ),
                if (isProjectError) formErrorText(error: projectErrorString),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Select Priority',
                    ),
                    items: priorityList.map((String priority) {
                      return DropdownMenuItem<String>(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        taskCont.priority.value = newValue!;

                        log('priority-->${taskCont.priority.value}');
                      });
                    },
                    icon: const Icon(CupertinoIcons.exclamationmark_circle,
                        color: Colors.red), // Same color as in TaskDetailPage
                  ),
                ),
                if (isPriorityError) formErrorText(error: priorityErrorString),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Select Status',
                    ),
                    items: statusList.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        taskCont.status.value = newValue!;
                      });
                    },
                    icon: const Icon(CupertinoIcons.flag,
                        color: Colors.green), // Same color as in TaskDetailPage
                  ),
                ),
                if (isStatusError) formErrorText(error: statusErrorString),
                CustomTextField(
                  hint: 'Contact Person Name',
                  controller: taskCont.contactPersonCont,
                  prefixIcon: CupertinoIcons.person,
                  prefixColor: Theme.of(context).primaryColor,
                ),
                CustomTextField(
                  hint: 'Contact Person Phone',
                  controller: taskCont.contactPersonPhoneCont,
                  prefixIcon: CupertinoIcons.phone,
                  inputType: TextInputType.phone,
                  prefixColor: Theme.of(context).primaryColor,
                ),
                CustomTextField(
                  hint: 'Contact Person Company',
                  controller: taskCont.contactPersonCompanyCont,
                  prefixIcon: CupertinoIcons.building_2_fill,
                  prefixColor: Theme.of(context).primaryColor,
                ),
                GestureDetector(
                  onTap: uploadDocument,
                  child: Container(
                    height: 100,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.cloud_upload_fill,
                            color:
                                Colors.blue), // Same color as in TaskDetailPage
                        const SizedBox(height: 5),
                        Text(
                          taskCont.fileName.value == ''
                              ? 'Upload Document'
                              : taskCont.fileName.value,
                          style: TextStyle(
                            color: taskCont.filePath.value == ''
                                ? Colors.black
                                : appColor, // Use the app's primary color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                CustomButton(
                  onTap: () {
                    if (isFormValid()) {
                      taskCont.addTask();
                    }
                  },
                  title: 'Save ',
                  child: taskCont.loading.value == true
                      ? customCircleLoader()
                      : null,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      );
    });
  }

  bool isFormValid() {
    bool isValid = true;
    resetErrors();

    if (taskCont.taskNameCont.text.isEmpty) {
      taskNameErrorString = 'Please enter the task name';
      isTaskNameError = true;
      isValid = false;
    }
    if (taskCont.taskDescCont.text.isEmpty) {
      descriptionErrorString = 'Please enter a description';
      isDescriptionError = true;
      isValid = false;
    }

    if (taskCont.taskDateTime.value.isEmpty) {
      dateTimeErrorString = 'Please select task date time';
      isDateTimeError = true;
      isValid = false;
    }

    if (taskCont.estimatedTime.value.isEmpty) {
      estimatedTimeErrorString = 'Please select an estimated time';
      isEstimatedTimeError = true;
      isValid = false;
    }
    if (taskCont.project.value.isEmpty) {
      projectErrorString = 'Please select a project';
      isProjectError = true;
      isValid = false;
    }
    if (taskCont.priority.value.isEmpty) {
      priorityErrorString = 'Please select a priority';
      isPriorityError = true;
      isValid = false;
    }
    if (taskCont.status.value.isEmpty) {
      statusErrorString = 'Please select a status';
      isStatusError = true;
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  void resetErrors() {
    isTaskNameError = false;
    isDescriptionError = false;
    isDateTimeError = false;
    isEstimatedTimeError = false;
    isProjectError = false;
    isPriorityError = false;
    isStatusError = false;

    taskNameErrorString = '';
    descriptionErrorString = '';
    dateTimeErrorString = '';
    estimatedTimeErrorString = '';
    projectErrorString = '';
    priorityErrorString = '';
    statusErrorString = '';
  }
}

class EstimationTimeWidget extends StatefulWidget {
  bool color;
  String? txt;
  Function()? onTap;

  EstimationTimeWidget({super.key, this.onTap, required this.color, this.txt});

  @override
  State<EstimationTimeWidget> createState() => _EstimationTimeWidgetState();
}

class _EstimationTimeWidgetState extends State<EstimationTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (widget.onTap),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          elevation: widget.color == true ? 10 : 0,
          color: widget.color == true ? appColor : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              widget.txt!,
              style:
                  TextStyle(color: widget.color ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
