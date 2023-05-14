import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Component/DDText.dart';

import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/screens/CoachesList.dart';
import 'package:weight_loser/screens/profile/EditProfile.dart';
import 'package:weight_loser/utils/AppConfig.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int userid;

  Future<DashboardModel> fetchDashboardData() async {
    print("USER ID FOR DASHBOARD IS $userid");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('userid') != null) {
      userid = prefs.getInt('userid');
      print('hello $userid');
    }

    final response = await get(
      Uri.parse('$apiUrl/api/dashboard/$userid'),
    );
    print("response ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      DashboardModel _dbm = DashboardModel.fromJson(jsonDecode(response.body));
      return _dbm;
    } else {
      throw Exception('Failed to load dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    bool isSwitched = true;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: DDText(
          title: "Settings",
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  FutureBuilder<DashboardModel>(
                    future: fetchDashboardData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return UserProfile(snapshot.data.profileVM);
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('No Internet Connectivity'),
                        );
                      }

                      // By default, show a loading spinner.
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.only(left: MySize.size10),
                  //       child: Row(
                  //         children: [
                  //           Card(
                  //             elevation: 2,
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius:
                  //                     BorderRadius.circular(MySize.size100)),
                  //             child: Container(
                  //               child: SizedBox(
                  //                 height: MySize.size80,
                  //                 width: MySize.size80,
                  //                 child: Stack(
                  //                   clipBehavior: Clip.none,
                  //                   fit: StackFit.expand,
                  //                   children: [
                  //                     Container(
                  //                       padding: EdgeInsets.all(MySize.size6),
                  //                       child: CircleAvatar(
                  //                         backgroundImage: AssetImage(
                  //                             "assets/images/profile3.jpg"),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               DDText(title: "Don Watson"),
                  //               DDText(
                  //                 title: "donwatson@gmail.com",
                  //                 color: Colors.grey,
                  //               )
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(child: Container()),
                  //     Padding(
                  //       padding: EdgeInsets.only(right: MySize.size16),
                  //       child: Container(
                  //         child: IconButton(
                  //           icon: ImageIcon(
                  //             AssetImage(
                  //               "assets/icons/edit.png",
                  //             ),
                  //           ),
                  //           onPressed: () {
                  //             Get.to(EditProfile());
                  //             // Navigator.push(context,
                  //             //     MaterialPageRoute(builder: (context) {
                  //             //   return EditProfile();
                  //             // }));
                  //           },
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: MySize.size20,
                  ),
                  Divider(
                    thickness: 1,
                    // color: Colors.grey,
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Image.asset(
                          "assets/icons/settings_goal.png",
                        ),
                        title: Text("Goals"),
                        trailing: Icon(Icons.chevron_right),
                      ),
                      SizedBox(
                        height: MySize.size16,
                      ),
                      ListTile(
                        leading: ImageIcon(
                          AssetImage(
                            "assets/icons/pushnotification.png",
                          ),
                        ),
                        title: Text("Push Notifications"),
                        trailing: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                              });
                            },
                            activeTrackColor: Colors.blue[100],
                            activeColor: Colors.blueAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MySize.size16,
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(() => CoachesList());
                          // var route = MaterialPageRoute(
                          //     builder: (context) => CoachesList());
                          // Navigator.push(context, route);
                        },
                        leading: Icon(
                          Icons.phone,
                          color: Colors.grey[400],
                        ),
                        title: Text(
                          "Coach",
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                        ),
                      ),
                      SizedBox(
                        height: MySize.size16,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.payment,
                          color: Colors.grey[400],
                        ),
                        title: Text("Payment"),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(MySize.size20),
                    margin: EdgeInsets.only(
                        left: MySize.size20,
                        right: MySize.size20,
                        bottom: MySize.size4),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300])),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DDText(
                                  title: "Version",
                                  size: MySize.size14,
                                  weight: FontWeight.w300,
                                ),
                                DDText(
                                  title: "2.0.12",
                                  size: MySize.size12,
                                  weight: FontWeight.w300,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MySize.size8,
                        ),
                        Row(
                          children: [
                            DDText(
                              title: "Terms & Conditions",
                              weight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(MySize.size14),
                    margin: EdgeInsets.only(
                        left: MySize.size20,
                        right: MySize.size20,
                        bottom: MySize.size20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300])),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            DDText(
                              title: "About Us",
                              weight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container UserProfile(ProfileVM profile) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(left: MySize.size10),
            child: Row(
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MySize.size100)),
                  child: Container(
                    child: SizedBox(
                      height: MySize.size80,
                      width: MySize.size80,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          Container(
                            padding: EdgeInsets.all(MySize.size6),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/profile3.jpg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DDText(title: profile.name),
                    DDText(
                      title: profile.email,
                      color: Colors.grey,
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.only(right: MySize.size16),
            child: Container(
              child: IconButton(
                icon: ImageIcon(
                  AssetImage(
                    "assets/icons/edit.png",
                  ),
                ),
                onPressed: () {
                  Get.to(EditProfile(email: profile.email, name: profile.name));
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return EditProfile();
                  // }));
                },
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
