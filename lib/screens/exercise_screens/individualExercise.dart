import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Controller/video_player.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/models/active_diet_plan_model.dart';
import 'package:weight_loser/models/exercise_plan_model.dart';
import 'package:weight_loser/models/favourite_model.dart';
import 'package:weight_loser/screens/navigation_tabs/ExerciseSceen.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

import '../groupExercise/screens/exerciseTimer.dart';

class IndividualExercise extends StatefulWidget {
  final String name, path;
  final int days;

  final double distance;
  final bool run;

  IndividualExercise(
      {this.path, this.distance, this.run, this.name, this.days});

  @override
  _IndividualExerciseState createState() => _IndividualExerciseState();
}

class _IndividualExerciseState extends State<IndividualExercise>
    with TickerProviderStateMixin {
  SimpleFontelicoProgressDialog _dialog;

  addExercise(int typeId, Burners burner, BuildContext context) {
    print("calories ${burner.calories}");
    post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userid,
        "F_type_id": typeId,
        "Duration": burner.duration,
        "BurnerId": burner.burnerId,
        "Burn_Cal": burner.calories
      }),
    ).then((value) {
      if (value.statusCode == 200) {
        final snackBar = SnackBar(
          content: Text(
            'Exercise Added',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightGreen,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text(
            "Unable to add exercise",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }).onError((error, stackTrace) {
      final snackBar = SnackBar(
        content: Text(
          error.toString(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Color selectedBgColor = Colors.blue;
  Color selectedTextColor = Colors.white;
  Color unSelectedBgColor = Colors.grey[100];
  Color unSelectedTextColor = Colors.black;

  int userid;

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    double margin = height * 0.01;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: CustomDrawer(),
        // appBar: customAppBar(
        //   context,
        // ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Responsive1.isMobile(context)
              ? customAppBar(
                  context,
                )
              : Padding(padding: EdgeInsets.only(top: 5)),
        ),
        body: Padding(
          padding: Responsive1.isMobile(context)
              ? const EdgeInsets.all(8.0)
              : const EdgeInsets.all(15.0),
          child: Container(
            child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: height * 0.25,
                    child: Stack(
                      children: [
                        Image.network(
                          widget.path,
                          fit: BoxFit.cover,
                          height: height * 0.3,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              widget.name,
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
                  margin: EdgeInsets.fromLTRB(margin, 10, 0, 10),
                  child: Text(
                    "Days",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      left: height * 0.025,
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.08,
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
                                color: selectedBgColor),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DDText(
                                    title: "Day",
                                    size: 11,
                                    weight: FontWeight.w300,
                                    color: selectedTextColor,
                                  ),
                                  DDText(
                                      title: (widget.days).toString(),
                                      size: 11,
                                      weight: FontWeight.w300,
                                      color: selectedTextColor),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                SizedBox(height: 20),
                Container(
                    margin: EdgeInsets.fromLTRB(margin, 0, margin, margin),
                    child: ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      /* VideoPlayerController videoController= VideoPlayerController.network('$videosBaseUrl${sets[index].videoFile}');

                                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                        return VideoItem(videoPlayerController: videoController,
                                          looping: false,
                                          autoplay: true,
                                        );
                                      }));*/
                                      Get.to(() => ExerciseTimer(
                                          day: widget.days,
                                          distance: widget.distance,
                                          run: widget.run));
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.fromLTRB(0, 0, margin, 0),
                                      height: height * 0.12,
                                      width: MediaQuery.of(context).size.width *
                                          0.18,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                '${widget.path}',
                                              ))),
                                    ),
                                  ),
                                  Container(
                                      height: height * 0.12,
                                      width: Responsive1.isMobile(context)
                                          ? MediaQuery.of(context).size.width -
                                              (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.31)
                                          : MediaQuery.of(context).size.width *
                                              0.3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${widget.name}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[700],
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Text(
                                                "1 minute",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color: Colors.blue,
                                              )
                                            ],
                                          ),
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
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
