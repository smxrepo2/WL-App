import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/Setting_screen_api.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/SettingScreen/personal_setting.dart';
import 'package:weight_loser/screens/SettingScreen/profile.dart';
import 'package:weight_loser/screens/SettingScreen/profile_setting.dart';
import 'package:weight_loser/screens/SettingScreen/reminder_setting.dart';
import 'package:weight_loser/screens/SettingScreen/search.dart';
import 'package:weight_loser/screens/SettingScreen/search_food.dart';
import 'package:weight_loser/screens/SettingScreen/unit_setting.dart';
import 'package:weight_loser/screens/SettingScreen/water_setting.dart';
import 'package:weight_loser/screens/choose_your_plan.dart';
import 'package:weight_loser/screens/story/profilePage.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/SideMenu.dart';

import 'components.dart';

import 'exercise_setting.dart';
import 'meal_setting.dart';
import 'mind_setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key, @required this.navigateToStory})
      : super(key: key);
  final bool navigateToStory;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.navigateToStory)
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => ProfilePage()));
        else
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => BottomBarNew(0)));
      },
      child: Scaffold(
        body: Responsive1.isMobile(context)
            ? mobileList(context)
            : ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SettingCard(
                        image: 'assets/svg_icons/profile_svg.svg',
                        option: 'Profile',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileSetting()));
                        },
                      ),
                      SettingCard(
                        image: 'assets/svg_icons/personal_svg.svg',
                        option: 'Personal',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonalSetting()));
                        },
                      ),
                      SettingCard(
                        image: 'assets/svg_icons/meal_svg.svg',
                        option: 'Meal',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MealSetting()));
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SettingCard(
                        image: 'assets/svg_icons/exercise_svg.svg',
                        option: 'Exercise',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExerciseSetting()));
                        },
                      ),
                      SettingCard(
                        image: 'assets/svg_icons/mind_svg.svg',
                        option: 'Mind',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MindSetting()));
                        },
                      ),
                      /*
                      SettingCard(
                        image: 'assets/svg_icons/water_svg.svg',
                        option: 'Water',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WaterSetting()));
                        },
                      ),
                      */
                      SettingCard(
                        image: 'assets/svg_icons/reminder_svg.svg',
                        option: 'Reminders',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReminderSetting()));
                        },
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
    // );
  }

  ListView mobileList(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                  onTap: () {
                    //Get.back();
                    //Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomBarNew(0)));
                  },
                  child: Image.asset('assets/icons/back_arrow.png')),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Setting',
                  style:
                      GoogleFonts.montserrat(fontSize: 15, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset('assets/icons/search_icon.png'),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        rowWithForwardIcon(
            onTap: () {
              Get.to(() => ProfileSetting());
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ProfileSetting()));
            },
            context: context,
            option: 'Profile',
            image: 'assets/svg_icons/profile_svg.svg'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        rowWithForwardIcon(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PersonalSetting()));
            },
            context: context,
            option: 'Personal',
            image: 'assets/svg_icons/personal_svg.svg'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        rowWithForwardIcon(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MealSetting()));
            },
            context: context,
            option: 'Meal',
            image: 'assets/svg_icons/meal_svg.svg'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        rowWithForwardIcon(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExerciseSetting()));
            },
            context: context,
            option: 'Exercise',
            image: 'assets/svg_icons/exercise_svg.svg'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        rowWithForwardIcon(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MindSetting()));
            },
            context: context,
            option: 'Mind',
            image: 'assets/svg_icons/mind_svg.svg'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        /*
        rowWithForwardIcon(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WaterSetting()));
            },
            context: context,
            option: 'Water',
            image: 'assets/svg_icons/water_svg.svg'),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.02,
        // ),
        // rowWithForwardIcon(
        //     onTap: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => Profile()));
        //     },
        //     context: context,
        //     option: 'Follow-up',
        //     image: 'assets/icons/followup_icon.png'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        */
        rowWithForwardIcon(
          image: 'assets/svg_icons/reminder_svg.svg',
          option: 'Reminders',
          context: context,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReminderSetting()));
          },
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.02,
        // ),
        // rowWithForwardIcon(
        //   image: 'assets/svg_icons/unit_svg.svg',
        //   option: 'Units & Measures',
        //   context: context,
        //   onTap: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => UnitSetting()));
        //   },
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        rowWithForwardIcon(
            onTap: () {
              getUserExpiry();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => SearchFoodData()));
            },
            context: context,
            option: 'Payment',
            image: 'assets/svg_icons/payment_svg.svg'),
      ],
    );
  }

  var expiry;
  Future<Map<String, dynamic>> getUserExpiry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/user/expiry/$userid'),
    );
    print("response ${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      if (response.statusCode == 200 &&
          !response.body.toString().contains("{response:Expired}")) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Your Subscription is Expired")));
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>ChoosePlan()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Your Subscription is Valid")));
      }
    } else {
      throw Exception('Unable to Load');
    }
  }
}

class SettingCard extends StatelessWidget {
  @required
  String image;
  @required
  String option;
  @required
  Function() onTap;
  SettingCard({this.image, this.onTap, this.option});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset(image), Text(option)],
          ),
        ),
      ),
    );
  }
}
