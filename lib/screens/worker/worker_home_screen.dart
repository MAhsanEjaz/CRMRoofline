import 'package:crmroofline/constants.dart';
import 'package:crmroofline/models/projects_model.dart';
import 'package:crmroofline/widgets/home_time_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/custom_widgets.dart';
import 'worker_drawer.dart';



class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  List<Map<String, String>> data = [
    {
      'title': 'Total Projects',
      'time': '18',
    },
    {
      'title': 'Matured Projects',
      'time': '6',
    },
    {
      'title': 'Missed Projects',
      'time': '12',
    },
  ];

  List<Map<String, String>> offersData = [
    {
      'date': '10/05/2020',
      'id': 'proj#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
    {
      'date': '10/05/2020',
      'id': 'proj#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
    {
      'date': '10/05/2020',
      'id': 'proj#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
    {
      'date': '10/05/2020',
      'id': 'proj#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
  ];

//!
  final List<Project> dummyProjects = [
    Project(
      title: 'Project Alpha',
      description:
          'This is a description for Project Alpha. This project involves developing a new software platform for managing enterprise resources. The project is expected to bring significant value to the client by optimizing their workflows and improving overall efficiency. The development team is composed of highly skilled professionals with extensive experience in the industry.',
      projectManager: 'Alice Smith',
      duration: '6 months',
      workForce: '10 people',
      budget: 50000.0,
      tentativeCost: 20000,
      location: 'New York',
      notes: 'Important client project.',
      personName: 'Bob',
      personContact: '03414044446',
      projectPriority: 'High',
      file: 'file.pdf',
      createdDate: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Project(
      title: 'Project Beta',
      description:
          'This is a description for Project Beta. This project focuses on the redesign and optimization of a mobile application for a major retail chain. The primary goal is to enhance user experience and introduce new features to increase customer engagement and drive sales.',
      projectManager: 'John Doe',
      duration: '4 months',
      workForce: '8 people',
      budget: 40000.0,
      tentativeCost: 15000,
      location: 'San Francisco',
      notes: 'Ensure regular communication with the client.',
      personName: 'Sara',
      personContact: '03415055557',
      projectPriority: 'Medium',
      file: 'beta_docs.pdf',
      createdDate: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Project(
      title: 'Project Gamma',
      description:
          'This is a description for Project Gamma. The project involves the construction of a new corporate office building. It includes the design, planning, and execution phases, with a focus on sustainable building practices and adherence to strict environmental standards.',
      projectManager: 'Emma Johnson',
      duration: '12 months',
      workForce: '25 people',
      budget: 150000.0,
      tentativeCost: 120000,
      location: 'Chicago',
      notes: 'High visibility project with potential for future contracts.',
      personName: 'Mike',
      personContact: '03416066668',
      projectPriority: 'High',
      file: 'gamma_build.pdf',
      createdDate: DateTime.now().subtract(const Duration(days: 30)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set the desired status bar color
      statusBarIconBrightness:
          Brightness.dark, // Use Brightness.dark for light icons
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       Get.to(const AddTaskScreen());
      //     },
      //     backgroundColor: Theme.of(context).primaryColor,
      //     label: const Text('Add Task')),
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      // backgroundColor:Theme.of(context).bac,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: <InlineSpan>[
              const TextSpan(
                text: "Welcome ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              const WidgetSpan(
                child: SizedBox(width: 5),
              ),
              TextSpan(
                text: "Craig",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      drawer: const WorkerDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeTimeWidget(
                  color: appColor,
                  elevation: 4,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.briefcase_fill,
                            size: 18, color: whiteColor),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Total Projects: 12",
                          style: TextStyle(color: whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Row(
                    children: [
                      titleText("Projects"),
                      const Spacer(),
                      titleText('See all', fontSize: 17)
                    ],
                  ),
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (var p in dummyProjects)
                //         // SizedBox(
                //         //     width: Get.width * .8,
                //         //     child: ProjectsWidget(project: p))
                //     ],
                //   ),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Row(
                    children: [
                      titleText("Tasks"),
                      const Spacer(),
                      titleText('See all', fontSize: 17)
                    ],
                  ),
                ),
                // Wrap(
                //   children: [for (var task in tasks) TaskWidget(task: task)],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  // List<Map<String,dynamic>>statusData=[
  //
  //   {
  //     'color':Colors.red,
  //     'status':'',
  //   }
  //
  //
  // ];
}
