import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Controller/video.dart';
import 'package:weight_loser/Controller/video_player.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Mind%20_service.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/Today_api.dart';
import 'package:weight_loser/models/active_mind.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/DietInnerTab.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

class NewMeditation extends StatefulWidget {
  // List<ActiveMindPlan> plan;
  // NewMeditation(this.plan);

  @override
  _NewMeditationState createState() => _NewMeditationState();
}

class _NewMeditationState extends State<NewMeditation> {
  int userid;
  int dayNumber = 1;
  bool isActive = false;
  List<bool> day = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMindPlanDetail();
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var orientation = MediaQuery.of(context).orientation;
    double margin = height * 0.02;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Responsive1.isMobile(context)
            ? customAppBar(
                context,
              )
            : Padding(padding: EdgeInsets.only(top: 5)),
      ),
      // appBar: customAppBar(
      //   context,
      // ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: fetchMindPlanDetail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: height * 0.25,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.fromLTRB(margin, margin, 0, 0),
                          child: Text(
                            "Days",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                  );
                } else if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  // List<CtiveMindPlanVMs> posts =
                  //     snapshot.data.length;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: height * 0.25,
                            child: Stack(
                              children: [
                                ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.darken),
                                  child: Image.network(
                                    '$imageBaseUrl${snapshot.data[0]['PlanImage']}' ??
                                        "https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                    fit: BoxFit.cover,
                                    height: height * 0.3,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.fromLTRB(margin, margin, 0, 0),
                          child: Text(
                            "Days",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            margin: EdgeInsets.only(
                              left: height * 0.025,
                            ),
                            height: orientation == Orientation.landscape
                                ? MediaQuery.of(context).size.height * 0.09
                                : MediaQuery.of(context).size.height * 0.06,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: int.parse(snapshot.data[0]['Day']),
                              itemBuilder: (BuildContext context, int index) {
                                print(snapshot.data[0]['PlanTitle']);
                                return InkWell(
                                  onTap: () {
                                    for (int i = 0; i < day.length; i++) {
                                      setState(() {
                                        day[i] = false;
                                      });
                                    }
                                    setState(() {
                                      day[index] = true;
                                      dayNumber = index + 1;
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    padding: EdgeInsets.only(
                                      top: MySize.size4,
                                      bottom: MySize.size4,
                                    ),
                                    // padding: EdgeInsets.fromLTRB(height * 0.001,
                                    //     height * 0.018, height * 0.002, height * 0.015),
                                    margin: EdgeInsets.only(
                                      right: height * 0.025,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: snapshot.data[0]['day'] != null
                                            ? selectedBgColor
                                            : unSelectedBgColor),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          DDText(
                                            title: "Day",
                                            size: 11,
                                            weight: FontWeight.w300,
                                            color:
                                                snapshot.data[0]['day'] != null
                                                    ? selectedTextColor
                                                    : unSelectedTextColor,
                                          ),
                                          DDText(
                                            title: (index + 1).toString(),
                                            size: 11,
                                            weight: FontWeight.w300,
                                            color:
                                                snapshot.data[0]['day'] != null
                                                    ? selectedTextColor
                                                    : unSelectedTextColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                        SizedBox(height: 20),
                        ListView.builder(
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  new Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => VideoWidget(
                                            url:
                                                '$videosBaseUrl${snapshot.data[index]['VideoFile']}',
                                            play: true,
                                            videoId: snapshot.data[index]
                                                ['vidId']));
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        //   return VideoWidget(url:'${post.videoFile}', play: true);
                                        // }));
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, margin, 0),
                                                height: height * 0.12,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.18,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          '$imageBaseUrl${snapshot.data[index]['PlanImage']}',
                                                          // '$imageBaseUrl${post.planImage}',
                                                        ))),
                                              ),
                                              Container(
                                                  height: orientation ==
                                                          Orientation.landscape
                                                      ? height * 0.21
                                                      : height * 0.12,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.3),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            snapshot.data[index]
                                                                    ['Title'] ??
                                                                "",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .grey[700],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                          Text(
                                                            "${snapshot.data[index]['Duration']} min",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                          Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.blue,
                                                          ),
                                                          Text("")
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                Icons.favorite,
                                                                color: isActive ==
                                                                        false
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                            thickness: 0.3,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            })

                        // new Column(
                        //     children: posts
                        //         .map((post) => new Column(
                        //               children: <Widget>[
                        //                 new Padding(
                        //                   padding: EdgeInsets.fromLTRB(
                        //                       0, 0, 0, 0),
                        //                   child: InkWell(
                        //                     onTap: () {
                        //                       Get.to(() => VideoWidget(
                        //                           url: '$videosBaseUrl${post.videoFile}',
                        //                           play: true));
                        //                       // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //                       //   return VideoWidget(url:'${post.videoFile}', play: true);
                        //                       // }));
                        //                     },
                        //                     child: Column(
                        //                       children: [
                        //                         Row(
                        //                           children: [
                        //                             Container(
                        //                               margin: EdgeInsets
                        //                                   .fromLTRB(0, 0,
                        //                                       margin, 0),
                        //                               height: height * 0.12,
                        //                               width: MediaQuery.of(
                        //                                           context)
                        //                                       .size
                        //                                       .width *
                        //                                   0.18,
                        //                               decoration:
                        //                                   BoxDecoration(
                        //                                       borderRadius:
                        //                                           BorderRadius
                        //                                               .circular(
                        //                                                   15),
                        //                                       image: DecorationImage(
                        //                                           fit: BoxFit.cover,
                        //                                           image: NetworkImage(
                        //                                             '$imageBaseUrl${snapshot.data.ctiveMindPlanVMs[0].planImage}',
                        //                                             // '$imageBaseUrl${post.planImage}',
                        //                                           ))),
                        //                             ),
                        //                             Container(
                        //                                 height:
                        //                                     height * 0.12,
                        //                                 width: MediaQuery.of(
                        //                                             context)
                        //                                         .size
                        //                                         .width -
                        //                                     (MediaQuery.of(
                        //                                                 context)
                        //                                             .size
                        //                                             .width *
                        //                                         0.3),
                        //                                 child: Row(
                        //                                   mainAxisAlignment:
                        //                                       MainAxisAlignment
                        //                                           .spaceBetween,
                        //                                   children: [
                        //                                     Column(
                        //                                       crossAxisAlignment:
                        //                                           CrossAxisAlignment
                        //                                               .start,
                        //                                       mainAxisAlignment:
                        //                                           MainAxisAlignment
                        //                                               .end,
                        //                                       children: [
                        //                                         Text(
                        //                                           post.title??"",
                        //                                           style: TextStyle(
                        //                                               fontSize:
                        //                                                   15,
                        //                                               color: Colors.grey[
                        //                                                   700],
                        //                                               fontWeight:
                        //                                                   FontWeight.w300),
                        //                                         ),
                        //                                         Text(
                        //                                           "${post.duration} min",
                        //                                           style: TextStyle(
                        //                                               fontSize:
                        //                                                   12,
                        //                                               color: Colors
                        //                                                   .grey,
                        //                                               fontWeight:
                        //                                                   FontWeight.w300),
                        //                                         ),
                        //                                         Icon(
                        //                                           Icons
                        //                                               .play_arrow,
                        //                                           color: Colors
                        //                                               .blue,
                        //                                         ),
                        //                                         Text("")
                        //                                       ],
                        //                                     ),
                        //                                     Column(
                        //                                       crossAxisAlignment:
                        //                                           CrossAxisAlignment
                        //                                               .start,
                        //                                       mainAxisAlignment:
                        //                                           MainAxisAlignment
                        //                                               .center,
                        //                                       children: [
                        //                                         Text(
                        //                                           "",
                        //                                           style: TextStyle(
                        //                                               fontSize:
                        //                                                   15,
                        //                                               color: Colors
                        //                                                   .black,
                        //                                               fontWeight:
                        //                                                   FontWeight.w300),
                        //                                         ),
                        //                                         Row(
                        //                                           mainAxisAlignment:
                        //                                               MainAxisAlignment
                        //                                                   .start,
                        //                                           children: [
                        //                                             Icon(
                        //                                               Icons
                        //                                                   .favorite,
                        //                                               color: isActive == false
                        //                                                   ? Colors.red
                        //                                                   : Colors.grey,
                        //                                             ),
                        //                                             SizedBox(
                        //                                               width:
                        //                                                   10,
                        //                                             ),
                        //                                           ],
                        //                                         ),
                        //                                       ],
                        //                                     )
                        //                                   ],
                        //                                 )),
                        //                           ],
                        //                         ),
                        //                         Divider(
                        //                           color: Colors.grey,
                        //                           thickness: 0.3,
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 )
                        //               ],
                        //             ))
                        //         .toList()),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Container(
                  child: Center(
                    child: Text('No any Plan active'),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Container dayRowUpdated(double margin, double height) {
    return Container(
        margin: EdgeInsets.only(top: margin, left: margin),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  for (int i = 0; i < day.length; i++) {
                    setState(() {
                      day[i] = false;
                    });
                  }
                  setState(() {
                    day[0] = true;
                  });
                },
                child: dayNumberUpdated(height, "1", 0),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < day.length; i++) {
                      setState(() {
                        day[i] = false;
                      });
                    }
                    setState(() {
                      day[1] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "2", 1)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < day.length; i++) {
                      setState(() {
                        day[i] = false;
                      });
                    }
                    setState(() {
                      day[2] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "3", 2)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < day.length; i++) {
                      setState(() {
                        day[i] = false;
                      });
                    }
                    setState(() {
                      day[3] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "4", 3)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < day.length; i++) {
                      setState(() {
                        day[i] = false;
                      });
                    }
                    setState(() {
                      day[4] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "5", 4)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < day.length; i++) {
                      setState(() {
                        day[i] = false;
                      });
                    }
                    setState(() {
                      day[5] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "6", 5)),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    for (int i = 0; i < day.length; i++) {
                      setState(() {
                        day[i] = false;
                      });
                    }
                    setState(() {
                      day[6] = true;
                    });
                  },
                  child: dayNumberUpdated(height, "7", 6)),
            ),
          ],
        ));
  }

  Container dayNumberUpdated(double height, number, index) {
    return Container(
      padding: EdgeInsets.only(
        top: MySize.size4,
        bottom: MySize.size4,
      ),
      // padding: EdgeInsets.fromLTRB(height * 0.001,
      //     height * 0.018, height * 0.002, height * 0.015),
      margin: EdgeInsets.only(
        right: height * 0.025,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: day[index] ? selectedBgColor : unSelectedBgColor),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DDText(
              title: "Day",
              size: 11,
              weight: FontWeight.w300,
              color: day[index] ? selectedTextColor : unSelectedTextColor,
            ),
            DDText(
              title: number,
              size: 11,
              weight: FontWeight.w300,
              color: day[index] ? selectedTextColor : unSelectedTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
