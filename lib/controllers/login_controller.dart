import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:leadmanagementsystem/admin_module/admin_home_page.dart';
import 'package:leadmanagementsystem/api_urls.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/forget_password/otp_screen.dart';
import 'package:leadmanagementsystem/main.dart';
import 'package:leadmanagementsystem/models/assignment_user_model.dart';
import 'package:leadmanagementsystem/models/login_model.dart';
import 'package:leadmanagementsystem/models/notification_model.dart';
import 'package:leadmanagementsystem/models/otp_model.dart';
import 'package:leadmanagementsystem/models/profile_model.dart';
import 'package:leadmanagementsystem/models/user_region_model.dart';
import 'package:leadmanagementsystem/screens/login_screen.dart';
import 'package:leadmanagementsystem/services/custom_get_request.dart';
import 'package:leadmanagementsystem/services/custom_post_request.dart';

class LoginController extends GetxController {
  var loginModel = LoginModel().obs;

  bool otpLoading = false;

  OtpModel? otpModelData;

  ProfileData? profileData;

  List<AssignmentData> assign = [];
  List<UserRegionData> userRegionData = [];
  List<NotificationData> notificationData = [];

  bool emptyList = false;

  var loading = false.obs;

  bool loadingData = false;

  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  Future<bool> loginFunction(BuildContext context) async {
    Map<String, dynamic> body = {
      "email": emailCont.text.trim(),
      "password": passCont.text.trim(),
      "fcmToken": fcmToken,
    };

    log('body---->$body');
    loading.value = true;

    try {
      var res =
          await postRequest.customPostRequest(url: AppUrls.login, body: body);

      loading.value = false;

      loginModel.value = LoginModel.fromJson(res);

      final data = loginModel.value;

      log("login responce = $res");

      if (res['status'] != false) {
        Get.to(const AdminHomePage());

        if (loginModel.value.userData != null) {
          loginStorage.setUserId(id: loginModel.value.userData!.sId!);
          loginStorage.setUserEmail(email: loginModel.value.userData!.email!);
          loginStorage.setUserRole(role: loginModel.value.userData!.role!);
          loginStorage.setUserName(fName: loginModel.value.userData!.name!);
          loginStorage.setUserToken(
              token: loginModel.value.userData!.fcmToken!);
          loginStorage.setUserCompany(
              company: loginModel.value.userData!.company!);
          if (loginModel.value.userData != null &&
              loginModel.value.userData!.region != null) {
            loginStorage.setRegion(region: loginModel.value.userData!.region!);
          }
          return true;
        } else {
          return false;
        }
      } else {
        Get.snackbar("Failed", res['message']);
        return false;
      }
    } catch (e) {
      loading.value = false;
      // Get.snackbar("Error", "Something went wrong. Please try again later.");
      return false;
    }
  }

  passwordChangeFunction(Map body) async {
    loadingData = true;
    update();

    var res =
        await postRequest.customPostRequest(url: 'changePassword', body: body);

    loadingData = false;
    update();

    if (res['status'] == true) {
      Get.snackbar('Success', 'Password changed successfully');
      Get.offAll(const LoginScreen());

      return true;
    } else {
      Get.snackbar('Failed', res['message']);

      return false;
    }
  }

  getAllUsers() async {
    var res = await getRequest.customGetRequest(
        apiPath: 'getAllUser/${loginStorage.getUserId()}');

    if (res['status'] != false) {
      AssingmentUserModel assingmentUserModel =
          AssingmentUserModel.fromJson(res);
      update();

      assign = assingmentUserModel.data!;
    } else {
      return false;
    }
  }

  bool loaderData = false;

  getRegionData() async {
    var res = await getRequest.customGetRequest(
        apiPath: 'getUsersByRole/${loginStorage.getUserRole()}');

    print('role--->${loginStorage.getUserRole()}');

    if (res['status'] != false) {
      UserRegionModel userRegionModel = UserRegionModel.fromJson(res);
      update();

      userRegionData = userRegionModel.data!;
    }
  }

  sendProjectUpdateNotification(String? reciverId, String? projectId,
      String? comment, String token, String? recieverName) async {
    loaderData = true;

    update();

    Map<String, dynamic> body = {
      'senderId': loginStorage.getUserId(),
      'recieverName': recieverName,
      'senderName': loginStorage.getUserName(),
      'recieverId': reciverId,
      'projectId': projectId,
      'comment': comment,
      'semderFcmToken': loginStorage.getUserToken(),
      'fcmToken': token,
    };

    print('body--->$body');

    var res = await postRequest.customPostRequest(
        url: 'sendNotification', body: body);

    loaderData = false;

    update();

    if (res['status'] != false) {
      Get.snackbar('Success', res['message']);

      return true;
    } else {
      return false;
    }
  }

  getProjectUpdateNotification() async {
    var res = await getRequest.customGetRequest(
        apiPath: 'getNotificationsByReciever/${loginStorage.getUserId()}');

    if (res['status'] == true && (res['data'] as List).isEmpty) {
      emptyList = true;
      print('emptyList--->$emptyList');
      update();
    } else {
      emptyList = false ;
      print('emptyList--->$emptyList');
      update();
      NotificationModel notificationModel = NotificationModel.fromJson(res);
      notificationData = notificationModel.data ?? [];
    }
  }

  forgetPasswordService(String email) async {
    Map<String, dynamic> body = {'email': email};

    otpLoading = true;

    update();
    var res = await CustomPostRequest()
        .customPostRequest(url: 'forget-password', body: body);

    OtpModel otpModel = OtpModel.fromJson(res);

    otpModelData = otpModel;

    otpLoading = false;

    update();
    if (res['status'] != false) {
      Get.snackbar('Success', res['message'],
          backgroundColor: CupertinoColors.white);

      Get.to(OtpScreen(email: email));

      return true;
    } else {
      Get.snackbar('Success', res['message'],
          backgroundColor: CupertinoColors.white);
      return false;
    }
  }

  confirmPasswordService(Map body) async {
    loadingData = true;
    update();

    var res = await CustomPostRequest()
        .customPostRequest(url: 'reset-password', body: body);

    loadingData = false;
    update();

    if (res['status'] != false) {
      Get.snackbar('Success', res['message'],
          backgroundColor: CupertinoColors.white,
          colorText: CupertinoColors.black);

      Get.off(const LoginScreen());

      return true;
    } else {
      Get.snackbar('Error', 'Failed');

      return false;
    }
  }

  getProfileService() async {
    var res = await CustomGetRequest().customGetRequest(
        apiPath: 'getUserProfile/${loginStorage.getUserId()}');

    if (res['status'] != false) {
      ProfileModel profileModel = ProfileModel.fromJson(res);

      profileData = profileModel.data;
      update();
    }
  }
}
