import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:leadmanagementsystem/api_urls.dart';
import 'package:leadmanagementsystem/main.dart';
import 'package:leadmanagementsystem/models/common_model.dart';
import 'package:leadmanagementsystem/models/users_list_model.dart';

class ManagerController extends GetxController {
  bool getManagersLoading = false;
  bool addManagersLoading = false;
  bool editManagersLoading = false;

  List<UserData> managersData = [];

  updateGetManagersLoading(bool value) {
    getManagersLoading = value;
    update();
  }

  updateAddManagersLoading(bool value) {
    addManagersLoading = value;
    update();
  }

  Future getManagers() async {
    updateGetManagersLoading(true);

    var responce = await getRequest.customGetRequest(
        apiPath: AppUrls.getUsersListByRoleName);
    updateGetManagersLoading(false);

    if (responce != null) {
      UsersListModel model = UsersListModel.fromJson(responce);

      managersData = model.data!;

      update();
    } else {
      updateGetManagersLoading(false);
    }
  }

  Future<void> addManager(Map body) async {
    updateAddManagersLoading(true);

    // await Future.delayed(Duration(seconds: 3));
    var responce =
        await postRequest.customPostRequest(url: AppUrls.addUser, body: body);

    if (responce != null) {
      updateAddManagersLoading(false);

      CommonResponse model = CommonResponse.fromJson(responce);

      if (model.status == true) {
        getManagers();

        Get.snackbar("Success", model.message);
      } else {
        Get.snackbar("Error", model.message);
      }

      // Get.back();

      log("addManager responce = $responce");
    } else {
      updateAddManagersLoading(false);
    }
  }

  Future editProjectManager(Map<String, dynamic> body) async {
    editManagersLoading = true;
    update();

    var res =
        await postRequest.customPostRequest(url: 'editManager', body: body);
    editManagersLoading = false;
    update();

    if (res['status'] == true) {
      update();

      await getManagers();

      Get.back();

      Get.snackbar('Success', 'Updated Successfully');

      return true;
    } else {
      return false;
    }
  }

  deleteFunction(String? userId) async {
    Map<String, dynamic> body = {'userId': userId};

    var res =
        await postRequest.customPostRequest(url: 'deleteUser', body: body);

    if (res['status'] != false) {
      await getManagers();

      Get.back();

      Get.snackbar('Success', 'User Deleted');

      return true;
    } else {
      return false;
    }
  }
}
