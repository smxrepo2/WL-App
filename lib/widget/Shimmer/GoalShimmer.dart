import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/constants/constant.dart';

import '../../Controller/HomePageData.dart';

class GoalShimmer extends StatelessWidget {
  const GoalShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            circularProgress("Carbs", Color(0xffDFBB9D), 0, 0),
            circularProgress("Fat", Color(0xffFFD36E), 0, 0),
            circularProgress("Protein", Color(0xffFF8C8C), 0, 0),
            circularProgress("Calories", Color(0xffE6D1F8), 0, 0),
          ],
        ));
    /*
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.only(
        left: MySize.size20,
      ),
      padding: EdgeInsets.only(
        left: MySize.size4,
        right: MySize.size26,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DDText(
                    title: "Goal",
                    size: 15,
                    weight: FontWeight.w500,
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Countup(
                        begin: 0,
                        end: 0,
                        duration: Duration(seconds: 1),
                        separator: ',',
                        style: GoogleFonts.openSans(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(height: MySize.size10),
                  SizedBox(
                    width: MySize.size34,
                    child: const StepProgressIndicator(
                      totalSteps: 100,
                      direction: Axis.horizontal,
                      currentStep: 100,
                      padding: 0,
                      selectedColor: primaryColor,
                      unselectedColor: Colors.black12,
                      progressDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: MySize.size10),
                    child: Image.asset("assets/icons/minus.png"),
                  ),
                  Text("")
                ],
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: MySize.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DDText(
                      title: "Food",
                      size: 15,
                    ),
                    Countup(
                      begin: 0,
                      end: 100,
                      duration: Duration(seconds: 1),
                      separator: ',',
                      style: GoogleFonts.openSans(
                          fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: MySize.size10),
                    SizedBox(
                      width: MySize.size36,
                      child: const StepProgressIndicator(
                        totalSteps: 10,
                        direction: Axis.horizontal,
                        currentStep: 2,
                        padding: 0,
                        selectedColor: primaryColor,
                        unselectedColor: Colors.black12,
                        progressDirection: TextDirection.ltr,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MySize.size10,
                        left: MySize.size2,
                        right: MySize.size8),
                    child: Image.asset("assets/icons/plus.png"),
                  ),
                  Text("")
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  DDText(
                    title: "Exercise",
                    size: 15,
                  ),
                  Countup(
                    begin: 0,
                    end: 0,
                    duration: Duration(seconds: 1),
                    separator: ',',
                    style: GoogleFonts.openSans(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MySize.size10),
                  SizedBox(
                    width: MySize.size56,
                    child: const StepProgressIndicator(
                      totalSteps: 10,
                      direction: Axis.horizontal,
                      currentStep: 2,
                      padding: 0,
                      selectedColor: primaryColor,
                      unselectedColor: Colors.black12,
                      progressDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MySize.size10,
                        left: MySize.size10,
                        right: MySize.size6),
                    child: DDText(
                      title: "=",
                      size: MySize.size18,
                    ),
                  ),
                  Text("")
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  DDText(
                    title: "Calories Left",
                    size: MySize.size15,
                  ),
                  Countup(
                    begin: 0,
                    end: 1,
                    duration: Duration(seconds: 1),
                    separator: ',',
                    style: GoogleFonts.openSans(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MySize.size10,
                      ),
                      SizedBox(
                        width: MySize.size84,
                        child: const StepProgressIndicator(
                          totalSteps: 10,
                          direction: Axis.horizontal,
                          currentStep: 0,
                          padding: 0,
                          selectedColor: primaryColor,
                          unselectedColor: Colors.black12,
                          progressDirection: TextDirection.ltr,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  */
  }
}
