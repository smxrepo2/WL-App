import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timelines/timelines.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Controller/DashBoardController.dart';
import 'package:weight_loser/Controller/HomePageData.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/MoreFoodScreen/RestaurentFood.dart';
import 'package:weight_loser/screens/MoreFoodScreen/morefood.dart';
import 'package:weight_loser/screens/food_screens/SearchFood.dart';
import 'package:weight_loser/utils/ImagePath.dart';

class HomeMiddleShimmer extends StatelessWidget {
  const HomeMiddleShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        padding: EdgeInsets.only(
          top: MySize.size30,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: MySize.size4, left: MySize.size6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  waterLeft( ImagePath.glass, "Water", "1 cup", "- -",
                      context),
                  SizedBox(
                    height: MySize.size10,
                  ),
                  waterLeft( ImagePath.glass, "Water", "1 cup", "- -",
                      context),
                ],
              ),
            ),
            // addFoodDivider(1, "Breakfast"),
            Container(
              padding: EdgeInsets.only(
                left: MySize.size16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  waterRight( ImagePath.glass, "Water", "1 cup", "- -",
                      context),
                  SizedBox(
                    height: MySize.size10,
                  ),
                  waterRight( ImagePath.glass, "Water", "1 cup", "- -",
                      context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



