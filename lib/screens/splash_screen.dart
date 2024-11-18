import 'dart:async';

import 'package:crmroofline/admin_module/admin_home_page.dart';
import 'package:crmroofline/main.dart';
import 'package:crmroofline/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splashHandler() {
    if (loginStorage.getUserId() != null) {
      Timer(const Duration(seconds: 2), () {
        Get.off(const AdminHomePage());
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        Get.off(const LoginScreen());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    splashHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'images/roofline.jpg',
              height: 130,
              width: 130,
            ),
          ),
        ));
  }
}
