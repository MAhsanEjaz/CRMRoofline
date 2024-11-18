import 'dart:io';

import 'package:crmroofline/constants.dart';
import 'package:crmroofline/controllers/add_project_controller.dart';
import 'package:crmroofline/services/custom_get_request.dart';
import 'package:crmroofline/size_config.dart';
import 'package:crmroofline/storage/login_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firbase_messaging_service.dart';
import 'screens/splash_screen.dart';
import 'services/custom_post_request.dart';

late AddProjectController addProjectController;

String? fcmToken;

late CustomGetRequest getRequest;
late CustomPostRequest postRequest;

late LoginStorage loginStorage;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  addProjectController = Get.put(AddProjectController(), permanent: true);

  getRequest = CustomGetRequest();
  postRequest = CustomPostRequest();
  await Hive.initFlutter();
  await Hive.openBox('login_hive');
  loginStorage = LoginStorage();

  FirebaseMessagingService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(.9)),
          child: child!,
        );
      },
      theme: ThemeData(
          primaryColor: appColor,
          backgroundColor: Colors.grey[100],
          useMaterial3: false,
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.black))),
      title: 'Project Management',
      home: const SplashScreen(),
      // home: AddProjectPage(),
    );
  }
}

//! task statuses
//!Not Started, In Progress, Completed, On Hold, Cancelled, Pending Review, Blocked
//Pending Review is extra i think.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
