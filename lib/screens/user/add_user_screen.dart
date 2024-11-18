import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:leadmanagementsystem/admin_module/add_project_page.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/controllers/manager_controller.dart';
import 'package:leadmanagementsystem/main.dart';
import 'package:leadmanagementsystem/widgets/custom_button.dart';
import 'package:leadmanagementsystem/widgets/custom_text_field.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController controller = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController manualRegionController = TextEditingController();

  bool isRole = false;

  List<String> roles = [
    'Group Director-CEO',
    'Company Director',
    'Country Head',
    'RSM (Regional Sales Manager)',
    'ASM (Area Sales Manager)',
    'New Recruits'
  ];

  List<String> companies = ['Roofline', 'Radiant', 'Mamz'];

  List<String> area = ['Centre', 'North', 'South'];

  String? selectRole;
  String? selectCompany;
  String? selectAres;

  bool roleB = false;
  bool compB = false;
  bool regionB = false;
  bool areaB = false;

  ManagerController managerController = Get.put(ManagerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: appColor),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SafeArea(
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: nameController,
                              hint: 'Name',
                              prefixIcon: Icons.person,
                            ),
                            CustomTextField(
                              controller: emailController,
                              hint: 'Email',
                              inputType: TextInputType.emailAddress,
                              prefixIcon: Icons.mail,
                            ),
                            CustomTextField(
                              controller: passwordController,
                              hint: 'Password',
                              prefixIcon: Icons.lock,
                            ),
                            CustomTextField(
                              controller: phoneController,
                              hint: 'Phone',
                              inputType: TextInputType.number,
                              prefixIcon: Icons.phone,
                            ),
                            CustomExpansion(
                              title: selectRole ?? 'Select Role',
                              onTap: () {
                                roleB = !roleB;
                                setState(() {});
                              },
                              openData: roleB,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: [
                                      for (var l in roles)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8),
                                          child: InkWell(
                                            onTap: () {
                                              roleB = !roleB;

                                              selectRole = l;

                                              if (selectRole ==
                                                  'Group Director-CEO') {
                                                isRole = true;
                                                print('role-->$isRole');
                                              } else {
                                                isRole = false;
                                                print('role-->$isRole');
                                              }
                                              setState(() {});
                                            },
                                            child: Chip(
                                                label: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(l),
                                            )),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (selectRole != null &&
                                selectRole != 'Group Director-CEO')
                              CustomExpansion(
                                title: selectCompany ?? 'Select Company',
                                onTap: () {
                                  compB = !compB;
                                  setState(() {});
                                },
                                openData: compB,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      children: [
                                        for (var l in companies)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 8),
                                            child: InkWell(
                                              onTap: () {
                                                selectCompany = l;
                                                compB = !compB;

                                                setState(() {});
                                              },
                                              child: Chip(
                                                  label: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(l),
                                              )),
                                            ),
                                          )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            if (selectRole != null &&
                                selectCompany != null &&
                                selectRole != 'Group Director-CEO' &&
                                selectRole != 'Company Director')
                              CustomExpansion(
                                title: selectAres ?? 'Select Region',
                                onTap: () {
                                  regionB = !regionB;
                                  setState(() {});
                                },
                                openData: regionB,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      children: [
                                        for (var l in area)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 8),
                                            child: InkWell(
                                              onTap: () {
                                                selectAres = l;
                                                regionB = !regionB;

                                                manualRegionController.clear();

                                                setState(() {});
                                              },
                                              child: Chip(
                                                  label: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(l),
                                              )),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            if (selectRole == 'ASM (Area Sales Manager)' &&
                                    selectAres != null ||
                                selectRole == 'New Recruits' &&
                                    selectAres != null)
                              CustomExpansion(
                                title: 'Area',
                                openData: areaB,
                                onTap: () {
                                  areaB = !areaB;
                                  setState(() {});
                                },
                                children: [
                                  CustomTextField(
                                    onChanged: (val) {
                                      manualRegionController.text = val;
                                      setState(() {});
                                    },
                                    controller: manualRegionController,
                                    hint: 'Area',
                                  )
                                ],
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GetBuilder(
                  init: managerController,
                  builder: (controller) {
                    return controller.addManagersLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            title: 'Save',
                            onTap: selectRole == 'Group Director-CEO' ||
                                    selectRole == 'Company Director'
                                ? () {
                                    Map<String, dynamic> body = {
                                      'name': nameController.text.trim(),
                                      'email': emailController.text.trim(),
                                      'password':
                                          passwordController.text.trim(),
                                      'role': selectRole,
                                      'phone': phoneController.text.trim(),
                                      'fcmToken': fcmToken,
                                    };

                                    managerController.addManager(body);
                                  }
                                : selectCompany == null ||
                                        selectAres == null ||
                                        selectRole == null
                                    ? null
                                    : () {
                                        Map<String, dynamic> body = {
                                          'name': nameController.text.trim(),
                                          'email': emailController.text.trim(),
                                          'password':
                                              passwordController.text.trim(),
                                          'phone': phoneController.text,
                                          'role': selectRole,
                                          'company': selectCompany ?? '',
                                          'region': selectAres ?? '',
                                          'area':
                                              manualRegionController.text ?? '',
                                          'fcmToken': fcmToken
                                        };

                                        managerController.addManager(body);
                                      });
                  })
            ],
          ),
        ));
  }
}
