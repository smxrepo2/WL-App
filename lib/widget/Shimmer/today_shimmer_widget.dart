import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timelines/timelines.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Controller/HomePageData.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/utils/ImagePath.dart';

import 'BlogShimmer.dart';
import 'WorkOutShimmer.dart';
import '../SizeConfig.dart';
import 'WorkOutShimmer.dart';

class TodayShimmerWidget extends StatelessWidget {
  const TodayShimmerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Column(
        children: [
          // Profileshimmer(),
          // const Divider(
          //   color: Colors.transparent,
          // ),
          // SizedBox(height: MySize.size16),
          // GoalShimmer(),
          // SizedBox(
          //   height: SizeConfig.safeBlockVertical * 4,
          // ),
          Container(
            padding: EdgeInsets.only(
              top: MySize.size30,
            ),
            child: Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(right: MySize.size4, left: MySize.size6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      waterLeft( ImagePath.glass, "Water", "1 cup",
                          "- -", context),
                      SizedBox(
                        height: MySize.size10,
                      ),
                      waterLeft( ImagePath.glass, "Water", "1 cup",
                          "- -", context),
                    ],
                  ),
                ),
                addFoodDivider(1, "Breakfast"),
                Container(
                  padding: EdgeInsets.only(
                    left: MySize.size16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      waterRight( ImagePath.glass, "Water", "1 cup",
                          "- -", context),
                      SizedBox(
                        height: MySize.size10,
                      ),
                      waterRight( ImagePath.glass, "Water", "1 cup",
                          "- -", context),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 5,
          ),
          WorkOutShimmer(),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 2,
          ),
          BlogShimmer()
        ],
      ),
    );
  }

  Widget addFoodDivider(int typeId, type) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: MySize.size30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DDText(
            title: "Suggest",
            size: MySize.size11,
            color: primaryColor,
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 30.0,
            child: SolidLineConnector(),
          ),
          DDText(
            title: "Add Food",
            size: MySize.size11,
            color: primaryColor,
          ),
          const SizedBox(
            height: 32.0,
            child: SolidLineConnector(),
          ),
          // OutlinedDotIndicator(),
          DDText(
            title: "More",
            size: MySize.size11,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}








