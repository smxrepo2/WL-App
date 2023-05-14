import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Controller/video_player.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/SettingScreen/searchlist.dart';
import 'package:weight_loser/screens/sleep_details/methods/methods.dart';
import 'package:weight_loser/screens/sleep_details/model/sleep_detail_model.dart';

import '../utils/AppConfig.dart';

class SleepDetail extends StatefulWidget {
  const SleepDetail({Key key}) : super(key: key);

  @override
  State<SleepDetail> createState() => _SleepDetailState();
}

class _SleepDetailState extends State<SleepDetail> {
  int sleepGoalHours = 0;
  DateTime now = DateTime.now();

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String selectindex;
  double avgSleepHours = 0;

  int _hr;
  int selectedValue = 1;
  Future<SleepDetailModel> _sleepDetailFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sleepDetailFuture = fetchSleepDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            title: null,
            backgroundColor: Colors.transparent,
          ),
        ),
        body: FutureBuilder<SleepDetailModel>(
          future: _sleepDetailFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              sleepGoalHours = snapshot.data.sleepTime;
              var sleepCount = snapshot.data.sleepcount.split(':');
              int hours = int.parse(sleepCount[1]);
              int minutes = int.parse(sleepCount[2]);
              double time = hours + minutes / 60;
              avgSleepHours = time / snapshot.data.sleepHistory.length;
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/OBJECTS.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5, top: 20),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Good night ${snapshot.data.profileVM.name}',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              // date in this format 15, September 2022

                              subtitle: Text(
                                  "${DateFormat('dd  MMMM,  yyyy').format(now)}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.white)),
                              trailing:
                                  Icon(Icons.more_vert, color: Colors.white),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.only(
                                  left: 15, bottom: 20, top: 20),
                              child: Text('Programming\nyour dream',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InfoCard(
                            title: '${sleepGoalHours} Hours',
                            subtitle: 'Sleep Goal',
                            icon: Icons.bedtime,
                            color: Color(0xff525970)),
                        InkWell(
                          onTap: () {
                            selectSleepHours(context).then((value) {
                              setState(() {
                                startTime = startTime;
                                endTime = endTime;
                              });
                            });
                          },
                          child: InfoCard(
                              title:
                                  '${startTime.format(context)}\n      - \n${endTime.format(context)}',
                              subtitle: 'Sleep Hours',
                              icon: Icons.timelapse,
                              color: Color(0xff0F2A4C)),
                        ),
                        InfoCard(
                            title: avgSleepHours.isNaN
                                ? '0 h'
                                : '${avgSleepHours.toStringAsFixed(1) ?? '0'} h',
                            subtitle: 'Avg Sleep',
                            icon: Icons.star,
                            color: Color(0xff525970)),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 15, bottom: 20, top: 20),
                      child: Text('Sleep better',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      height: 160,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: snapshot.data.meditation.length == 0
                          ? Center(
                              child: Text(
                              "No Data for Videos",
                              style: TextStyle(color: Colors.white),
                            ))
                          : ListView.builder(
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.meditation.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VideoWidget(
                                                url:
                                                    '$videosBaseUrl${snapshot.data.meditation[index].videoFile}',
                                                play: true,
                                                videoId: snapshot.data
                                                    .meditation[index].id)));
                                  },
                                  child: VideoBox(
                                      title:
                                          '${snapshot.data.meditation[index].title}',
                                      imagePath:
                                          '$imageBaseUrl${snapshot.data.meditation[index].imageFile}'),
                                );
                              }),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: Color(0xff0F3151),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Rate your Sleep',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(right: 25),
                              child: Text(
                                'Refreshing Sleep is good for Health',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  rateSleep(context).then((value) {
                                    //setState(() {
                                    //selectindex = selectindex;
                                    if (selectindex != null) {
                                      UIBlock.block(context);
                                      String time = getTimeDifference(
                                          '${startTime.hour}:${startTime.minute}',
                                          '${endTime.hour}:${endTime.minute}');
                                      setTrackTime(time, selectindex, context);
                                      print(
                                          "Start Time" + startTime.toString());
                                      print("End Time" + endTime.toString());
                                      print("Time" + time);
                                    }
                                    //});
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'RATE YOUR SLEEP',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.arrow_forward,
                                        color: Colors.white, size: 15),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Color(0xff0F2A4C),
                                  fixedSize: Size(175, 40),
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              );
            }
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()));
          },
        ));
  }

  Future<dynamic> rateSleep(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.black,
              title: Center(
                child: Text('Rate your sleep',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ),
              content: StatefulBuilder(builder: (context, setState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(sList.length + 1, (index) {
                    return index == sList.length
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Track',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                selectindex = sList[index].text;
                              });
                              print(selectindex);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              selectindex == sList[index].text
                                                  ? Colors.blueAccent
                                                  : Colors.transparent),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                              15.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Image.asset(sList[index].imageUrl)),
                                Text(sList[index].text,
                                    style: TextStyle(
                                        color: selectindex == sList[index].text
                                            ? Colors.blueAccent
                                            : Colors.white)),
                              ],
                            ),
                          );
                  }),
                );
              }),
            ));
  }

  Future<dynamic> selectSleepHours(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.black,
              title: Center(
                child: Text('Hours Sleep',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ),
              content: StatefulBuilder(builder: (context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    selectedTime(context, true, startTime, (x) {
                                      setState(() {
                                        startTime = x;
                                        print("The picked time is: $x");
                                      });
                                    });
                                  },
                                  child: Text(
                                    "${startTime.format(context)}",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              SizedBox(width: 20),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      //print(startTime);
                                      startTime = TimeOfDay.fromDateTime(
                                          DateFormat('hh:mm')
                                              .parse(
                                                  '${startTime.hour}:${startTime.minute}')
                                              .subtract(Duration(hours: 1)));
                                    });
                                  },
                                  child: Image.asset('assets/icons/minu.png'))
                            ],
                          ),
                          Image.asset('assets/icons/Starry window-bro (2).png',
                              width: 100, height: 100),
                          Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    selectedTime(context, true, endTime, (x) {
                                      setState(() {
                                        endTime = x;
                                        print("The picked time is: $x");
                                      });
                                    });
                                  },
                                  child: Text(
                                    "${endTime.format(context)}",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              SizedBox(width: 20),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      endTime = TimeOfDay.fromDateTime(DateFormat(
                                              'hh:mm')
                                          .parse(
                                              '${endTime.hour}:${endTime.minute}')
                                          .add(Duration(hours: 1)));
                                    });
                                  },
                                  child:
                                      Image.asset('assets/icons/plus12.png')),
                            ],
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: getTimeDifference(
                              '${startTime.hour}:${startTime.minute}',
                              '${endTime.hour}:${endTime.minute}'),
                          style: labelStyle(25, semiBold, Colors.white),
                          children: [
                            TextSpan(
                                text: " hr",
                                style: labelStyle(20, regular, Colors.white)),
                          ],
                        ),
                      ),
                      Text("of Sleep",
                          style: labelStyle(12, regular, Colors.grey)),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Set',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ));
  }
}

class VideoBox extends StatelessWidget {
  VideoBox({Key key, this.title, this.imagePath}) : super(key: key);

  String title;
  String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 150,
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black.withOpacity(0.25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, 10),
              child: Image.asset(
                'assets/icons/play_button.png',
                color: Color(0xffD3D6D6).withOpacity(0.69),
                width: 40,
                height: 40,
              ),
            ),
            Transform.translate(
              offset: Offset(-35, 40),
              child: Text(title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  InfoCard({Key key, this.title, this.subtitle, this.icon, this.color})
      : super(key: key);

  String title;
  String subtitle;
  IconData icon;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 175,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
        SizedBox(height: 20),
        Text(title,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)),
        SizedBox(height: 5),
        Text(subtitle,
            style: GoogleFonts.poppins(fontSize: 10, color: Colors.white))
      ]),
    );
  }
}

String getTimeDifference(String startTime, String endTime) {
  var dateFormat = DateFormat('hh:mm');
  DateTime durationStart = dateFormat.parse(startTime);
  DateTime durationEnd = dateFormat.parse(endTime);
  //var hdiff = durationEnd.difference(durationStart).inHours;
  //var mdiff = durationEnd.difference(durationStart).inMinutes;
  print('${durationEnd.hour}');
  var hdiff = durationEnd.hour - durationStart.hour;
  var mdiff = durationEnd.minute - durationStart.minute;
  print('$hdiff');
  if (hdiff < 0) hdiff = 24 - hdiff.abs();
  print('${hdiff.abs()}:${mdiff.abs()}');
  return '${hdiff.abs()}:${mdiff.abs()}';
}

Future setTrackTime(String time, String mood, context) async {
  //UIBlock.block(context);
  int userId;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userId = prefs.getInt('userid');

  var response = await post(
    Uri.parse('$apiUrl/api/diary'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      "userId": userId,
      "F_type_id": 7,
      "SleepTime": "$time",
      "SleepType": "$mood"
    }),
  );
  print("response:" + response.statusCode.toString());
  if (response.statusCode == 200) {
    UIBlock.unblock(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Track time saved successfully"),
      backgroundColor: Colors.green,
    ));
  }
}

class sleepList {
  String imageUrl;
  String text;

  sleepList({this.imageUrl, this.text});
}

List<sleepList> sList = [
  sleepList(imageUrl: 'assets/icons/sleeping (2).png', text: 'Deep'),
  sleepList(imageUrl: 'assets/icons/happy1.png', text: 'Refreshing'),
  sleepList(imageUrl: 'assets/icons/Group 17955.png', text: 'Moderate'),
  sleepList(imageUrl: 'assets/icons/sad.png', text: 'Not good'),
  sleepList(imageUrl: 'assets/icons/angry.png', text: 'Frustrating'),
];

Future selectedTime(BuildContext context, bool ifPickedTime,
    TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
  var _pickedTime =
      await showTimePicker(context: context, initialTime: initialTime);
  if (_pickedTime != null) {
    onTimePicked(_pickedTime);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay add({int hour = 0, int minute = 0}) {
    return this.replacing(hour: this.hour + hour, minute: this.minute + minute);
  }
}

// class SleepDetails extends StatefulWidget {
//   const SleepDetails({Key key}) : super(key: key);

//   @override
//   State<SleepDetails> createState() => _SleepDetailsState();
// }

// class _SleepDetailsState extends State<SleepDetails> {
//   TimeOfDay startTime = TimeOfDay.now();
//   TimeOfDay endTime = TimeOfDay.now();
//   String selectindex;

//   int _hr;
//   int selectedValue = 1;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;

//     //double _doubleStartTime =
//     //  startTime.hour.toDouble() + (startTime.minute.toDouble() / 60);
//     //double _doubleEndTime =
//     //  endTime.hour.toDouble() + (endTime.minute.toDouble() / 60);
//     //double _timeDiff = _doubleStartTime - _doubleEndTime;
//     //_hr = _timeDiff == null ? 0 : _timeDiff.truncate();

//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.grey),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: GestureDetector(
//             onTap: () {
//               Get.back();
//             },
//             child: Image.asset('assets/icons/back_arrow.png')),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 25, right: 25),
//           child: ListView(
//             physics: const BouncingScrollPhysics(
//                 parent: AlwaysScrollableScrollPhysics()),
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: height * .05,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Sleep",
//                     style: GoogleFonts.openSans(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w300,
//                         color: const Color(0xFF23233C)),
//                   ),
//                   DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                         value: selectedValue,
//                         items: [
//                           DropdownMenuItem(
//                             child: Text("Today"),
//                             value: 1,
//                           ),
//                           DropdownMenuItem(
//                             child: Text("Week"),
//                             value: 2,
//                           ),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             selectedValue = value;
//                           });
//                         }),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: height * .05,
//               ),
//               Text(
//                 "Goal Sleep",
//                 style: labelStyle(11, regular, queColor),
//               ),
//               SizedBox(height: height * .02),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "7h 8min",
//                     style: labelStyle(15, semiBold, queColor),
//                   ),
//                   Text("out of 8 hours of sleep",
//                       style: labelStyle(13, light, queColor)),
//                 ],
//               ),
//               SizedBox(height: height * .01),
//               Container(
//                 width: double.infinity,
//                 height: 7,
//                 color: Colors.grey[300],
//                 child: LinearPercentIndicator(
//                   // width: double.infinity,
//                   lineHeight: 5.0,
//                   percent: 0.70,
//                   padding: const EdgeInsets.all(0),
//                   backgroundColor: Colors.grey[300],
//                   progressColor: exBorder,
//                 ),
//               ),
//               SizedBox(height: height * .05),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Hours sleep",
//                     style: labelStyle(15, semiBold, queColor),
//                   ),
//                   Image.asset('assets/icons/watch_icon.png')
//                 ],
//               ),
//               SizedBox(height: height * .05),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                           onTap: () {
//                             selectedTime(context, true, startTime, (x) {
//                               setState(() {
//                                 startTime = x;
//                                 print("The picked time is: $x");
//                               });
//                             });
//                           },
//                           child: Text("${startTime.format(context)}")),
//                       SizedBox(width: 10),
//                       GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               //print(startTime);
//                               startTime = TimeOfDay.fromDateTime(DateFormat(
//                                       'hh:mm')
//                                   .parse(
//                                       '${startTime.hour}:${startTime.minute}')
//                                   .subtract(Duration(hours: 1)));
//                             });
//                           },
//                           child: Image.asset('assets/icons/minu.png'))
//                     ],
//                   ),
//                   Image.asset('assets/icons/Starry window-bro (2).png'),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               endTime = TimeOfDay.fromDateTime(DateFormat(
//                                       'hh:mm')
//                                   .parse('${endTime.hour}:${endTime.minute}')
//                                   .add(Duration(hours: 1)));
//                             });
//                           },
//                           child: Image.asset('assets/icons/plus12.png')),
//                       SizedBox(width: 10),
//                       GestureDetector(
//                           onTap: () {
//                             selectedTime(context, true, endTime, (x) {
//                               setState(() {
//                                 endTime = x;
//                                 print("The picked time is: $x");
//                               });
//                             });
//                           },
//                           child: Text("${endTime.format(context)}")),
//                     ],
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     getTimeDifference('${startTime.hour}:${startTime.minute}',
//                         '${endTime.hour}:${endTime.minute}'),
//                     style: labelStyle(25, semiBold, queColor),
//                   ),
//                   Text("hr", style: labelStyle(20, regular, queColor)),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("of Sleep", style: labelStyle(12, regular, queColor)),
//                 ],
//               ),
//               SizedBox(height: height * .05),
//               Text("Rate your sleep", style: labelStyle(11, regular, queColor)),
//               SizedBox(height: height * .03),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(sList.length, (index) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectindex = sList[index].text;
//                       });
//                       print(selectindex);
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: selectindex == sList[index].text
//                                       ? Colors.blueAccent
//                                       : Colors.transparent),
//                               borderRadius: const BorderRadius.all(
//                                   Radius.circular(
//                                       15.0) //                 <--- border radius here
//                                   ),
//                             ),
//                             child: Image.asset(sList[index].imageUrl)),
//                         Text(sList[index].text)
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//               SizedBox(height: height * .05),
//               Padding(
//                 padding: const EdgeInsets.only(left: 100, right: 100),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (selectedValue != null) UIBlock.block(context);
//                     setTrackTime(
//                         getTimeDifference(
//                             '${startTime.hour}:${startTime.minute}',
//                             '${endTime.hour}:${endTime.minute}'),
//                         selectindex,
//                         context);
//                     print(startTime);
//                     print(endTime);
//                     print(selectindex);

//                     //print(_hr);
//                   },
//                   style: ElevatedButton.styleFrom(
//                       primary: primaryColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30))),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 10, right: 10, top: 5, bottom: 5),
//                     child: Text("Track"),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
