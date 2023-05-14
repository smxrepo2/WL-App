import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';

import '../SizeConfig.dart';
import '../SizeConfig.dart';

class DiaryShimmerWidget extends StatelessWidget {
  const DiaryShimmerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: SizeConfig.safeBlockVertical * 1,
            ),
            Column(
              children: [
                //goalFoodExerciseCaloriesView(snapshot.data),
                SizedBox(
                  height: MySize.size30,
                ),
                diaryPart(context),
                SizedBox(
                  height: MySize.size16,
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: MySize.size18, right: MySize.size20),
                    child: Divider(
                      thickness: 0.5,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  diaryPart(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MySize.size16, right: MySize.size16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/diary.png",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(children: [
        Container(
          padding: EdgeInsets.only(
              left: MySize.size26,
              top: MySize.size14,
              bottom: MySize.size14,
              right: MySize.size18),
          // color: primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(
                        //     left: MySize.size26,
                        //     top: MySize.size14,
                        //     bottom: MySize.size14,
                        //     right: MySize.size18),
                        // color: Colors.red,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // padding: EdgeInsets.only(
                              //     left: MySize.size26,
                              //     top: MySize.size14,
                              //     bottom: MySize.size14,
                              //     right: MySize.size18),
                              child: Icon(
                                Icons.free_breakfast_outlined,
                                color: Colors.grey[500],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MySize.size10),
                              child: Text(
                                "Breakfast",
                                style: TextStyle(fontSize: MySize.size14),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(""),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "0 cal",
                      style: TextStyle(fontSize: MySize.size14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              left: MySize.size26,
              top: MySize.size14,
              bottom: MySize.size14,
              right: MySize.size18),
          // color: primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lunch_dining_outlined,
                              color: Colors.grey[500],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MySize.size10),
                              child: Text(
                                "Lunch",
                                style: TextStyle(fontSize: MySize.size14),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(""),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "0 cals",
                      style: TextStyle(fontSize: MySize.size14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              left: MySize.size26,
              top: MySize.size14,
              bottom: MySize.size14,
              right: MySize.size18),
          // color: primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              MdiIcons.silverwareVariant,
                              color: Colors.grey[500],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MySize.size10),
                              child: Text(
                                "Dinner",
                                style: TextStyle(fontSize: MySize.size14),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(""),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "0 cals",
                      style: TextStyle(fontSize: MySize.size14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              left: MySize.size26,
              top: MySize.size14,
              bottom: MySize.size14,
              right: MySize.size18),
          // color: primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              MdiIcons.cookieOutline,
                              color: Colors.grey[500],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MySize.size10),
                              child: Text(
                                "Snacks",
                                style: TextStyle(fontSize: MySize.size14),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(""),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "0 cals",
                      style: TextStyle(fontSize: MySize.size14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              left: MySize.size26,
              top: MySize.size14,
              bottom: MySize.size14,
              right: MySize.size18),
          // color: primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.water,
                              color: Colors.grey[500],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MySize.size10),
                              child: Text(
                                "Water",
                                style: TextStyle(fontSize: MySize.size14),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(""),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "0 servings",
                      style: TextStyle(fontSize: MySize.size14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
