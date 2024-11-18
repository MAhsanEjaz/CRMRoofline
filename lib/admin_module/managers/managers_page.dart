import 'package:crmroofline/constants.dart';
import 'package:crmroofline/widgets/custom_button.dart';
import 'package:crmroofline/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';



class ManagersPage extends StatefulWidget {
  const ManagersPage({super.key});

  @override
  State<ManagersPage> createState() => _ManagersPageState();
}

class _ManagersPageState extends State<ManagersPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _addManager() async {
    if (_formKey.currentState?.validate() ?? false) {
      final String name = _nameController.text;
      final String email = _emailController.text;
      final String phoneNumber = _phoneNumberController.text;
      final String password = _passwordController.text;

      Map<String, dynamic> jsonBody = {
        "name": name,
        "email": email,
        "password": password,
        "phone": phoneNumber,
        "status": "Active",
        "role": "Project Manager"
      };

      await managersCont.addManager(jsonBody);

      _nameController.clear();
      _emailController.clear();
      _phoneNumberController.clear();
      _passwordController.clear();
      Navigator.of(context).pop();
    }
  }

  void _toggleManagerStatus(int index) {
    if (managersCont.managersData[index].status == "Active") {
      managersCont.managersData[index].status = "Deactive";
    } else {
      managersCont.managersData[index].status = "Active";
    }

    setState(() {});
  }

  void _showAddManagerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Add New Manager'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextField(
                      controller: _nameController,
                      hint: "Name",
                      onValidate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _emailController,
                      hint: "Email",
                      inputType: TextInputType.emailAddress,
                      onValidate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        } else if (!GetUtils.isEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _phoneNumberController,
                      hint: "Phone Number",
                      inputType: TextInputType.phone,
                      onValidate: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length > 15 ||
                            value.length < 11) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hint: "Password",
                      maxLines: 1,
                      obscureText: true,
                      onValidate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                GetBuilder(
                  init: managersCont,
                  builder: (controller) {
                    return CustomButton(
                      title: "Add",
                      color: appColor,
                      onTap: _addManager,
                      child: controller.addManagersLoading
                          ? customCircleLoader()
                          : null,
                    );
                  },
                ),
                CustomButton(
                  title: "Cancel",
                  color: Colors.redAccent,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showConfirmationDialog(
      BuildContext context, UserData manager, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(manager.status == "Active"
              ? 'Deactivate Account'
              : 'Activate Account'),
          content: Text(manager.status == "Active"
              ? 'Are you sure you want to deactivate this account?'
              : 'Are you sure you want to activate this account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm(); // Perform the action
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  final ManagerController managersCont = Get.put(ManagerController());

  @override
  void initState() {
    super.initState();
    managersCont.getManagers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppbar("Users"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GetBuilder<ManagerController>(
              init: managersCont,
              builder: (controller) {
                if (controller.getManagersLoading) {
                  return showSpinkit();
                } else if (controller.managersData.isEmpty) {
                  return const Center(child: Text('No managers found'));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.managersData.length,
                    itemBuilder: (context, index) {
                      return ManagerCard(
                        manager: controller.managersData[index],
                        onToggleStatus: () => _showConfirmationDialog(
                          context,
                          controller.managersData[index],
                          () => _toggleManagerStatus(index),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _showAddManagerDialog,
      //   backgroundColor: appColor,
      //   label: const Text("Add Manager"),
      //   icon: const Icon(Icons.add),
      // ),
    );
  }
}

class ManagerCard extends StatefulWidget {
  final UserData manager;
  final VoidCallback onToggleStatus;

  const ManagerCard({required this.manager, required this.onToggleStatus});

  @override
  _ManagerCardState createState() => _ManagerCardState();
}

class _ManagerCardState extends State<ManagerCard> {
  bool showPassword = false;
  bool isActive = true;

  @override
  void initState() {
    super.initState();

    if (widget.manager.status == "Active") {
      isActive = true;
    } else {
      isActive = false;
    }
  }

  ManagerController managerController = Get.put(ManagerController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(
        init: managerController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                // Additional functionality can be added here if needed
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15.0),
                  title: Text(
                    widget.manager.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.black87 : Colors.grey[600],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.manager.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: isActive ? Colors.grey : Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (widget.manager.phone != null)
                        Text(
                          widget.manager.phone ?? "No phone number",
                          style: TextStyle(
                            fontSize: 16,
                            color: isActive ? Colors.grey : Colors.grey[500],
                          ),
                        ),
                      // const SizedBox(height: 6),
                      // Row(
                      //   children: [
                      //     Text(
                      //       showPassword ? widget.manager.password : '********',
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         color: isActive ? Colors.black87 : Colors.grey[600],
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     InkWell(
                      //       onTap: () {
                      //         setState(() {
                      //           showPassword = !showPassword;
                      //         });
                      //       },
                      //       child: Icon(
                      //         showPassword ? Icons.visibility_off : Icons.visibility,
                      //         color: isActive ? appColor : Colors.grey,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 6),
                      Text(
                        DateFormat.yMMMd().format(widget.manager.createdDate),
                        style: TextStyle(
                          fontSize: 14,
                          color: isActive ? Colors.grey : Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (!isActive)
                        const Text(
                          'Status: Disabled',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Toggle Status') {
                        widget.onToggleStatus();
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        // PopupMenuItem<String>(
                        //   value: 'Toggle Status',
                        //   child: Text(isActive
                        //       ? 'Deactivate Account'
                        //       : 'Activate Account'),
                        // ),
                        PopupMenuItem(
                          child: const Text('Update Account'),
                          onTap: () {
                            customRoutes(
                                context,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomDialog(manager: widget.manager),
                                ));
                          },
                        ),
                        PopupMenuItem(
                          child: const Text('Delete Account',
                              style: TextStyle(color: Colors.red)),
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                      actions: [
                                        CupertinoActionSheetAction(
                                            onPressed: () {
                                              controller.deleteFunction(
                                                  widget.manager.id);
                                            },
                                            child: const Text('Delete'))
                                      ],
                                      cancelButton: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          child: Ink(
                                            color: Colors.red,
                                            child: CupertinoActionSheetAction(
                                                isDefaultAction: true,
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ),
                                      ),
                                      title: const Text(
                                          'Are you sure you want to delete this user?'),
                                    ));
                          },
                        )
                      ];
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
