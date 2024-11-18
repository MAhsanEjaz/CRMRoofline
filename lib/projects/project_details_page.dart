import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:leadmanagementsystem/admin_module/add_project_page.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/controllers/add_project_controller.dart';
import 'package:leadmanagementsystem/controllers/login_controller.dart';
import 'package:leadmanagementsystem/main.dart';
import 'package:leadmanagementsystem/models/new_project_model.dart';
import 'package:leadmanagementsystem/models/projects_model.dart';
import 'package:leadmanagementsystem/screens/login_screen.dart';
import 'package:leadmanagementsystem/widgets/custom_button.dart';
import 'package:leadmanagementsystem/widgets/custom_text_field.dart';
import 'package:leadmanagementsystem/widgets/custom_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsPage extends StatefulWidget {
  final ProjectData project;

  String receverId;
  String senderName;
  String token;

  bool updateProject;

  ProjectDetailsPage(
      {super.key,
      required this.project,
      required this.updateProject,
      required this.receverId,
      required this.senderName,
      required this.token});

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  bool _isNotesExpanded = false;
  bool _isDescriptionExpanded = false;

  static const int _maxTextLength =
      100; // The threshold for showing "Show more"

  final projectCont = Get.find<AddProjectController>();

  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.getAllUsers();

    loginController.getRegionData();

    projectCont.getRecieveProjectFunction(widget.project.sId!);
  }

  String? name;
  String? role;
  String? recieverId;

  String? assignFcmToken;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Perform your action when the back button is pressed
        projectCont.projectAssign?.projectId =
            null; // Ensure the projectAssign is not null-safe
        setState(() {});

        // Return true to allow the back navigation
        return Future.value(true); // Explicitly return true using Future
      },
      child: Scaffold(
          appBar: mAppbar("${widget.project.title} details", action: [
            widget.updateProject == true
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(AddProjectPage(
                            projectData: widget.project,
                            reciverId: widget.receverId!,
                            token: widget.token,
                            senderName: widget.senderName,
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: appColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0),
                        child: const Text('Update Project')),
                  )
                : const SizedBox.shrink()

            // IconButton(
            //     icon: const Icon(Icons.edit),
            //     onPressed: () {
            //       Get.to(AddProjectPage());
            //     })
          ]),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(context),
                _buildProjectStatus(context),
                widget.updateProject == true
                    ? const SizedBox.shrink()
                    : const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                        child: Text(
                          'Assign To ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                      ),
                widget.updateProject == true
                    ? const SizedBox.shrink()
                    : GetBuilder(
                        init: projectCont,
                        builder: (project) {
                          return project.loadingAssign == true
                              ? const Center(child: CircularProgressIndicator())
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: project.loadingAssign
                                      ? const CupertinoActivityIndicator(
                                          color: appColor,
                                        )
                                      : project.projectAssign?.projectId !=
                                                  null &&
                                              project.projectAssign != null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  const Icon(CupertinoIcons
                                                      .check_mark_circled),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    'Project Assigned To ${project.projectAssign?.recieverName}:     ',
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: const BorderSide(
                                                      color: Colors.black45)),
                                              elevation: 10,
                                              child: GetBuilder(
                                                  init: loginController,
                                                  builder: (controller) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: DropdownButton(
                                                          underline:
                                                              const SizedBox
                                                                  .shrink(),
                                                          isExpanded: true,
                                                          hint: Text(
                                                              '${name ?? 'Select Name'} ${role ?? '&& Role'}' ??
                                                                  'Select Name'),
                                                          items: controller
                                                              .assign
                                                              .map((e) {
                                                            return DropdownMenuItem(
                                                                onTap:
                                                                    () async {
                                                                  name = e.name;
                                                                  role = e.role;
                                                                  assignFcmToken =
                                                                      e.fcmToken;
                                                                  recieverId =
                                                                      e.sId;

                                                                  Map<String,
                                                                          dynamic>
                                                                      body = {
                                                                    'senderUserId':
                                                                        loginStorage
                                                                            .getUserId(),
                                                                    'senderName':
                                                                        loginStorage
                                                                            .getUserName(),
                                                                    'reciverUserId':
                                                                        recieverId,
                                                                    'recieverName':
                                                                        name,
                                                                    'projectId':
                                                                        widget
                                                                            .project
                                                                            .sId,
                                                                    'assignStatus':
                                                                        true,
                                                                    'senderFcmToken':
                                                                        assignFcmToken
                                                                  };

                                                                  print(
                                                                      'body--->$body');

                                                                  await project
                                                                      .sendAssignProject(
                                                                          context,
                                                                          body);

                                                                  project.getRecieveProjectFunction(
                                                                      widget
                                                                          .project
                                                                          .sId!);

                                                                  setState(
                                                                      () {});
                                                                },
                                                                value: e.name,
                                                                child: Text(e
                                                                    .name
                                                                    .toString()));
                                                          }).toList(),
                                                          onChanged: (_) {}),
                                                    );
                                                  }),
                                            ),
                                );
                        }),
                widget.updateProject == true
                    ? const SizedBox.shrink()
                    : requestForUpdateProject(),
                _buildProjectInfo(context),
                _buildAdditionalInfo(context),
                if (widget.project.description != null)
                  _buildExpandableSection(
                      context,
                      "Description",
                      widget.project.description!,
                      _isDescriptionExpanded, (expanded) {
                    setState(() {
                      _isDescriptionExpanded = expanded;
                    });
                  }),
                if (widget.project.notes != null && widget.project.notes != "")
                  _buildExpandableSection(
                      context, "Notes", widget.project.notes!, _isNotesExpanded,
                      (expanded) {
                    setState(() {
                      _isNotesExpanded = expanded;
                    });
                  }),
                if (widget.project.filePath != null &&
                    widget.project.filePath!.isNotEmpty)
                  const SizedBox(height: 10),
                if (widget.project.filePath != null &&
                    widget.project.filePath!.isNotEmpty)
                  _buildFileDownloadButton(),
                const SizedBox(height: 20),
              ],
            ),
          ).animate().fade().scale().move(delay: 300.ms, duration: 600.ms)),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.project.title!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Client Name: ${widget.project.clientName}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  String? selectName;
  String? recieverIdProject;
  String? fcmToken;

  bool isExpand = false;

  TextEditingController commentController = TextEditingController();

  Widget requestForUpdateProject() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              isExpand = !isExpand;
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              'Request for update project',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            Icon(isExpand != true
                                ? Icons.arrow_downward
                                : Icons.arrow_upward)
                          ],
                        ),
                      ),
                      isExpand != true
                          ? const SizedBox.shrink()
                          : const SizedBox(height: 8),
                      isExpand != true
                          ? const SizedBox()
                          : GetBuilder(
                              init: loginController,
                              builder: (controller) {
                                return controller.userRegionData.isEmpty
                                    ? const Center(
                                        child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(),
                                      ))
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.black45),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5),
                                                child: DropdownButton(
                                                    underline: const SizedBox(),
                                                    hint: Text(selectName ==
                                                            null
                                                        ? 'Select a User for Project Update Request'
                                                        : selectName
                                                            .toString()),
                                                    isExpanded: true,
                                                    items: loginController
                                                        .userRegionData
                                                        .map((e) {
                                                      return DropdownMenuItem(
                                                          onTap: () async {
                                                            selectName = e.name;
                                                            recieverIdProject =
                                                                e.sId;

                                                            fcmToken =
                                                                e.fcmToken;

                                                            print(
                                                                'selectName--->$selectName');
                                                            setState(() {});
                                                          },
                                                          value:
                                                              e.name.toString(),
                                                          child: Text(e.name
                                                              .toString()));
                                                    }).toList(),
                                                    onChanged: (_) {}),
                                              ),
                                            ),
                                          ),
                                          isExpand != true
                                              ? const SizedBox.shrink()
                                              : const SizedBox(height: 5),
                                          isExpand != true
                                              ? const SizedBox.shrink()
                                              : CustomTextField(
                                                  hint: 'Comment',
                                                  controller: commentController,
                                                  prefixIcon: Icons.text_fields,
                                                ),
                                          controller.loaderData == true
                                              ? const CircularProgressIndicator()
                                              : CustomButton1(
                                                  text: 'Send Request',
                                                  onPressed: () {
                                                    controller
                                                        .sendProjectUpdateNotification(
                                                            recieverIdProject,
                                                            widget.project.sId,
                                                            commentController
                                                                .text
                                                                .trim(),
                                                            fcmToken!,
                                                            selectName);
                                                  })
                                        ],
                                      );
                              }),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _downloadFile(String fileUrl) async {
    await launchUrl(Uri.parse(fileUrl), mode: LaunchMode.externalApplication);

    print('Downloading file from: $fileUrl');
  }

  Widget _buildProjectStatus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(CupertinoIcons.flag_fill,
                    size: 28, color: Colors.blue),
                const SizedBox(width: 10),
                const Text(
                  'Status:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.project.status!,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ],
            ),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              color: Theme.of(context).primaryColor,
              onPressed: () => _updateProjectStatus(context),
              borderRadius: BorderRadius.circular(20),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          if (widget.project.personName != null)
            if (widget.project.company != null)
              _buildInfoCard(
                context,
                "Company",
                widget.project.company!,
                CupertinoIcons.building_2_fill, // Keep as is or change
                Colors.purple,
              ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Consultant Name",
            "${widget.project.consultantName} ",
            Icons.account_circle, // Updated icon for person name
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Consultant RE (Resident Engineer)",
            "${widget.project.consultantREName} ",
            Icons.engineering, // Changed to match engineering role
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Consultant RE Phone",
            "${widget.project.consultantREPhone} ",
            Icons.phone, // Changed to phone icon
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Consultant ME (Material Engineer)",
            "${widget.project.consultantMEName} ",
            Icons.engineering, // Changed to match engineering role
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Consultant ME Phone",
            "${widget.project.consultantMEPhone} ",
            Icons.phone, // Changed to phone icon
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Contractor Name",
            "${widget.project.contractorName} ",
            Icons.business, // Changed to business icon
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Contractor PM (Project Manager) ",
            "${widget.project.consultantMEName} ",
            Icons.precision_manufacturing, // Updated for Material Engineer
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Contractor PM Phone",
            "${widget.project.consultantMEPhone} ",
            Icons.phone, // Changed to phone icon
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Contractor ME (Material Engineer)",
            "${widget.project.contractorREName} ",
            Icons.engineering, // Changed to match engineering role
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Contractor ME Phone",
            "${widget.project.contractorREPhone} ",
            Icons.phone, // Changed to phone icon
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Budget",
            "\$${widget.project.budget}",
            CupertinoIcons.money_dollar_circle_fill, // Keep as is
            Colors.green,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Tentative Cost",
            "\$${widget.project.tentativeCode}",
            CupertinoIcons.money_dollar_circle, // Keep as is
            Colors.red,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Workforce",
            "${widget.project.workForce} ",
            Icons.group, // Changed to group icon
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Procurement Officer Name",
            "${widget.project.precourmentName} ",
            Icons.person, // Changed to person icon
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Procurement Officer Phone",
            "${widget.project.precourmentPhone} ",
            Icons.phone, // Changed to phone icon
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Account Officer Name",
            "${widget.project.accountOfficerName} ",
            Icons.person, // Changed to person icon
            Colors.teal,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Account Officer Phone",
            "${widget.project.accountOfficerPhone} ",
            Icons.phone, // Changed to phone icon
            Colors.teal,
          ),
          const SizedBox(height: 10),
          if (widget.project.duration != null)
            _buildInfoCard(
              context,
              "Duration",
              widget.project.duration!,
              Icons.timer, // Changed to timer icon
              Colors.blue,
            ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Location",
            widget.project.location!,
            Icons.location_on, // Changed to location icon
            Colors.orange,
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 10),
                  child: Text(
                    'WorkScope',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                ),
                for (var l in widget.project.workScope!) ...[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Icon(Icons.check, color: appColor),
                        const SizedBox(width: 10),
                        Text(
                          l.name.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        )
                      ],
                    ),
                  )
                ]
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            context,
            "Products Price",
            "${widget.project.priceValue} ",
            Icons.monetization_on, // Changed to monetization icon
            Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.project.personName != null)
            _buildInfoCard(
              context,
              "Contact Person",
              widget.project.personName!,
              CupertinoIcons.person_solid,
              Colors.blueAccent,
            ),
          if (widget.project.personName != null) const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse("tel:${widget.project.personContacts}"),
                  mode: LaunchMode.externalApplication);
            },
            child: _buildInfoCard(
              context,
              "Contact Phone",
              widget.project.personContacts!,
              CupertinoIcons.phone_fill,
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 30, color: iconColor),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(BuildContext context, String label,
      String text, bool isExpanded, ValueChanged<bool> onExpandToggle) {
    final bool needsExpansion = text.length > _maxTextLength;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isExpanded || !needsExpansion
                      ? text
                      : '${text.substring(0, _maxTextLength)}...',
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                if (needsExpansion) const SizedBox(height: 5),
                if (needsExpansion)
                  GestureDetector(
                    onTap: () {
                      onExpandToggle(!isExpanded);
                    },
                    child: Text(
                      isExpanded ? 'Show less' : 'Show more',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateStatusButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          onPressed: () => _updateProjectStatus(context),
          borderRadius: BorderRadius.circular(20),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: const Text('Update Status'),
        ),
      ),
    );
  }

  void _updateProjectStatus(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select New Status'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Lead'),
            onPressed: () => _setProjectStatus(context, 'Lead'),
          ),
          CupertinoActionSheetAction(
            child: const Text('Pitched'),
            onPressed: () => _setProjectStatus(context, 'Pitched'),
          ),
          CupertinoActionSheetAction(
            child: const Text('Contacted'),
            onPressed: () => _setProjectStatus(context, 'Contacted'),
          ),
          CupertinoActionSheetAction(
            child: const Text('Sent Sample'),
            onPressed: () => _setProjectStatus(context, 'Sent Sample'),
          ),
          CupertinoActionSheetAction(
            child: const Text('Negotiating'),
            onPressed: () => _setProjectStatus(context, 'Negotiating'),
          ),
          CupertinoActionSheetAction(
            child: const Text('Closed - Won'),
            onPressed: () => _setProjectStatus(context, 'Closed-Won'),
          ),
          CupertinoActionSheetAction(
            child: const Text('Closed - Lost'),
            onPressed: () => _setProjectStatus(context, 'Closed-Lost'),
          ),
          CupertinoActionSheetAction(
            child: const Text('Temporary Close'),
            onPressed: () => _setProjectStatus(context, 'Temporary Close'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Future<void> _setProjectStatus(BuildContext context, String status) async {
    // Navigator.pop(context);
    alertDialogueWithLoader(context);
    bool isUpdated = await projectCont
        .updateProjectStatus({'status': status, "_id": widget.project.sId});
    Navigator.of(context).pop();
    if (mounted && isUpdated) {
      await projectCont.getProjects(context);
      Navigator.of(context).pop();

      setState(() {
        widget.project.status = status;
      });
    }

    // Optionally use a state management solution to update UI
  }

  _buildFileDownloadButton() {
    return Center(
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          _downloadFile(widget.project.filePath!);
        },
        borderRadius: BorderRadius.circular(20),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.cloud_download),
            SizedBox(width: 5),
            Text('Download File'),
          ],
        ),
      ),
    );
  }
}

customLoader(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [Circle()],
          ),
        );
      });
}

class Circle extends StatefulWidget {
  const Circle({super.key});

  @override
  State<Circle> createState() => _CircleState();
}

class _CircleState extends State<Circle> {
  @override
  Widget build(BuildContext context) {
    return customCircleLoader();
  }
}
