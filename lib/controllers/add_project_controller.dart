import 'dart:convert';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:leadmanagementsystem/api_urls.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/main.dart';
import 'package:leadmanagementsystem/models/assign_project_model.dart';

import 'package:leadmanagementsystem/models/common_model.dart';
import 'package:leadmanagementsystem/models/new_project_model.dart';

import 'package:leadmanagementsystem/models/workscope_model.dart';
import 'package:leadmanagementsystem/projects/project_details_page.dart';

class AddProjectController extends GetxController {
  RxBool leadB = false.obs;
  RxBool contactedB = false.obs;
  RxBool pitchedB = false.obs;
  RxBool sentSampleB = false.obs;
  RxBool negotiatingB = false.obs;
  RxBool closeWonB = false.obs;
  RxBool closedLostB = false.obs;
  RxBool temporaryCloseB = false.obs;

  var loading = false.obs;

  bool loadingAssign = false;

  ProjectAssign? projectAssign;

  var workScope = <WorkScopeModel>[].obs;

  var projectData = <ProjectData>[].obs;

  var lead = <ProjectData>[].obs;
  var contacted = <ProjectData>[].obs;
  var pitched = <ProjectData>[].obs;
  var sentSample = <ProjectData>[].obs;
  var negotiating = <ProjectData>[].obs;
  var closeWon = <ProjectData>[].obs;
  var closedLost = <ProjectData>[].obs;
  var temporaryClose = <ProjectData>[].obs;

  final TextEditingController projectNameControl = TextEditingController();
  final TextEditingController clientNameControl = TextEditingController();
  final TextEditingController descriptionControl = TextEditingController();
  final TextEditingController projectManagerCont = TextEditingController();
  final TextEditingController timeDurationControl = TextEditingController();
  final TextEditingController workForceControl = TextEditingController();
  final TextEditingController budgetCont = TextEditingController();
  final TextEditingController tentativeCostCont = TextEditingController();
  final TextEditingController locationCont = TextEditingController();
  final TextEditingController notesCont = TextEditingController();
  final TextEditingController contactPersonPhoneCont = TextEditingController();
  final TextEditingController contactPersonNameCont = TextEditingController();

  final TextEditingController consultReControl = TextEditingController();
  final TextEditingController consultMeControl = TextEditingController();

  final TextEditingController consultNameControl = TextEditingController();
  final TextEditingController consultReNameControl = TextEditingController();
  final TextEditingController consultRePhoneControl = TextEditingController();
  final TextEditingController consultMeNameControl = TextEditingController();
  final TextEditingController consultMePhoneControl = TextEditingController();

  final TextEditingController contractorNameControl = TextEditingController();

  final TextEditingController contractorReControl = TextEditingController();
  final TextEditingController contractorReNameControl = TextEditingController();
  final TextEditingController contractorRePhoneControl =
      TextEditingController();
  final TextEditingController contractorMeControl = TextEditingController();
  final TextEditingController contractorMeNameControl = TextEditingController();
  final TextEditingController contractorMePhoneControl =
      TextEditingController();

  final TextEditingController precurementNameControl = TextEditingController();
  final TextEditingController precurementPhoneControl = TextEditingController();

  final TextEditingController accountNameControl = TextEditingController();
  final TextEditingController accountPhoneControl = TextEditingController();

  final TextEditingController projectOwnerNameControl = TextEditingController();
  final TextEditingController projectOwnerMeControl = TextEditingController();
  final TextEditingController projectOwnerPhoneControl =
      TextEditingController();
  final TextEditingController productPriceControl = TextEditingController();

  var priority = ''.obs;
  var company = ''.obs;
  var filePath = ''.obs;
  var fileName = ''.obs;

  Future<void> addFileFunction() async {
    final filePick = await FilePicker.platform.pickFiles();

    if (filePick != null && filePick.files.isNotEmpty) {
      final pickedFile = filePick.files.first;
      filePath.value = pickedFile.path ?? '';
      fileName.value = pickedFile.name;
    }
  }

  addWorkScope(WorkScopeModel workScopeModel) {
    workScope.add(workScopeModel);
  }

  Future<bool> getProjects(BuildContext? context) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      alertDialogueWithLoader(context);
    });

    String url = '';

    try {
      // if (loginStorage.getUserRole() == 'RSM (Regional Sales Manager)' ||
      //     loginStorage.getUserRole() == 'ASM (Area Sales Manager)' ||
      //     loginStorage.getUserRole() == 'New Recruits') {
      //   url =
      //       'getProjectByRole/${loginStorage.getUserRole()}/${loginStorage.getUserRegion()}';
      // } else {
      //   url = 'getProjectByRole/${loginStorage.getUserRole()}';
      // }

      url =
          'getProject?role=${loginStorage.getUserRole()}&company=${loginStorage.getUserCompany()}';

      print('url--->$url');

      final res = await getRequest.customGetRequest(apiPath: url);
      Navigator.pop(context!);

      if (res['status'] != false) {
        ProjectModel projectModel = ProjectModel.fromJson(res);
        // projectData.clear();
        projectData.value = projectModel.projectData ?? [];

        _categorizeProjects(projectData);

        return true;
      } else {
        Get.snackbar('Error', 'Failed to fetch projects');
        return false;
      }
    } catch (e) {
      // Get.snackbar('Error', 'Something went wrong. Please try again later.');
      return false;
    }
  }

  void _categorizeProjects(List<ProjectData> projects) {
    lead.clear();
    contacted.clear();
    pitched.clear();
    sentSample.clear();
    negotiating.clear();
    closeWon.clear();
    closedLost.clear();
    temporaryClose.clear();

    for (var project in projects) {
      switch (project.status) {
        case 'Lead':
          lead.add(project);
          break;
        case 'Contacted':
          contacted.add(project);
          break;
        case 'Pitched':
          pitched.add(project);
          break;
        case 'Sent Sample':
          sentSample.add(project);
          break;
        case 'Negotiating':
          negotiating.add(project);
          break;
        case 'Closed-Won':
          closeWon.add(project);
          break;
        case 'Closed-Lost':
          closedLost.add(project);
          break;
        case 'Temporary Close':
          temporaryClose.add(project);
          break;
        default:
          projectData.add(project);
      }
    }
  }

  Future<bool> addProjectFunction(BuildContext context) async {
    try {
      loading.value = true;

      final multipartRequest = http.MultipartRequest(
        'POST',
        Uri.parse('${apiBaseUrl}addProject'),
      );

      multipartRequest.fields.addAll({
        'userId': loginStorage.getUserId().toString(),
        'name': projectNameControl.text,
        'consultName': consultReControl.text,
        'consultPhone': consultMeControl.text,
        'ownerMe': projectOwnerMeControl.text,
        'ownerName': projectOwnerNameControl.text,
        'ownerContact': projectOwnerPhoneControl.text,
        'title': projectNameControl.text,
        'description': descriptionControl.text,
        'projectManager': projectManagerCont.text,
        'duration': timeDurationControl.text,
        'workForce': workForceControl.text,
        'budget': budgetCont.text,
        'tentativeCode': tentativeCostCont.text,
        'location': locationCont.text,
        'notes': notesCont.text,
        'status': 'Lead',
        'role': loginStorage.getUserRole().toString(),
        "company": company.value,
        'personName': contactPersonNameCont.text,
        'clientName': clientNameControl.text,
        'personContacts': contactPersonPhoneCont.text,
        'contractorName': contractorNameControl.text,
        'contractorREName': contractorReNameControl.text,
        'contractorREPhone': contractorRePhoneControl.text,
        'contractorMEName': contractorMeNameControl.text,
        'contractorMEPhone': contractorMePhoneControl.text,
        'consultantName': consultNameControl.text,
        'consultantREName': consultReNameControl.text,
        'consultantREPhone': consultRePhoneControl.text,
        'consultantMEName': consultMeNameControl.text,
        'consultantMEPhone': consultMePhoneControl.text,
        'precourmentName': precurementNameControl.text,
        'precourmentPhone': precurementPhoneControl.text,
        'accountOfficerName': accountNameControl.text,
        'accountOfficerPhone': accountPhoneControl.text,
        'priceValue': productPriceControl.text,
        'workScope':
            jsonEncode(workScope.map((element) => element.toJson()).toList()),
        'projectPriority': priority.value,
      });

      if (filePath.value.isNotEmpty) {
        multipartRequest.files
            .add(await http.MultipartFile.fromPath('file', filePath.value));
      }

      final streamedResponse = await multipartRequest.send();

      loading.value = false;
      var body = await streamedResponse.stream.bytesToString();
      log("responce = $body");
      if (streamedResponse.statusCode == 201) {
        print('statusCode--->${streamedResponse.statusCode}');
        Get.snackbar('Success', 'Project uploaded successfully');
        await getProjects(context);
        clearProjectContsData();

        return true;
      } else {
        Get.snackbar('Failed', 'Project could not be added');
        return false;
      }
    } catch (err) {
      loading.value = false;
      // Get.snackbar('Error', 'Something went wrong. Please try again later.');
      return false;
    }
  }

  // Method to clear all project-related data and reset controllers
  void clearProjectContsData() {
    // Clear TextEditingControllers
    projectNameControl.clear();
    descriptionControl.clear();
    projectManagerCont.clear();
    timeDurationControl.clear();
    workForceControl.clear();
    budgetCont.clear();
    tentativeCostCont.clear();
    locationCont.clear();
    notesCont.clear();
    contactPersonPhoneCont.clear();
    contactPersonNameCont.clear();

    // Clear Observable Strings
    priority.value = '';
    company.value = '';
    filePath.value = '';
    fileName.value = '';

    // Clear Observable Lists
    // projectData.clear();
    // lead.clear();
    // contacted.clear();
    // pitched.clear();
    // sentSample.clear();
    // negotiating.clear();
    // closeWon.clear();
    // closedLost.clear();

    // Reset the Boolean Observables
    // leadB.value = false;
    // contactedB.value = false;
    // pitchedB.value = false;
    // sentSampleB.value = false;
    // negotiatingB.value = false;
    // closeWonB.value = false;
    // closedLostB.value = false;

    // Reset loading state
    loading.value = false;
  }

  Future<bool> updateProjectStatus(Map body) async {
    log("body = $body");
    var responce = await postRequest.customPostRequest(
        url: AppUrls.updateProjectStatus, body: body);

    if (responce != null) {
      CommonResponse model = CommonResponse.fromJson(responce);

      if (model.status) {
        Get.snackbar("Success", "Project Status Updated");
        return true;
      } else {
        Get.snackbar("Error", model.message);
        return false;
      }
    } else {
      Get.snackbar("Error", "Some error occured");
      return false;
    }
  }

  sendAssignProject(BuildContext context, Map body) async {
    loadingAssign = true;

    update();

    var res =
        await postRequest.customPostRequest(url: 'assignProject', body: body);

    loadingAssign = false;

    update();

    if (res['status'] != false) {
      Get.snackbar('Success', 'Project assign successfully');

      return true;
    } else {
      return false;
    }
  }

  getAssignProjectFunction(String reciverId) async {
    var res = await getRequest.customGetRequest(
        apiPath: 'getAssignProject/$reciverId');

    if (res['status'] != false) {
      AssignProjectModel assignProjectModel = AssignProjectModel.fromJson(res);

      projectAssign = assignProjectModel.data;
      update();
    }
  }

  getRecieveProjectFunction(String projectId) async {
    loadingAssign = true;

    update();

    var res = await getRequest.customGetRequest(
        apiPath: 'getReciverProject/$projectId');

    loadingAssign = false;

    update();

    if (res['status'] != false) {
      AssignProjectModel assignProjectModel = AssignProjectModel.fromJson(res);

      projectAssign = assignProjectModel.data;
      update();
    } else {}
  }

  updateProjectFunction(String? existingFilePath, String? id) async {
    loadingAssign = true;
    update();

    // Create the multipart request
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('${apiBaseUrl}updateProject'));

    // Add fields to the request
    request.fields.addAll({
      'id': id!,
      'name': projectNameControl.text,
      'consultName': consultReControl.text,
      'consultPhone': consultMeControl.text,
      'ownerMe': projectOwnerMeControl.text,
      'ownerName': projectOwnerNameControl.text,
      'ownerContact': projectOwnerPhoneControl.text,
      'title': projectNameControl.text,
      'description': descriptionControl.text,
      'projectManager': projectManagerCont.text,
      'duration': timeDurationControl.text,
      'workForce': workForceControl.text,
      'budget': budgetCont.text,
      'tentativeCode': tentativeCostCont.text,
      'location': locationCont.text,
      'notes': notesCont.text,
      'status': 'Lead',
      'company': company.value,
      'personName': contactPersonNameCont.text,
      'clientName': clientNameControl.text,
      'personContacts': contactPersonPhoneCont.text,
      'contractorName': contractorNameControl.text,
      'contractorREName': contractorReNameControl.text,
      'contractorREPhone': contractorRePhoneControl.text,
      'contractorMEName': contractorMeNameControl.text,
      'contractorMEPhone': contractorMePhoneControl.text,
      'consultantName': consultNameControl.text,
      'consultantREName': consultReNameControl.text,
      'consultantREPhone': consultRePhoneControl.text,
      'consultantMEName': consultMeNameControl.text,
      'consultantMEPhone': consultMePhoneControl.text,
      'precourmentName': precurementNameControl.text,
      'precourmentPhone': precurementPhoneControl.text,
      'accountOfficerName': accountNameControl.text,
      'accountOfficerPhone': accountPhoneControl.text,
      'priceValue': productPriceControl.text,
      'workScope':
          jsonEncode(workScope.map((element) => element.toJson()).toList()),
      'projectPriority': priority.value,
    });

    // Handle file upload
    if (existingFilePath != null) {
      request.fields['file'] = existingFilePath;
    } else {
      request.files
          .add(await http.MultipartFile.fromPath('file', filePath.value));
    }

    // Send the request
    var response = await request.send();

    // Read the response body
    var responseBody = await response.stream.bytesToString();

    loadingAssign = false;
    update();

    // Print the response body for debugging
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: $responseBody');

    // Handle the response
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Project Updated');
    } else {
      Get.snackbar('Failed', 'Project Update Failed');
    }
  }
}
