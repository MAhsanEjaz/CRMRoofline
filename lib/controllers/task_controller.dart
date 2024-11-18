import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:leadmanagementsystem/api_urls.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/main.dart';
import 'package:leadmanagementsystem/models/tasks_model.dart';
import 'package:leadmanagementsystem/screens/tasks_list_page.dart';

class TaskController extends GetxController {
  RxBool loading = false.obs;

  List<TaskData> tasksList = [];
  RxList<TaskData> filteredTasksList = <TaskData>[].obs; // Filtered task list

  TextEditingController taskNameCont = TextEditingController();
  TextEditingController taskDescCont = TextEditingController();
  TextEditingController projectManagerCont = TextEditingController();
  TextEditingController timeDurationControl = TextEditingController();
  TextEditingController workForceControl = TextEditingController();
  TextEditingController locationControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();
  TextEditingController contactPersonCont = TextEditingController();
  TextEditingController contactPersonPhoneCont = TextEditingController();
  TextEditingController contactPersonCompanyCont = TextEditingController();
  TextEditingController endDateCont = TextEditingController();

  RxString priority = ''.obs;
  RxString status = ''.obs;
  RxString company = ''.obs;
  RxString filePath = ''.obs;
  RxString fileName = ''.obs;
  RxString estimatedTime = ''.obs;
  RxString taskDateTime = ''.obs;
  RxString project = ''.obs;

  Future<void> getTasks(String? userId) async {
    try {
      loading.value = true;

      var response = await getRequest.customGetRequest(
          apiPath: "getTaskById/${userId ?? loginStorage.getUserId()}");
      loading.value = false;

      if (response != null && response["status"] == true) {
        TasksModel model = TasksModel.fromJson(response);
        tasksList = model.data;
        filteredTasksList.value = tasksList; // Initially show all tasks

        update();
      } else {
        tasksList = [];
        filteredTasksList.clear();
        loading.value = false;
        update();
      }
    } catch (e) {
      tasksList = [];
      filteredTasksList.clear();
      loading.value = false;
      Get.snackbar("Error", e.toString());
      update();
    }
  }

  // Function to filter tasks based on search query
  void searchTasks(String query) {
    if (query.isEmpty) {
      filteredTasksList.value = tasksList; // Show all tasks if query is empty
    } else {
      final lowerCaseQuery = query.toLowerCase();
      filteredTasksList.value = tasksList.where((task) {
        return task.title.toLowerCase().contains(lowerCaseQuery) ||
            task.description.toLowerCase().contains(lowerCaseQuery) ||
            task.projectName!.toLowerCase().contains(lowerCaseQuery);
      }).toList();
      update();
    }
  }

  Future<void> addTask() async {
    // Check for required field validations
    if (taskNameCont.text.trim().isEmpty) {
      Get.snackbar('Error', 'Task title is required');
      return;
    }

    if (taskDescCont.text.trim().isEmpty) {
      Get.snackbar('Error', 'Task description is required');
      return;
    }

    if (project.value.isEmpty) {
      Get.snackbar('Error', 'Project selection is required');
      return;
    }

    if (priority.value.isEmpty) {
      Get.snackbar('Error', 'Priority selection is required');
      return;
    }

    if (estimatedTime.value.isEmpty) {
      Get.snackbar('Error', 'Estimated time is required');
      return;
    }

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('${apiBaseUrl}addTask'));

    loading.value = true;

    log('Loading: ${loading.value}');
    log("taskDateTime.value = ${taskDateTime.value}");

    if (taskDateTime.value == '') {
      taskDateTime.value = DateTime.now().toIso8601String();
    }

    // return;
    Map<String, String> body = {
      'userId': loginStorage.getUserId()!,
      'title': taskNameCont.text.trim(),
      'description': taskDescCont.text.trim(),
      'projectName': project.value,
      'priority': priority.value,
      'status': status.value,
      'date': taskDateTime.value,
      'contactName': contactPersonCont.text.trim(),
      'contactPhone': contactPersonPhoneCont.text.trim(),
      'contactCompany': contactPersonCompanyCont.text.trim(),
      'estimatedDate': estimatedTime.value,
      'projectManager': projectManagerCont.text.trim(),
      'workForce': workForceControl.text.trim(),
    };

    log("body in add task = $body");

    request.fields.addAll(body);

    log("filePath.value = ${filePath.value}");

    if (filePath.value.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('fileData', filePath.value));
    }

    http.StreamedResponse response = await request.send();

    loading.value = false;

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final responseData = json.decode(responseString);

      log('Response Code: ${response.statusCode}');
      log('Response Data: $responseData');

      Get.snackbar('Success', 'Task added successfully');
      clearAllFields();
      getTasks(null);
      Navigator.of(Get.context!).pop();
    } else {
      log('Response Code: ${response.statusCode}');
      log('Error: ${response.reasonPhrase}');

      Get.snackbar("Error ", "Please try again");
    }
  }

  Future<void> checkIn(Map body) async {
    log("body in checkIn = $body");
    try {
      loading.value = true;

      var response = await postRequest.customPostRequest(
          url: AppUrls.taskCheckIn, body: body);
      loading.value = false;

      if (response != null && response["status"] == true) {
        Get.snackbar('Success', 'Task checked in successfully');
        getTasks(null);
        Navigator.of(Get.context!).pop();
      } else {
        loading.value = false;
        Get.snackbar('Error', 'Please try again');
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> checkOut(Map body) async {
    log("body in checkOut = $body");
    try {
      loading.value = true;

      var response = await postRequest.customPostRequest(
          url: AppUrls.taskCheckOut, body: body);
      loading.value = false;

      if (response != null && response["status"] == true) {
        Get.snackbar('Success', 'Task checked out successfully');
        getTasks(null);
        Navigator.of(Get.context!).pop();
      } else {
        loading.value = false;
        Get.snackbar('Error', 'Please try again');
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  void clearAllFields() {
    // Clear all TextEditingController values
    taskNameCont.clear();
    taskDescCont.clear();
    projectManagerCont.clear();
    timeDurationControl.clear();
    workForceControl.clear();
    locationControl.clear();
    notesControl.clear();
    contactPersonCont.clear();
    contactPersonPhoneCont.clear();
    contactPersonCompanyCont.clear();
    endDateCont.clear();

    // Reset all RxString values
    priority.value = '';
    status.value = '';
    company.value = '';
    filePath.value = '';
    fileName.value = '';
    estimatedTime.value = '';
  }
}
