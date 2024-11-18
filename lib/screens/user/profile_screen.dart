import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/controllers/login_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.getProfileService();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: loginController,
        builder: (cont) {
          return Scaffold(
            appBar:
                AppBar(backgroundColor: appColor, title: const Text('Profile')),
            body: cont.profileData == null || cont.profileData == ''
                ? const Center(
                    child: CircularProgressIndicator(color: appColor))
                : SafeArea(
                    child: Column(
                      children: [
                        CustomListTile(
                            title: 'Name',
                            subTitle: cont.profileData!.name,
                            iconData: Icons.person),
                        CustomListTile(
                          title: 'Email',
                          subTitle: cont.profileData!.email,
                          iconData: Icons.email,
                        ),
                        CustomListTile(
                          title: 'Phone',
                          subTitle: cont.profileData!.phone,
                          iconData: Icons.phone,
                        ),
                        CustomListTile(
                          title: 'Role',
                          subTitle: cont.profileData!.role,
                          iconData: Icons.account_tree_rounded,
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}

class CustomListTile extends StatefulWidget {
  String? title;
  String? subTitle;
  IconData? iconData;

  CustomListTile({super.key, this.title, this.subTitle, this.iconData});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Icon(
              widget.iconData,
              color: Colors.black,
            ),
          ),
          title: Text(
            widget.title!,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(widget.subTitle!),
        ),
      ),
    );
  }
}
