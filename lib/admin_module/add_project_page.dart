import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/controllers/add_project_controller.dart';
import 'package:leadmanagementsystem/controllers/login_controller.dart';
import 'package:leadmanagementsystem/main.dart';
import 'package:leadmanagementsystem/models/new_project_model.dart';
import 'package:leadmanagementsystem/models/workscope_model.dart';
import 'package:leadmanagementsystem/screens/login_screen.dart';
import 'package:leadmanagementsystem/widgets/custom_button.dart';
import 'package:leadmanagementsystem/widgets/custom_text_field.dart';
import 'package:leadmanagementsystem/widgets/custom_widgets.dart';

class AddProjectPage extends StatefulWidget {
  ProjectData? projectData;

  String reciverId;
  String senderName;
  String token;

  AddProjectPage(
      {this.projectData,
      required this.reciverId,
      required this.token,
      required this.senderName});

  @override
  _AddProjectPageState createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  AddProjectController addProjectController = Get.find();

  LoginController loginController = Get.put(LoginController());

  bool isProjectNameError = false;
  bool isDescriptionError = false;
  bool isProjectManagerError = false;
  bool isTimeDurationError = false;
  bool isWorkForceError = false;
  bool isBudgetError = false;
  bool isTentativeCostError = false;
  bool isLocationError = false;
  bool isContactPersonNameError = false;
  bool isContactPersonPhoneError = false;
  bool isPriorityError = false;
  bool isCompanyError = false;
  bool isClientError = false;

  String projectNameErrorString = '';
  String clientNameErrorString = '';
  String descriptionErrorString = '';
  String projectManagerErrorString = '';
  String timeDurationErrorString = '';
  String workForceErrorString = '';
  String budgetErrorString = '';
  String tentativeCostErrorString = '';
  String locationErrorString = '';
  String contactPersonNameErrorString = '';
  String contactPersonPhoneErrorString = '';
  String priorityErrorString = '';
  String companyErrorString = '';

  bool projectDepartment = false;
  bool projectConsultant = false;
  bool precurementOfficer = false;
  bool accountOfficer = false;

  bool mamzB = false;
  bool productB = false;

  List<bool> mamzBool = [];
  List<bool> productsBool = [];
  List<bool> rooflineBool = [];

  List<String> mamzProducts = [
    'Mamz Prime Coat',
    'Mamz Tack Coat',
    'Mamz ChipSeal RS 2',
    'Mamz CrackCure',
    'Mamz AquaShield 50P',
    'Mamz AquaShield RBE',
    'Mamz Ready Cold Asphalt',
    'Mamz Slurry Seal',
    'Mamz BituLasti',
  ];

  List<String> products = [
    // Admixtures
    'ConAd WP 1000 / Powder Admixture',
    'ConAd WP 682 / Liquid Admixture',
    'ConAd SP 551',
    'ConAd SP 587',
    'ConAd SP 687',
    'ConAd ASP 888',

    // Concrete Repairing
    'ConBond SBR',
    'ConBond EP',
    'ConRep FC',
    'ConRep FR Mortar',
    'ConRep FMC',
    'ConRep EP 21',
    'ConPlug 180',

    // Waterproofing
    'ConFlex 511',
    'ConFlex 515',
    'ConSeal CR',
    'ConFlex ACR',
    'ConFlex PU',
    'ConGuard S',
    'ConFix SW 300',
    'ConFix PVC WaterStop',
    'ConFlex PU 600',

    // Grouts
    'ConGrout GP',
    'ConGrout HS',
    'ConGrout EP GP',
    'ConGrout EP HS',

    // Flooring
    'ConFloor HardTop',
    'ConFloor C SLC P',
    'ConFloor EP Screed',
    'ConCote EP 401',
    'ConGuard EP 401',
    'ConCote WB 103',
    'ConCote EP HB',
    'ConFloor EP SL',
    'ConFloor PU SL',

    // ConTile Products
    'ConTile Bond',
    'ConTile Grout',
    'ConTile Grout EP',
  ];

  List<String> rooflineProducts = [
    "PLASTOGRIP RL-500",
    "PLASTOGRIP RL-400",
    "PLASTOGRIP RL-300",
    "PLASTOGRIP RLA-400",
    "PLASTOGRIP RLA-300",
    "PLASTOGRIP RLG-400",
    "PLASTOGRIP RLG-300",
    "ELASTOGRIP RL-150",
    "ELASTOGRIP RL-200",
    "ELASTOGRIP RL-300",
    "ELASTOGRIP RL-300",
    "ELASTOGRIP RL-400"
  ];

  List<String> region = ['Centre', 'North', 'South'];

  String? selectRegion;

  getUpdateProjectData() {
    if (widget.projectData != null) {
      // Set data from projectData to the controller
      addProjectController.projectNameControl.text = widget.projectData!.name!;
      addProjectController.clientNameControl.text =
          widget.projectData!.clientName!;
      addProjectController.descriptionControl.text =
          widget.projectData!.description!;
      addProjectController.projectManagerCont.text =
          widget.projectData!.projectManager!;
      addProjectController.timeDurationControl.text =
          widget.projectData!.duration!;
      addProjectController.workForceControl.text =
          widget.projectData!.workForce!;
      addProjectController.budgetCont.text = widget.projectData!.budget!;
      addProjectController.tentativeCostCont.text =
          widget.projectData!.tentativeCode!;
      addProjectController.locationCont.text = widget.projectData!.location!;
      addProjectController.notesCont.text = widget.projectData!.notes!;
      addProjectController.contactPersonPhoneCont.text =
          widget.projectData!.personContacts!;
      addProjectController.contactPersonNameCont.text =
          widget.projectData!.personName!;
      addProjectController.consultReControl.text =
          widget.projectData!.consultantREName!;
      addProjectController.consultMeControl.text =
          widget.projectData!.consultantMEName!;
      addProjectController.consultNameControl.text =
          widget.projectData!.consultantName!;
      addProjectController.consultReNameControl.text =
          widget.projectData!.consultantREName!;
      addProjectController.consultRePhoneControl.text =
          widget.projectData!.consultantREPhone!;
      addProjectController.consultMeNameControl.text =
          widget.projectData!.consultantMEName!;
      addProjectController.consultMePhoneControl.text =
          widget.projectData!.consultantMEPhone!;
      addProjectController.contractorNameControl.text =
          widget.projectData!.contractorName!;
      addProjectController.contractorReControl.text =
          widget.projectData!.contractorREName!;
      addProjectController.contractorReNameControl.text =
          widget.projectData!.contractorREName!;
      addProjectController.contractorRePhoneControl.text =
          widget.projectData!.contractorREPhone!;
      addProjectController.contractorMeNameControl.text =
          widget.projectData!.contractorMEName!;
      addProjectController.contractorMePhoneControl.text =
          widget.projectData!.contractorMEPhone!;
      addProjectController.precurementNameControl.text =
          widget.projectData!.precourmentName!;
      addProjectController.precurementPhoneControl.text =
          widget.projectData!.precourmentPhone!;
      addProjectController.accountNameControl.text =
          widget.projectData!.accountOfficerName!;
      addProjectController.accountPhoneControl.text =
          widget.projectData!.accountOfficerPhone!;
      addProjectController.projectOwnerNameControl.text =
          widget.projectData!.ownerName!;
      addProjectController.projectOwnerMeControl.text =
          widget.projectData!.ownerMe!;
      addProjectController.projectOwnerPhoneControl.text =
          widget.projectData!.ownerContact!;
      addProjectController.productPriceControl.text =
          widget.projectData!.priceValue!;

      // Handle work scope selections
      widget.projectData!.workScope!.forEach((element) {
        if (mamzProducts.contains(element.name)) {
          int index = mamzProducts.indexOf(element.name!);
          if (index >= 0 && index < mamzBool.length) {
            mamzBool[index] = true;
          }
        } else if (products.contains(element.name)) {
          int index = products.indexOf(element.name!);
          if (index >= 0 && index < productsBool.length) {
            productsBool[index] = true;
          }
        } else if (rooflineProducts.contains(element.name)) {
          int index = rooflineProducts.indexOf(element.name!);
          if (index >= 0 && index < rooflineBool.length) {
            rooflineBool[index] = true;
          }
        }
      });

      addProjectController.priority.value =
          widget.projectData!.projectPriority!;
    } else {
      // Clear all fields if projectData is null
      addProjectController.projectNameControl.clear();
      addProjectController.clientNameControl.clear();
      addProjectController.descriptionControl.clear();
      addProjectController.projectManagerCont.clear();
      addProjectController.timeDurationControl.clear();
      addProjectController.workForceControl.clear();
      addProjectController.budgetCont.clear();
      addProjectController.tentativeCostCont.clear();
      addProjectController.locationCont.clear();
      addProjectController.notesCont.clear();
      addProjectController.contactPersonPhoneCont.clear();
      addProjectController.contactPersonNameCont.clear();
      addProjectController.consultReControl.clear();
      addProjectController.consultMeControl.clear();
      addProjectController.consultNameControl.clear();
      addProjectController.consultReNameControl.clear();
      addProjectController.consultRePhoneControl.clear();
      addProjectController.consultMeNameControl.clear();
      addProjectController.consultMePhoneControl.clear();
      addProjectController.contractorNameControl.clear();
      addProjectController.contractorReControl.clear();
      addProjectController.contractorReNameControl.clear();
      addProjectController.contractorRePhoneControl.clear();
      addProjectController.contractorMeNameControl.clear();
      addProjectController.contractorMePhoneControl.clear();
      addProjectController.precurementNameControl.clear();
      addProjectController.precurementPhoneControl.clear();
      addProjectController.accountNameControl.clear();
      addProjectController.accountPhoneControl.clear();
      addProjectController.projectOwnerNameControl.clear();
      addProjectController.projectOwnerMeControl.clear();
      addProjectController.projectOwnerPhoneControl.clear();
      addProjectController.productPriceControl.clear();

      // Reset all work scope selections
      mamzBool = List.generate(mamzProducts.length, (index) => false);
      productsBool = List.generate(products.length, (index) => false);
      rooflineBool = List.generate(rooflineProducts.length, (index) => false);

      addProjectController.priority.value = ''; // Clear priority
    }

    setState(() {}); // Update the UI
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mamzBool = List.generate(mamzProducts.length, (index) => false);
    productsBool = List.generate(products.length, (index) => false);
    rooflineBool = List.generate(rooflineProducts.length, (index) => false);

    getUpdateProjectData();
  }

  bool selectWorkScope = false;

  bool workScopeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: mAppbar(
            widget.projectData != null ? "Update Project" : "Add Project"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              CustomTextField(
                controller: addProjectController.projectNameControl,
                prefixIcon: CupertinoIcons.textbox,
                hint: 'Project Name',
                prefixColor: Colors.blue,
              ),
              if (isProjectNameError)
                formErrorText(error: projectNameErrorString),
              CustomTextField(
                controller: addProjectController.clientNameControl,
                prefixIcon: CupertinoIcons.person,
                hint: 'Client Name',
                prefixColor: Colors.blue,
              ),
              if (isProjectNameError)
                formErrorText(error: clientNameErrorString),
              CustomExpansion(
                openData: projectConsultant,
                title: 'Consultant',
                onTap: () {
                  projectConsultant = !projectConsultant;
                  setState(() {});
                },
                children: [
                  CustomTextField(
                    controller: addProjectController.consultNameControl,
                    onChanged: (val) {
                      addProjectController.consultNameControl.text = val;

                      setState(() {});
                    },
                    hint: 'Consultant Name',
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                      child: Text(
                        'Consultant RE: (Resident Engineer)',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: addProjectController.consultReNameControl,
                    hint: 'Name',
                  ),
                  CustomTextField(
                    controller: addProjectController.consultRePhoneControl,
                    hint: 'Phone',
                    inputType: TextInputType.number,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                      child: Text(
                        'Consultant ME: (Material Engineer)',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: addProjectController.consultMeNameControl,
                    hint: 'Name',
                  ),
                  CustomTextField(
                    controller: addProjectController.consultMePhoneControl,
                    hint: 'Phone',
                    inputType: TextInputType.number,
                  ),
                ],
              ),
              CustomExpansion(
                openData: projectDepartment,
                title: 'Contractor',
                onTap: () {
                  projectDepartment = !projectDepartment;
                  setState(() {});
                },
                children: [
                  CustomTextField(
                    controller: addProjectController.contractorNameControl,
                    onChanged: (val) {
                      addProjectController.contractorNameControl.text = val;
                      setState(() {});
                    },
                    hint: 'Contractor Name',
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                      child: Text(
                        'Contractor PM: (Project Manager)',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: addProjectController.contractorReNameControl,
                    hint: 'Name',
                  ),
                  CustomTextField(
                    controller: addProjectController.contractorRePhoneControl,
                    hint: 'Phone',
                    inputType: TextInputType.number,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                      child: Text(
                        'Contractor ME: (Material Engineer)',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: addProjectController.contractorMeNameControl,
                    hint: 'Name',
                  ),
                  CustomTextField(
                    controller: addProjectController.contractorMePhoneControl,
                    hint: 'Phone',
                    inputType: TextInputType.number,
                  ),
                ],
              ),
              CustomExpansion(
                openData: precurementOfficer,
                title: 'Procurement Officer',
                onTap: () {
                  precurementOfficer = !precurementOfficer;
                  setState(() {});
                },
                children: [
                  CustomTextField(
                    controller: addProjectController.precurementNameControl,
                    hint: 'Name',
                  ),
                  CustomTextField(
                    controller: addProjectController.precurementPhoneControl,
                    hint: 'Phone',
                    inputType: TextInputType.number,
                  ),
                ],
              ),
              CustomExpansion(
                openData: accountOfficer,
                title: 'Account Officer',
                onTap: () {
                  accountOfficer = !accountOfficer;
                  setState(() {});
                },
                children: [
                  CustomTextField(
                    controller: addProjectController.accountNameControl,
                    hint: 'Name',
                  ),
                  CustomTextField(
                    controller: addProjectController.accountPhoneControl,
                    hint: 'Phone',
                    inputType: TextInputType.number,
                  ),
                ],
              ),
              CustomExpansion(
                title: 'Work Scope',
                onTap: () {
                  productB = !productB;
                  setState(() {});
                },
                openData: productB,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                      child: Text(
                        'Mamz Products',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19),
                      ),
                    ),
                  ),
                  const Divider(),
                  GetBuilder(
                      init: addProjectController,
                      builder: (controller) {
                        return Wrap(
                          children: [
                            for (int i = 0; i < mamzProducts.length; i++)
                              ProductsCard(
                                  selected: mamzBool[i],
                                  onTap: () {
                                    mamzBool[i] = !mamzBool[i];

                                    if (mamzBool[i] == true) {
                                      controller.addWorkScope(WorkScopeModel(
                                          name: mamzProducts[i]));
                                    } else {
                                      controller.workScope.removeWhere(
                                          (workScope) =>
                                              workScope.name ==
                                              mamzProducts[i]);
                                    }
                                    print(
                                        'products--->${json.encode(addProjectController.workScope)}');

                                    setState(() {});
                                  },
                                  title: mamzProducts[i]),
                          ],
                        );
                      }),
                  const Divider(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                      child: Text(
                        'Radiant Products',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19),
                      ),
                    ),
                  ),
                  const Divider(),
                  Wrap(
                    children: [
                      for (int i = 0; i < products.length; i++)
                        ProductsCard(
                            selected: productsBool[i],
                            onTap: () {
                              productsBool[i] = !productsBool[i];

                              if (productsBool[i] == true) {
                                addProjectController.addWorkScope(
                                    WorkScopeModel(name: products[i]));
                              } else {
                                addProjectController.workScope.removeWhere(
                                    (workScope) =>
                                        workScope.name == products[i]);
                              }
                              print(
                                  'products--->${json.encode(addProjectController.workScope)}');
                              setState(() {});
                            },
                            title: products[i]),
                    ],
                  ),
                  const Divider(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                      child: Text(
                        'Roofline Products',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19),
                      ),
                    ),
                  ),
                  const Divider(),
                  Wrap(
                    children: [
                      for (int i = 0; i < rooflineProducts.length; i++)
                        ProductsCard(
                            selected: rooflineBool[i],
                            onTap: () {
                              rooflineBool[i] = !rooflineBool[i];

                              if (rooflineBool[i] == true) {
                                addProjectController.addWorkScope(
                                    WorkScopeModel(name: rooflineProducts[i]));
                              } else {
                                addProjectController.workScope.removeWhere(
                                    (workScope) =>
                                        workScope.name == rooflineProducts[i]);
                              }
                              print(
                                  'products--->${json.encode(addProjectController.workScope)}');
                              setState(() {});
                            },
                            title: rooflineProducts[i]),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 2),
              if (addProjectController.workScope.isEmpty &&
                  selectWorkScope == true)
                formErrorText(error: 'Please select workscope'),
              const SizedBox(height: 2),
              CustomTextField(
                controller: addProjectController.productPriceControl,
                prefixIcon: Icons.attach_money_outlined,
                hint: 'Product Price',
                inputType: TextInputType.number,
                prefixColor: Colors.blue,
              ),
              if (loginStorage.getUserRole() == 'ASM (Area Sales Manager)' ||
                  loginStorage.getUserRole() == 'New Recruits')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                      isExpanded: true,
                      hint: Text(selectRegion ?? 'Select Region'),
                      items: region.map((e) {
                        return DropdownMenuItem(
                            value: e,
                            onTap: () {
                              selectRegion = e;
                              setState(() {});
                            },
                            child: Text(e));
                      }).toList(),
                      onChanged: (_) {}),
                ),
              CustomTextField(
                controller: addProjectController.descriptionControl,
                prefixIcon: CupertinoIcons.bubble_left,
                hint: 'Description',
                maxLines: 3,
                prefixColor: Colors.blue,
              ),
              if (isDescriptionError)
                formErrorText(error: descriptionErrorString),
              CustomTextField(
                controller: addProjectController.projectManagerCont,
                prefixIcon: CupertinoIcons.person,
                hint: 'Project Manager / Architect',
                prefixColor: Colors.blueAccent,
              ),
              if (isProjectManagerError)
                formErrorText(error: projectManagerErrorString),
              CustomTextField(
                controller: addProjectController.timeDurationControl,
                prefixIcon: CupertinoIcons.time_solid,
                hint: 'Time Duration',
                prefixColor: Colors.blue,
              ),
              if (isTimeDurationError)
                formErrorText(error: timeDurationErrorString),
              CustomTextField(
                controller: addProjectController.workForceControl,
                prefixIcon: CupertinoIcons.person_2_fill,
                hint: 'Work Force',
                inputType: TextInputType.number,
                prefixColor: Colors.teal,
              ),
              if (isWorkForceError) formErrorText(error: workForceErrorString),
              CustomTextField(
                controller: addProjectController.budgetCont,
                prefixIcon: CupertinoIcons.money_dollar_circle_fill,
                inputType: TextInputType.number,
                hint: 'Budget',
                prefixColor: Colors.green,
              ),
              if (isBudgetError) formErrorText(error: budgetErrorString),
              CustomTextField(
                controller: addProjectController.tentativeCostCont,
                prefixIcon: CupertinoIcons.money_dollar_circle,
                inputType: TextInputType.number,
                hint: 'Tentative Cost',
                prefixColor: Colors.red,
              ),
              if (isTentativeCostError)
                formErrorText(error: tentativeCostErrorString),
              CustomTextField(
                controller: addProjectController.locationCont,
                prefixIcon: CupertinoIcons.location_solid,
                hint: 'Location',
                prefixColor: Colors.orange,
              ),
              if (isLocationError) formErrorText(error: locationErrorString),
              CustomTextField(
                controller: addProjectController.notesCont,
                prefixIcon: CupertinoIcons.pencil,
                hint: 'Notes',
                prefixColor: Colors.black54,
              ),
              CustomTextField(
                controller: addProjectController.contactPersonNameCont,
                prefixIcon: CupertinoIcons.person_solid,
                hint: 'Contact Person Name',
                prefixColor: Colors.blueAccent,
              ),
              if (isContactPersonNameError)
                formErrorText(error: contactPersonNameErrorString),
              CustomTextField(
                controller: addProjectController.contactPersonPhoneCont,
                prefixIcon: CupertinoIcons.phone_fill,
                hint: 'Person Contact Phone',
                inputType: TextInputType.phone,
                prefixColor: Colors.green,
              ),
              if (isContactPersonPhoneError)
                formErrorText(error: contactPersonPhoneErrorString),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: addProjectController.priority.value.isEmpty
                      ? null
                      : addProjectController.priority.value,
                  hint: const Text("Select Project Priority"),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      addProjectController.priority.value = newValue!;
                    });
                  },
                  items: <String>['Low', 'Medium', 'High']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              if (isPriorityError) formErrorText(error: priorityErrorString),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: addProjectController.company.value.isEmpty
                      ? null
                      : addProjectController.company.value,
                  hint: const Text("Select Company"),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      addProjectController.company.value = newValue!;
                    });
                  },
                  items: <String>['Radiant', 'Roof line', 'Mamz']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              // if (isCompanyError) formErrorText(error: companyErrorString),
              InkWell(
                onTap: addProjectController.addFileFunction,
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
                      const Icon(CupertinoIcons.cloud_upload_fill),
                      if (widget.projectData != null &&
                          widget.projectData!.filePath != null)
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.projectData!.filePath != null
                                  ? widget.projectData!.filePath!
                                      .split('-')
                                      .last
                                  : 'No file path available',
                              // Fallback text in case filePath is null
                              textAlign: TextAlign.center,
                            ))
                      else
                        Text(addProjectController.fileName.value.isEmpty
                            ? 'Add File'
                            : addProjectController.fileName.toString()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              widget.projectData != null
                  ? GetBuilder(
                      init: addProjectController,
                      builder: (contr) {
                        return CustomButton(
                            title: 'Update Project',
                            onTap: () async {
                              await contr.updateProjectFunction(
                                  widget.projectData!.filePath,
                                  widget.projectData!.sId);

                              loginController.sendProjectUpdateNotification(
                                  widget.reciverId,
                                  widget.projectData!.sId,
                                  'You project ${widget.projectData!.name} is updated',
                                  widget.token,
                                  widget.senderName);
                            },
                            child: contr.loadingAssign
                                ? customCircleLoader()
                                : null);
                      })
                  : CustomButton(
                      onTap: () {
                        if (validation()) {
                          if (isFormValid() ||
                              addProjectController.workScope.isEmpty) {
                            selectWorkScope = true;
                            setState(() {});

                            if (addProjectController.workScope.isNotEmpty) {
                              addProjectController.addProjectFunction(context);
                              addProjectController.workScope.clear();
                              selectWorkScope = false;
                              setState(() {});
                            }
                          }
                        }
                      },
                      title: 'Save ',
                      child: addProjectController.loading.value == true
                          ? customCircleLoader()
                          : null,
                    ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
    });
  }

  bool isFormValid() {
    bool isValid = true;
    resetErrors();

    if (addProjectController.projectNameControl.text.isEmpty) {
      projectNameErrorString = 'Please enter the project name';
      isProjectNameError = true;
      isValid = false;
    }
    if (addProjectController.clientNameControl.text.isEmpty) {
      clientNameErrorString = 'Please enter the client name';
      isClientError = true;
      isValid = false;
    }
    // if (addProjectController.descriptionControl.text.isEmpty) {
    //   descriptionErrorString = 'Please enter a description';
    //   isDescriptionError = true;
    //   isValid = false;
    // }
    // if (addProjectController.projectManagerCont.text.isEmpty) {
    //   projectManagerErrorString = 'Please enter the project manager\'s name';
    //   isProjectManagerError = true;
    //   isValid = false;
    // }
    // if (addProjectController.timeDurationControl.text.isEmpty) {
    //   timeDurationErrorString = 'Please enter the time duration';
    //   isTimeDurationError = true;
    //   isValid = false;
    // }
    // if (addProjectController.workForceControl.text.isEmpty) {
    //   workForceErrorString = 'Please enter the work force';
    //   isWorkForceError = true;
    //   isValid = false;
    // }
    // if (addProjectController.budgetCont.text.isEmpty) {
    //   budgetErrorString = 'Please enter the budget';
    //   isBudgetError = true;
    //   isValid = false;
    // }
    // if (addProjectController.tentativeCostCont.text.isEmpty) {
    //   tentativeCostErrorString = 'Please enter the tentative cost';
    //   isTentativeCostError = true;
    //   isValid = false;
    // }
    // if (addProjectController.locationCont.text.isEmpty) {
    //   locationErrorString = 'Please enter the location';
    //   isLocationError = true;
    //   isValid = false;
    // }
    // if (addProjectController.contactPersonNameCont.text.isEmpty) {
    //   contactPersonNameErrorString = 'Please enter the contact person\'s name';
    //   isContactPersonNameError = true;
    //   isValid = false;
    // }
    // if (addProjectController.contactPersonPhoneCont.text.isEmpty) {
    //   contactPersonPhoneErrorString = 'Please enter the contact phone number';
    //   isContactPersonPhoneError = true;
    //   isValid = false;
    // }
    // if (addProjectController.priority.value.isEmpty) {
    //   priorityErrorString = 'Please select the project priority';
    //   isPriorityError = true;
    //   isValid = false;
    // }
    // if (addProjectController.company.value.isEmpty) {
    //   companyErrorString = 'Please select a company';
    //   isCompanyError = true;
    //   isValid = false;
    // }

    setState(() {});
    return isValid;
  }

  void resetErrors() {
    isProjectNameError = false;
    isDescriptionError = false;
    isProjectManagerError = false;
    isTimeDurationError = false;
    isWorkForceError = false;
    isBudgetError = false;
    isTentativeCostError = false;
    isLocationError = false;
    isContactPersonNameError = false;
    isContactPersonPhoneError = false;
    isPriorityError = false;
    isCompanyError = false;

    projectNameErrorString = '';
    descriptionErrorString = '';
    projectManagerErrorString = '';
    timeDurationErrorString = '';
    workForceErrorString = '';
    budgetErrorString = '';
    tentativeCostErrorString = '';
    locationErrorString = '';
    contactPersonNameErrorString = '';
    contactPersonPhoneErrorString = '';
    priorityErrorString = '';
    companyErrorString = '';
  }

  bool validation() {
    if (addProjectController.projectNameControl.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the project name',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (addProjectController.clientNameControl.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the client name',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (addProjectController.company.value == '') {
      Get.snackbar('Error', 'Please select the company name',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (addProjectController.workScope.isEmpty) {
      Get.snackbar('Error', 'Please select the workscope',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else {
      return true;
    }
  }
}

class CustomExpansion extends StatefulWidget {
  String? title;
  Function()? onTap;

  bool? openData;

  List<Widget>? children;

  CustomExpansion(
      {super.key, this.title, this.onTap, this.openData, this.children});

  @override
  State<CustomExpansion> createState() => _CustomExpansionState();
}

class _CustomExpansionState extends State<CustomExpansion> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (widget.onTap),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      widget.title!,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    Icon(widget.openData == true
                        ? Icons.arrow_upward
                        : Icons.arrow_downward)
                  ],
                ),
              ),
              widget.openData == true
                  ? Column(children: widget.children!)
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsCard extends StatefulWidget {
  String? title;
  bool selected;
  Function()? onTap;

  ProductsCard({this.title, this.onTap, required this.selected});

  @override
  State<ProductsCard> createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (widget.onTap),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Chip(
            backgroundColor: widget.selected ? appColor : Colors.black12,
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title!,
                style: TextStyle(
                    color: widget.selected ? Colors.white : Colors.black),
              ),
            )),
      ),
    );
  }
}
