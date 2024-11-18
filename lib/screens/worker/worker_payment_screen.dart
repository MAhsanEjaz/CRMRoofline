import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:leadmanagementsystem/constants.dart';
import 'package:leadmanagementsystem/widgets/home_time_widget.dart';

import 'worker_history_page.dart';

class WorkerPaymentScreen extends StatefulWidget {
  const WorkerPaymentScreen({super.key});

  @override
  State<WorkerPaymentScreen> createState() => _WorkerPaymentScreenState();
}

class _WorkerPaymentScreenState extends State<WorkerPaymentScreen> {
  List<Map<String, String>> offersData = [
    {
      'date': '10/05/2020',
      'id': 'task#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
    {
      'date': '10/05/2020',
      'id': 'task#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
    {
      'date': '10/05/2020',
      'id': 'task#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
    {
      'date': '10/05/2020',
      'id': 'task#11122',
      'days': '3d',
      'status': 'open',
      'title': 'Stainless roof renovations',
      'location': 'Rose boulevard 12th, Cal, USA',
      'distance': '1.4km'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          'Payment',
          style: TextStyle(color: blackColor),
        ),
        actions: <Widget>[
          PopupMenuButton(
            iconColor: Colors.black,
            itemBuilder: (BuildContext context) => <PopupMenuItem>[
              const PopupMenuItem(
                value: 1,
                child: Text('First Item'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Second Item'),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text('Third Item'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.1),
                            offset: const Offset(10, 10),
                            blurRadius: 2),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: appColor,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(width: 10),
                            const SizedBox(
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 3),
                                  Text(
                                    'Current Balance',
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    '\$769.00',
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  backgroundColor: whiteColor,
                                  side: const BorderSide(color: appColor)),
                              onPressed: () {},
                              child: Text(
                                'Cash out'.toUpperCase(),
                                style: const TextStyle(
                                    color: appColor,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        const SizedBox(height: 4)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      'Dashboard',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
                    ),
                    Spacer(),
                    Text(
                      'See all',
                      style: TextStyle(
                          color: appColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: LineChartWidget()),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'Completed',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19),
                      ),
                      Spacer(),
                      Text(
                        'See all',
                        style: TextStyle(
                            color: appColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                for (var l in offersData)
                  HomeTimeWidget(
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                l['date'].toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              // SizedBox(
                              //     width:
                              //     MediaQuery.sizeOf(context).width /
                              //         3.5),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0, vertical: .5),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time_filled,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            l['days'].toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(width: 4)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 5),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.blue.shade100),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: .5),
                                  child: Text(
                                    l['status'].toString(),
                                    style:
                                        TextStyle(color: Colors.blue.shade500),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            l['id'].toString(),
                            style: const TextStyle(
                                color: Colors.black38, fontSize: 12),
                          ),
                          Text(
                            l['title'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 15,
                              ),
                              const SizedBox(width: 5),
                              RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: l['location'],
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 13))
                              ]))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 22.0),
                                    child: Container(
                                      height: 22,
                                      width: 22,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?cs=srgb&dl=pexels-soldiervip-1391498.jpg&fm=jpg'),
                                              fit: BoxFit.fill),
                                          color: Colors.blue,
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                  Positioned(
                                    left: 11,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        height: 22,
                                        width: 22,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRe5DWJI8MqOw8ggi_0tdxdWqqpPHLT_WQZtZwomHftOw&s'),
                                                fit: BoxFit.fill),
                                            color: Colors.black,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 22,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        height: 22,
                                        width: 22,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://img.freepik.com/free-photo/young-beautiful-girl-posing-black-leather-jacket-park_1153-8104.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1716681600&semt=ais_user'),
                                                fit: BoxFit.fill),
                                            color: Colors.pink,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 8),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('3 people',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.5)),
                                  Text('Kello, Json, Peter',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11)),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          // SizedBox(
                          //   // width: MediaQuery.sizeOf(context).width / 1.5,
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           child: ElevatedButton(
                          //               onPressed: () {},
                          //               style: ElevatedButton.styleFrom(
                          //                   backgroundColor: Colors.white,
                          //                   shape: RoundedRectangleBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(10),
                          //                       side: const BorderSide(
                          //                           color: appColor)),
                          //                   surfaceTintColor: Colors.white),
                          //               child: Text(
                          //                 'Detail'.toUpperCase(),
                          //                 style:
                          //                     const TextStyle(color: appColor),
                          //               ))),
                          //       const SizedBox(width: 20),
                          //       Expanded(
                          //           child: ElevatedButton(
                          //               onPressed: () {},
                          //               style: ElevatedButton.styleFrom(
                          //                   backgroundColor: appColor,
                          //                   shape: RoundedRectangleBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(10),
                          //                       side: const BorderSide(
                          //                           color: appColor)),
                          //                   surfaceTintColor: Colors.white),
                          //               child: Text(
                          //                 'Accept'.toUpperCase(),
                          //                 style: const TextStyle(
                          //                     color: Colors.white),
                          //               ))),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
