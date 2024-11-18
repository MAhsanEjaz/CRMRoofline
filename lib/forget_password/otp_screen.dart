import 'package:crmroofline/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  String? email;

  OtpScreen({super.key, this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  LoginController loginController = Get.put(LoginController());

  String? otp;

  int currentIndex = 0;

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: loginController,
        builder: (cont) {
          return currentIndex == 1
              ? Scaffold(
                  appBar: AppBar(backgroundColor: appColor),
                  body: SafeArea(
                      child: Column(
                    children: [
                      CustomTextField(
                        controller: password,
                        hint: 'Password',
                      ),
                      CustomTextField(
                        controller: confirmPassword,
                        hint: 'Confirm Password',
                      ),
                      const SizedBox(height: 10),
                      cont.loadingData
                          ? const CircularProgressIndicator(color: appColor)
                          : CustomButton(
                              title: 'Save',
                              onTap: () {
                                if (validation()) {
                                  Map<String, dynamic> body = {
                                    'email': widget.email,
                                    'otpCode': otp,
                                    'newPassword': confirmPassword.text
                                  };

                                  print('body-->${body}');

                                  cont.confirmPasswordService(body);
                                }
                              })
                    ],
                  )),
                )
              : Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Your Otp',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: Pinput(
                          length: 6,
                          onCompleted: (val) {
                            if (val.toString() ==
                                cont.otpModelData!.otp.toString()) {
                              otp = val.toString();
                              currentIndex = 1;
                              setState(() {});
                            } else {
                              Get.snackbar('Failed', 'Invalid Otp',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
        });
  }

  bool validation() {
    if (password.text.isEmpty) {
      Get.snackbar('Error', 'Enter your password',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (confirmPassword.text.isEmpty) {
      Get.snackbar('Error', 'Enter your Confirm Password',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (password.text != confirmPassword.text) {
      Get.snackbar('Error', 'Password not matched',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else {
      return true;
    }
  }
}
