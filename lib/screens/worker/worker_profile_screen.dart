import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'worker_history_page.dart';

class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({super.key});

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.edit_off_sharp,
              color: blackColor,
            ),
          )
        ],
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
        backgroundColor: whiteColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTOIiEXB1uOFlAQAp2JSlv7zCR4R29QFIg3w&usqp=CAU'),
                    radius: 35,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 13,
                        ),
                        Text('Craftman Craig',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 22)),
                        SizedBox(height: 4),
                        // const Text(
                        //   'ID#008636 . Workers',
                        //   style: TextStyle(color: Colors.black26),
                        // ),
                        SizedBox(height: 8),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       border: Border.all(color: appColor),
                        //       borderRadius: BorderRadius.circular(12)),
                        //   child: const Padding(
                        //     padding: EdgeInsets.only(
                        //         right: 12, top: 3, bottom: 3, left: 5),
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         Icon(
                        //           Icons.person_pin,
                        //           color: appColor,
                        //           size: 16,
                        //         ),
                        //         SizedBox(
                        //           width: 8,
                        //         ),
                        //         Text(
                        //           'Change to Manager',
                        //           style:
                        //               TextStyle(color: appColor, fontSize: 12),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // CustomTile(
            //   iconData: Icons.account_balance_wallet_outlined,
            //   title: 'My Balance',
            //   rowText: '\$22.2',
            // ),
            CustomTile(
              iconData: Icons.list_alt,
              title: 'Document',
            ),
            CustomTile(
              iconData: Icons.settings,
              title: 'Setting',
            ),
            CustomTile(
              iconData: Icons.lock,
              title: 'Security & Privacy',
            ),
            CustomTile(
              iconData: Icons.announcement_rounded,
              title: 'About',
            ),
            CustomTile(
              iconData: Icons.login_rounded,
              title: 'Security & Privacy',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTile extends StatefulWidget {
  IconData iconData;
  String? title;
  String? rowText;

  CustomTile({super.key, this.title, this.rowText, required this.iconData});

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: .5),
      child: ListTile(
        tileColor: Colors.white,
        leading: Icon(widget.iconData),
        title: Text(widget.title!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.rowText == null
                ? const SizedBox.shrink()
                : Text(widget.rowText!),
            const SizedBox(width: 8),
            const Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    );
  }
}
