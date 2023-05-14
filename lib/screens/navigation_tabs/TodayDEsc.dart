// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:connectivity/connectivity.dart';
// import 'package:countup/countup.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';
// import 'package:weight_loser/Component/DDText.dart';
// import 'package:weight_loser/Controller/HomePageData.dart';
// import 'package:weight_loser/Controller/video.dart';
// import 'package:weight_loser/Controller/video_player.dart';
// import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
// import 'package:weight_loser/Service/DashBord%20Api.dart';
// import 'package:weight_loser/Service/Today_api.dart';
// import 'package:weight_loser/constants/constant.dart';
// import 'package:weight_loser/models/DashboardModel.dart';
// import 'package:weight_loser/models/dairy_model.dart';
// import 'package:weight_loser/screens/articles_screens/ArticleDetails.dart';
// import 'package:weight_loser/screens/diet_plan_screens/tabs/FavouriteInnerTab.dart';
// import 'package:weight_loser/screens/navigation_tabs/homepage/HomeMiddle.dart';
// import 'package:weight_loser/utils/AppConfig.dart';
// import 'package:weight_loser/widget/Shimmer/GoalShimmer.dart';
// import 'package:weight_loser/widget/Shimmer/ProfileShimmer.dart';
// import 'package:weight_loser/widget/Shimmer/WorkOutShimmer.dart';
// import 'package:weight_loser/widget/SizeConfig.dart';
// import 'package:weight_loser/widget/Shimmer/today_shimmer_widget.dart';
//
// import 'New_meditation.dart';
// import 'homepage/HomePageMiddle.dart';
// import 'homepage/middle.dart';
//
// class TodayScreen1 extends StatefulWidget {
//   TodayScreen1({Key key}) : super(key: key);
//   @override
//   _TodayScreen1State createState() => _TodayScreen1State();
// }
//
// class _TodayScreen1State extends State<TodayScreen1>
//     with AutomaticKeepAliveClientMixin<TodayScreen1> {
//   @override
//   bool get wantKeepAlive => true;
//
//   int userid;
//   bool networkConnection;
//   var subscription;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     subscription = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult connectivityResult) {
//       if (connectivityResult == ConnectivityResult.mobile ||
//           connectivityResult == ConnectivityResult.wifi) {
//         setState(() {
//           networkConnection = true;
//         });
//       } else {
//         setState(() {
//           networkConnection = false;
//         });
//       }
//     });
//     // fetchDashboardData();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     subscription.cancel();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     Size _size = MediaQuery.of(context).size;
//     super.build(context);
//     return WillPopScope(
//       onWillPop: () => Future.value(true),
//       child: Column(
//         children: [
//           SingleChildScrollView(
//             physics:
//                 BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // FutureBuilder<DashboardModel>(
//                 //   future: fetchDashboardData(),
//                 //   builder: (context, snapshot) {
//                 //     if (snapshot.hasData &&
//                 //         snapshot.connectionState == ConnectionState.done) {
//                 //       return profileSection(snapshot.data.profileVM);
//                 //     } else if (snapshot.hasError) {
//                 //       return Center(
//                 //         child: Text('No Internet Connectivity'),
//                 //       );
//                 //     }
//                 //
//                 //     // By default, show a loading spinner.
//                 //     return Profileshimmer();
//                 //   },
//                 // ),
//                 Divider(
//                   color: Colors.transparent,
//                 ),
//                 SizedBox(height: MySize.size16),
//                 FutureBuilder<Dairy>(
//                   future: fetchDairy(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return _size.width>1300?goalFoodExerciseCaloriesView(snapshot.data,80,80,context):goalFoodExerciseCaloriesView(snapshot.data,MySize.size4,MySize.size26,context);
//                     } else if (snapshot.hasError) {
//                       return Center(
//                         child: Text('No Internet Connectivity'),
//                       );
//                     }
//
//                     // By default, show a loading spinner.
//                     return GoalShimmer();
//                   },
//                 ),
//                 SizedBox(
//                   height: SizeConfig.safeBlockVertical * 4,
//                 ),
//                 FutureBuilder<DashboardModel>(
//                   future: fetchDashboardData(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData &&
//                         snapshot.connectionState == ConnectionState.done) {
//                       return Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 80,right: 80),
//                             child: Middle(),
//                           ),
//                           // HomeMiddle(),
//                           //HomePageMiddle(),
//                           SizedBox(
//                             height: SizeConfig.safeBlockVertical * 2,
//                           ),
//
//                           // SizedBox(
//                           //   height: SizeConfig.safeBlockVertical * 4,
//                           // ),
//                           _size.width>1300?quotationSection(80,80):quotationSection(MySize.size36,MySize.size32),
//                           SizedBox(
//                             height: SizeConfig.safeBlockVertical * 5,
//                           ),
//                           _size.width>1300?workoutSection1(80): workoutSection1( MySize.size18),
//                           // workoutSection(snapshot.data.activeExercisePlans),
//                           SizedBox(
//                             height: SizeConfig.safeBlockVertical * 2,
//                           ),
//                           // psychologicalSectionView(),
//                           // SizedBox(
//                           //   height: SizeConfig.safeBlockVertical * 2,
//                           // ),
//                           psychologicalSection(snapshot.data.meditation,
//                               snapshot.data.mindPlans),
//                           SizedBox(
//                             height: SizeConfig.safeBlockVertical * 2,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 80,right:80),
//                             child: blogSection(snapshot.data.blogs),
//                           ),
//                         ],
//                       );
//                     } else if (snapshot.hasError &&
//                         snapshot.connectionState == ConnectionState.done) {
//                       log(snapshot.hasError.toString());
//                       return Center(
//                         child: Text('No Internet Connectivity'),
//                       );
//                     }
//
//                     // By default, show a loading spinner.
//                     return TodayShimmerWidget();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ############################ PROFILE SECTION #################################
//
//   Container profileSection(ProfileVM profile) {
//     return Container(
//       // color: Colors.red,
//       padding: EdgeInsets.only(
//           left: MySize.size16, top: MySize.size20, right: MySize.size20),
//       child: Row(
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage:
//                     NetworkImage('$imageBaseUrl${profile.imageFile}'),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: MySize.size6),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     DDText(
//                       title: profile.name,
//                       size: MySize.size13,
//                     ),
//                     DDText(
//                       title: "",
//                       size: MySize.size11,
//                       color: Colors.grey,
//                       weight: FontWeight.w300,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//           Expanded(child: Container()),
//           GestureDetector(
//             onTap: () {
//               Get.to(() => FavouriteTabInnerPage());
//               // Navigator.push(context, MaterialPageRoute(builder: (context) {
//               //   return FavouriteTabInnerPage();
//               // }));
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Text(""),
//                 Padding(
//                   padding: EdgeInsets.only(bottom: MySize.size14),
//                   child: Row(
//                     children: [
//                       DDText(
//                         title: "Favourites",
//                         size: MySize.size13,
//                       ),
//                       SizedBox(
//                         width: MySize.size4,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 4),
//                         child: Image.asset(
//                           "assets/icons/heart_my_favourite.png",
//                           width: 10,
//                           height: 10,
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// // ############################ WORKOUT SECTION #################################
//
//   // Widget workoutSection(List<ActiveExercisePlans> values) {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Padding(
//   //         padding: EdgeInsets.only(left: MySize.size18),
//   //         child: DDText(
//   //           title: "Today's Workout",
//   //           size: MySize.size12,
//   //         ),
//   //       ),
//   //       if (values == null || values.length == 0)
//   //         Container(
//   //           alignment: Alignment.center,
//   //           padding: EdgeInsets.only(top: 20, left: MySize.size18),
//   //           child: DDText(
//   //             title: "No workout planned today",
//   //             size: MySize.size12,
//   //           ),
//   //         ),
//   //       Container(
//   //           height: values.length == 0 ? 0 : 200,
//   //           margin: EdgeInsets.all(10),
//   //           child: ListView.builder(
//   //             scrollDirection: Axis.horizontal,
//   //             itemCount: values.length,
//   //             itemBuilder: (BuildContext context, int index) {
//   //               return Container(
//   //                 width: 200,
//   //                 height: MediaQuery.of(context).size.height * 2,
//   //                 child: GestureDetector(
//   //                   onTap: () {
//   //                     Get.to(() => VideoWidget(
//   //                         url: '$videosBaseUrl${values[index].videoFile}',
//   //                         play: true));
//   //                     // Navigator.push(context,
//   //                     //     MaterialPageRoute(builder: (context) {
//   //                     //   return VideoWidget(
//   //                     //       url: '$videosBaseUrl${values[index].videoFile}',
//   //                     //       play: true);
//   //                     // }));
//   //                   },
//   //                   child: Card(
//   //                     shape: RoundedRectangleBorder(
//   //                       borderRadius: BorderRadius.circular(5.0),
//   //                     ),
//   //                     child: Column(
//   //                       crossAxisAlignment: CrossAxisAlignment.start,
//   //                       mainAxisAlignment: MainAxisAlignment.center,
//   //                       children: <Widget>[
//   //                         // GestureDetector(
//   //                         //   onTap: () {
//   //                         //     setState(() {});
//   //                         //     // initialIndex = 0;
//   //                         //     Navigator.push(context, MaterialPageRoute(builder: (context) {
//   //                         //       return VideoWidget(url:'$videosBaseUrl${values[index].videoFile}', play: true);
//   //                         //     }));
//   //                         //     // Navigator.push(
//   //                         //     //   context,
//   //                         //     //   MaterialPageRoute(
//   //                         //     //     builder: (BuildContext context) => GetUpGoUp(
//   //                         //     //         '$imageBaseUrl${values[index].burnerImage}',
//   //                         //     //         values[index].name,
//   //                         //     //         values[index].planTypeId,
//   //                         //     //         int.parse(values[index].planDuration)),
//   //                         //     //   ),
//   //                         //     // );
//   //                         //   },
//   //                         //   child: Container(
//   //                         //     height: 100,
//   //                         //     child: ClipRRect(
//   //                         //       borderRadius: BorderRadius.only(
//   //                         //         topLeft: Radius.circular(10),
//   //                         //         topRight: Radius.circular(10),
//   //                         //       ),
//   //                         //       child: Image.network(
//   //                         //         '$imageBaseUrl${values[index].burnerImage}',
//   //                         //         fit: BoxFit.cover,
//   //                         //       ),
//   //                         //     ),
//   //                         //   ),
//   //                         // ),
//   //                         Container(
//   //                           height: 100,
//   //                           child: ClipRRect(
//   //                             borderRadius: BorderRadius.only(
//   //                               topLeft: Radius.circular(10),
//   //                               topRight: Radius.circular(10),
//   //                             ),
//   //                             child: Image.network(
//   //                               '$imageBaseUrl${values[index].burnerImage}',
//   //                               fit: BoxFit.cover,
//   //                             ),
//   //                           ),
//   //                         ),
//   //                         Container(
//   //                           margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
//   //                           child: Column(
//   //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                             children: [
//   //                               Text(values[index].name,
//   //                                   style: TextStyle(
//   //                                       fontSize: 12,
//   //                                       fontWeight: FontWeight.w400,
//   //                                       color: Colors.black)),
//   //                               Row(
//   //                                 mainAxisAlignment: MainAxisAlignment.start,
//   //                                 children: [
//   //                                   Padding(
//   //                                     padding: const EdgeInsets.only(top: 5.0),
//   //                                     child: Row(
//   //                                       children: [
//   //                                         Text(
//   //                                           "10 values",
//   //                                           style: TextStyle(
//   //                                               color: Colors.grey,
//   //                                               fontSize: 11,
//   //                                               fontWeight: FontWeight.w300),
//   //                                         ),
//   //                                         SizedBox(
//   //                                           width: MySize.size4,
//   //                                         ),
//   //                                         Container(
//   //                                           padding: EdgeInsets.only(top: 4.0),
//   //                                           child: Text(
//   //                                             "*",
//   //                                             style: TextStyle(
//   //                                                 color: Colors.grey,
//   //                                                 fontSize: 11,
//   //                                                 fontWeight: FontWeight.w300),
//   //                                           ),
//   //                                         ),
//   //                                         Text(
//   //                                           "5 sets",
//   //                                           style: TextStyle(
//   //                                               color: Colors.grey,
//   //                                               fontSize: 11,
//   //                                               fontWeight: FontWeight.w300),
//   //                                         ),
//   //                                       ],
//   //                                     ),
//   //                                   ),
//   //                                   Expanded(child: Container()),
//   //                                   Padding(
//   //                                     padding: EdgeInsets.only(
//   //                                         top: 5.0, right: MySize.size10),
//   //                                     child: Row(
//   //                                       children: [
//   //                                         Text(
//   //                                           values[index]
//   //                                               .calories
//   //                                               .toStringAsFixed(1),
//   //                                           style: TextStyle(
//   //                                               color: Colors.black,
//   //                                               fontSize: 13,
//   //                                               fontWeight: FontWeight.w500),
//   //                                         ),
//   //                                         SizedBox(width: 2),
//   //                                         Text(
//   //                                           "cal",
//   //                                           style: TextStyle(
//   //                                               color: Colors.grey,
//   //                                               fontSize: 13,
//   //                                               fontWeight: FontWeight.w300),
//   //                                         ),
//   //                                       ],
//   //                                     ),
//   //                                   ),
//   //                                 ],
//   //                               )
//   //                             ],
//   //                           ),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 ),
//   //               );
//   //             },
//   //           )),
//   //     ],
//   //   );
//   // }
//   bool isloading = false;
//   Widget workoutSection1(left) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left:left),
//           child: DDText(
//             title: "Today's Workout",
//             size: MySize.size12,
//           ),
//         ),
//         FutureBuilder(
//             future: fetchTodayExercise(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData &&
//                   snapshot.connectionState == ConnectionState.done) {
//                 return Container(
//                     height: snapshot.data.length == 0 ? 0 : 200,
//                     margin: EdgeInsets.all(10),
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                           width: 200,
//                           height: MediaQuery.of(context).size.height * 2,
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.to(() => VideoWidget(
//                                   url:
//                                       '$videosBaseUrl${snapshot.data[index]['VideoFile']}',
//                                   play: true));
//                               // Navigator.push(context,
//                               //     MaterialPageRoute(builder: (context) {
//                               //   return VideoWidget(
//                               //       url: '$videosBaseUrl${values[index].videoFile}',
//                               //       play: true);
//                               // }));
//                             },
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5.0),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   // GestureDetector(
//                                   //   onTap: () {
//                                   //     setState(() {});
//                                   //     // initialIndex = 0;
//                                   //     Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                   //       return VideoWidget(url:'$videosBaseUrl${values[index].videoFile}', play: true);
//                                   //     }));
//                                   //     // Navigator.push(
//                                   //     //   context,
//                                   //     //   MaterialPageRoute(
//                                   //     //     builder: (BuildContext context) => GetUpGoUp(
//                                   //     //         '$imageBaseUrl${values[index].burnerImage}',
//                                   //     //         values[index].name,
//                                   //     //         values[index].planTypeId,
//                                   //     //         int.parse(values[index].planDuration)),
//                                   //     //   ),
//                                   //     // );
//                                   //   },
//                                   //   child: Container(
//                                   //     height: 100,
//                                   //     child: ClipRRect(
//                                   //       borderRadius: BorderRadius.only(
//                                   //         topLeft: Radius.circular(10),
//                                   //         topRight: Radius.circular(10),
//                                   //       ),
//                                   //       child: Image.network(
//                                   //         '$imageBaseUrl${values[index].burnerImage}',
//                                   //         fit: BoxFit.cover,
//                                   //       ),
//                                   //     ),
//                                   //   ),
//                                   // ),
//                                   Container(
//                                     height: 100,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(10),
//                                         topRight: Radius.circular(10),
//                                       ),
//                                       child: Image.network(
//                                         '$imageBaseUrl${snapshot.data[index]['BurnerImage']}',
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(snapshot.data[index]['Name'],
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.black)),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 5.0),
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     "10 values",
//                                                     style: TextStyle(
//                                                         color: Colors.grey,
//                                                         fontSize: 11,
//                                                         fontWeight:
//                                                             FontWeight.w300),
//                                                   ),
//                                                   SizedBox(
//                                                     width: MySize.size4,
//                                                   ),
//                                                   Container(
//                                                     padding: EdgeInsets.only(
//                                                         top: 4.0),
//                                                     child: Text(
//                                                       "*",
//                                                       style: TextStyle(
//                                                           color: Colors.grey,
//                                                           fontSize: 11,
//                                                           fontWeight:
//                                                               FontWeight.w300),
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     "5 sets",
//                                                     style: TextStyle(
//                                                         color: Colors.grey,
//                                                         fontSize: 11,
//                                                         fontWeight:
//                                                             FontWeight.w300),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Expanded(child: Container()),
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   top: 5.0,
//                                                   right: MySize.size10),
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     snapshot.data[index]
//                                                             ['TotalCalories']
//                                                         .toStringAsFixed(1),
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize: 13,
//                                                         fontWeight:
//                                                             FontWeight.w500),
//                                                   ),
//                                                   SizedBox(width: 2),
//                                                   Text(
//                                                     "cal",
//                                                     style: TextStyle(
//                                                         color: Colors.grey,
//                                                         fontSize: 13,
//                                                         fontWeight:
//                                                             FontWeight.w300),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ));
//               } else if (snapshot.connectionState == ConnectionState.waiting) {
//                 return WorkOutShimmer();
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text('No Internet Connectivity'),
//                 );
//               }
//               return Container(
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Center(child: Text("Today No any workout")),
//                 ),
//               );
//               // return WorkOutShimmer();
//             })
//       ],
//     );
//   }
// // ############################ PSYCHOLOGICAL SECTION #################################
//
//   Widget psychologicalSection(Meditation meditation, MindPlans plans) {
//     List psychologicalData = [
//       {
//         "title": "Cognitive Behavior Therapy",
//         "subtitle": "Healthy mind healthy you",
//         "icon": "assets/images/meditation.png",
//         // "route": VideoWidget(url: '${meditation.videoFile}', play: true)
//         "route": Video(url: '${meditation.videoFile}', play: true)
//       },
//       {
//         "title": "Meditation",
//         "subtitle": "7 values",
//         "icon": "assets/images/exercise.png",
//         "route": NewMeditation(),
//         // "route": MeditationViewMind(plans['PlanImage'],"", plans['MindPlanId'], 4,)
//       },
//     ];
//
//     return Padding(
//       padding: const EdgeInsets.only(left: 150,right: 150),
//       child: GridView.builder(
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: MySize.size300,
//               childAspectRatio: 3 / 2,
//               crossAxisSpacing: MySize.size7,
//               mainAxisSpacing: MySize.size100),
//           itemCount: psychologicalData.length,
//           itemBuilder: (BuildContext ctx, index) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return psychologicalData[index]["route"];
//                 }));
//                 // } else {
//                 //   getMind();
//                 //   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 //     return psychologicalData[index]["route"];
//                 //   }));
//               },
//               child: Container(
//                 margin: index == 0
//                     ? EdgeInsets.only(
//                         left: MySize.size14,
//                         // right: MySize.size5,
//                       )
//                     : EdgeInsets.only(right: MySize.size14),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: Color(0xffDFDFDF),
//                   ),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.only(
//                     top: MySize.size10,
//                   ),
//                   child: Column(
//                     children: [
//                       Image.asset(
//                         psychologicalData[index]["icon"],
//                         // width: index == 4 ? 300 : 200,
//                         // height: index == 4 ? 300 : 200,
//                       ),
//                       index % 2 == 0
//                           ? SizedBox(
//                               height: MySize.size15,
//                             )
//                           : SizedBox(
//                               height: MySize.size15,
//                             ),
//                       GestureDetector(
//                         onTap: () {},
//                         child: Container(
//                           // padding: EdgeInsets.only(left: 10),
//                           width: double.infinity,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               DDText(
//                                 // title: plan.title,
//                                 title: psychologicalData[index]["title"],
//                                 center: true,
//                                 size: MySize.size11,
//                                 weight: FontWeight.w600,
//                               ),
//                               index == 0
//                                   ? Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(top: 3.0),
//                                           child: DDText(
//                                             title: psychologicalData[index]
//                                                 ["subtitle"],
//                                             center: true,
//                                             size: MySize.size11,
//                                             weight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   : Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         DDText(
//                                           title: '',
//                                           // title:psychologicalData[index]["title"],
//                                           center: true,
//                                           size: MySize.size11,
//                                           weight: FontWeight.w300,
//                                         ),
//                                         SizedBox(
//                                           width: MySize.size4,
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.only(top: 4.0),
//                                           child: Text(
//                                             "",
//                                             style: TextStyle(
//                                                 fontSize: 11,
//                                                 fontWeight: FontWeight.w300),
//                                           ),
//                                         ),
//                                         Text(
//                                           // "${plan.duration} min",
//                                           "10 min",
//                                           style: TextStyle(
//                                               fontSize: 11,
//                                               fontWeight: FontWeight.w300),
//                                         ),
//                                       ],
//                                     ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
//
//   // ############################ BLOG SECTION #################################
//
//   Widget blogSection(List<dynamic> blogs) {
//     return Padding(
//       padding: EdgeInsets.only(
//           left: MySize.size6, bottom: MySize.size30, right: MySize.size14),
//       child: Column(
//         children: [
//           ListView.builder(
//             shrinkWrap: true,
//             //physics: NeverScrollableScrollPhysics(),
//             itemCount: blogs.length,
//             itemBuilder: (context, i) {
//               return InkWell(
//                 onTap: () {
//                   Get.to(() => ArticleDetails(
//                       blogs[i].id,
//                       blogs[i].title,
//                       blogs[i].description,
//                       '$imageBaseUrl${blogs[i].fileName}',
//                       blogs[i].createdAt,
//                       blogs));
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   //   return ArticleDetails(
//                   //       blogs[i].title,
//                   //       blogs[i].description,
//                   //       '$imageBaseUrl${blogs[i].fileName}',
//                   //       blogs[i].createdAt,
//                   //       blogs);
//                   // }));
//                 },
//                 child: Card(
//                   margin: EdgeInsets.only(
//                     left: MySize.size10,
//                     top: MySize.size5,
//                     bottom: MySize.size5,
//                   ),
//                   elevation: 0,
//                   child: Row(
//                     // mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.grey[100],
//                                   spreadRadius: 1,
//                                   blurRadius: 0.2)
//                             ],
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                   child: Padding(
//                                 padding: EdgeInsets.only(
//                                     top: MySize.size8,
//                                     // bottom: MySize.size8,
//                                     left: MySize.size8,
//                                     right: MySize.size28),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding:
//                                           EdgeInsets.only(left: MySize.size8),
//                                       child: DDText(
//                                         line: 3,
//                                         title: blogs[i].title,
//                                         weight: FontWeight.w500,
//                                         center: null,
//                                         size: 15,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                               Container(
//                                 height: MySize.size100,
//
//                                 //width: MediaQuery.of(context).size.width / 3,
//                                 decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                         image: NetworkImage(
//                                           '$imageBaseUrl${blogs[i].fileName}',
//                                         ),
//                                         scale: 4,
//                                         fit: BoxFit.fitHeight)),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
