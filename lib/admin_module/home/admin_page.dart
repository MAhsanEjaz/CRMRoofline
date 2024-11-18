// import 'dart:ui';

// import 'package:flutter/animation.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:leadmanagementsystem/admin_module/add_project_page.dart';
// import 'package:leadmanagementsystem/admin_module/project_detail_page.dart';
// import 'package:leadmanagementsystem/constants.dart';
// import 'package:leadmanagementsystem/screens/login_screen.dart';
// import 'package:leadmanagementsystem/widgets/custom_button.dart';
// import 'package:leadmanagementsystem/widgets/custom_widgets.dart';

// class AdminDashboardPage extends StatefulWidget {
//   const AdminDashboardPage({super.key});

//   @override
//   State<AdminDashboardPage> createState() => _AdminDashboardPageState();
// }

// class _AdminDashboardPageState extends State<AdminDashboardPage> {
//   String desc =
//       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: mAppbar("Admin"),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                     width: 200,
//                     child: CustomButton1(
//                         text: 'Add New Project',
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => AddProjectPage(),
//                               ));
//                         })),
//                 const SizedBox(height: 10),
//                 Wrap(
//                   children: [
//                     CustomProgressCard(
//                       borderColor: Colors.green[500],
//                       title: 'Completed',
//                       color: Colors.green[500],
//                       progress: .1,
//                     ),
//                     CustomProgressCard(
//                       borderColor: Colors.yellow,
//                       title: 'Pending',
//                       color: Colors.yellow,
//                       progress: .5,
//                     ),
//                     CustomProgressCard(
//                         borderColor: Colors.amber,
//                         title: 'BackLog',
//                         color: Colors.amber,
//                         progress: .2),
//                     CustomProgressCard(
//                         progress: 70,
//                         child: const Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             SizedBox(height: 15),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 18.0),
//                               child: Text(
//                                 'Total Tasks',
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                             Spacer(),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 '1,690',
//                                 style: TextStyle(
//                                     fontSize: 45,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                             ),
//                             Spacer()
//                           ],
//                         )),
//                     // CustomProgressCard(),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 InkWell(
//                     onTap: () {
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //       builder: (context) => CustomCard(),
//                       //     ));
//                     },
//                     child: const Text("All Projects")),

//                 // Card(
//                 //   child: Container(
//                 //     height: 150,
//                 //     width: getWidth(context),
//                 //     decoration: BoxDecoration(
//                 //       color: Colors.grey[200],
//                 //     ),
//                 //     child: Padding(
//                 //       padding: const EdgeInsets.all(14.0),
//                 //       child: Column(
//                 //         mainAxisAlignment: MainAxisAlignment.start,
//                 //         crossAxisAlignment: CrossAxisAlignment.start,
//                 //         children: [
//                 //           const Row(
//                 //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //             children: [
//                 //               Text(
//                 //                 "Cement Bajri",
//                 //                 style: TextStyle(
//                 //                     fontWeight: FontWeight.bold,
//                 //                     color: appColor),
//                 //               ),
//                 //               Text("15 April 24"),
//                 //             ],
//                 //           ),
//                 //           const SizedBox(
//                 //             height: 10,
//                 //           ),
//                 //           Text(
//                 //             desc,
//                 //             maxLines: 2,
//                 //           ),
//                 //           const Row(
//                 //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //             children: [
//                 //               Text.rich(TextSpan(children: [
//                 //                 TextSpan(text: "Status :"),
//                 //                 TextSpan(
//                 //                     text: "High",
//                 //                     style: TextStyle(color: Colors.red)),
//                 //               ])),
//                 //               Text.rich(TextSpan(children: [
//                 //                 TextSpan(text: "Budget :"),
//                 //                 TextSpan(
//                 //                     text: "1 M",
//                 //                     style: TextStyle(color: appColor)),
//                 //               ])),
//                 //             ],
//                 //           ),
//                 //           const SizedBox(
//                 //             height: 10,
//                 //           ),
//                 //           const Row(
//                 //             children: [
//                 //               Icon(CupertinoIcons.cloud_download_fill),
//                 //               SizedBox(
//                 //                 width: 10,
//                 //               ),
//                 //               Text('Download Attached File'),
//                 //             ],
//                 //           )
//                 //         ],
//                 //       ),
//                 //     ),
//                 //   ),
//                 // )

//                 // // Padding(
//                 // //   padding: const EdgeInsets.all(8.0),
//                 // //   child: Container(
//                 // //     height: 120,
//                 // //     decoration: BoxDecoration(
//                 // //         border: Border.all(color: Colors.black38),
//                 // //         borderRadius: BorderRadius.circular(10)),
//                 // //     width: double.infinity,
//                 // //   ),
//                 // // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomProgressCard extends StatefulWidget {
//   final Color? color;
//   final String? title;
//   final Color? borderColor;
//   final Widget? child;
//   final double progress; // Add progress value

//   CustomProgressCard({
//     super.key,
//     this.color,
//     this.title,
//     this.child,
//     this.borderColor,
//     required this.progress, // Initialize progress value
//   });

//   @override
//   State<CustomProgressCard> createState() => _CustomProgressCardState();
// }

// class _CustomProgressCardState extends State<CustomProgressCard>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//     _animation = Tween<double>(begin: 0, end: widget.progress).animate(
//       CurvedAnimation(
//         parent: _animationController!,
//         curve: Curves.easeInOut,
//       ),
//     );
//     _animationController!.forward();
//   }

//   @override
//   void dispose() {
//     _animationController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: getWidth(context) / 2.1,
//       child: Padding(
//         padding: const EdgeInsets.all(3.0),
//         child: widget.child != null
//             ? SizedBox(
//                 height: 220,
//                 child: Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   color: Colors.teal.shade300,
//                   child: widget.child,
//                 ),
//               )
//             : Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   side: BorderSide(color: widget.borderColor!),
//                 ),
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15.0),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.title!,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w400, fontSize: 17),
//                         ),
//                         const SizedBox(height: 10),
//                         Align(
//                           alignment: Alignment.center,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 SizedBox(
//                                   height: 120,
//                                   width: 120,
//                                   child: CircularProgressIndicator(
//                                     value: 1.0,
//                                     strokeWidth: 5.0,
//                                     backgroundColor: Colors.grey.shade200,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         Colors.grey.shade200),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 120,
//                                   width: 120,
//                                   child: AnimatedBuilder(
//                                     animation: _animation,
//                                     builder: (context, child) {
//                                       return CircularProgressIndicator(
//                                         value: widget.progress, // 50%
//                                         strokeWidth: 8.0,
//                                         valueColor:
//                                             AlwaysStoppedAnimation<Color>(
//                                                 widget.color!),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 AnimatedBuilder(
//                                   animation: _animation,
//                                   builder: (context, child) {
//                                     return Text(
//                                       '${(_animation.value * 100).toInt()}%',
//                                       style: const TextStyle(
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.w500),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
