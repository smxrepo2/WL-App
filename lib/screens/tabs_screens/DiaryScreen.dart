import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/SizeConfig.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen>
    with SingleTickerProviderStateMixin {
  List<String> mealsList = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Snaks",
    "Exercise",
    "Water"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: Column(
            children: [
              DefaultTabController(
                length: 4,
                child: TabBar(
                  indicatorColor: Colors.white,
                  labelColor: primaryColor,
                  //isScrollable: true,
                  unselectedLabelColor: Colors.black87,
                  labelStyle: TextStyle(
                      fontSize: 12,
                      color: darkColor,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400),
                  tabs: [
                    new Container(
                      width: SizeConfig.screenWidth * 0.2,
                      child: new Tab(text: 'Apple'),
                    ),
                    new Container(
                      width: SizeConfig.screenWidth * 0.25,
                      child: new Tab(text: 'Summary'),
                    ),
                    new Container(
                      width: SizeConfig.screenWidth * 0.2,
                      child: new Tab(text: 'Blogs'),
                    ),
                    new Container(
                      width: SizeConfig.screenWidth * 0.15,
                      child: new Tab(text: 'Goals'),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                width: SizeConfig.screenWidth * 0.9,
                color: darkColor.withOpacity(0.05),
              ),
              DefaultTabController(
                length: 4,
                child: Expanded(
                    child: TabBarView(
                  children: [
                    //first apple tab
                    buildAppleTab(),
                    buildAppleTab(),
                    buildAppleTab(),
                    buildAppleTab(),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildAppleTab() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Budget",
                style: darkText14Px.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Goal",
                      style: darkText15Px,
                    ),
                    Text(
                      "11,00",
                      style: lightText15Px,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 40,
                      child: StepProgressIndicator(
                        totalSteps: 100,
                        direction: Axis.horizontal,
                        currentStep: 60,
                        padding: 0,
                        selectedColor: primaryColor,
                        unselectedColor: Colors.black12,
                        progressDirection: TextDirection.ltr,
                        //selectedSize: 10.0,
                        // roundedEdges: Radius.elliptical(6, 30),
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 2,
                ),
                Text(
                  "+",
                  style: darkText16Px,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 5,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Food",
                      style: darkText15Px,
                    ),
                    Text(
                      "300",
                      style: lightText15Px,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 40,
                      child: StepProgressIndicator(
                        totalSteps: 100,
                        direction: Axis.horizontal,
                        currentStep: 60,
                        padding: 0,
                        selectedColor: primaryColor,
                        unselectedColor: Colors.black12,
                        progressDirection: TextDirection.ltr,
                        //selectedSize: 10.0,
                        // roundedEdges: Radius.elliptical(6, 30),
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 2,
                ),
                Text(
                  "-",
                  style: darkText16Px,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 5,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Exercise",
                      style: lightText15Px,
                    ),
                    Text(
                      "200",
                      style: lightText15Px,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 50,
                      child: StepProgressIndicator(
                        totalSteps: 100,
                        direction: Axis.horizontal,
                        currentStep: 40,
                        padding: 0,
                        selectedColor: primaryColor,
                        unselectedColor: Colors.black12,
                        progressDirection: TextDirection.ltr,
                        //selectedSize: 10.0,
                        // roundedEdges: Radius.elliptical(6, 30),
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 3,
                ),
                Text(
                  "=",
                  style: darkText16Px,
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 2,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                        child: Text(
                      "Calories Left",
                      maxLines: 1,
                      style: darkText15Px,
                    )),
                    Text(
                      "1000",
                      style: lightText15Px,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 50,
                      child: StepProgressIndicator(
                        totalSteps: 100,
                        direction: Axis.horizontal,
                        currentStep: 50,
                        padding: 0,
                        selectedColor: primaryColor,
                        unselectedColor: Colors.black12,
                        progressDirection: TextDirection.ltr,
                        //selectedSize: 10.0,
                        // roundedEdges: Radius.elliptical(6, 30),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
            ),
            Stack(
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.98,
                  height: SizeConfig.safeBlockVertical * 30,
                  child: Image.asset("assets/images/diary_ic.png"),
                ),
                Positioned(
                    left: 70,
                    top: 15,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Breakfast",
                            style: darkText15Px,
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Text(
                            "Lunch",
                            style: darkText15Px,
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Text(
                            "Dinner",
                            style: darkText15Px,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Snack",
                            style: darkText15Px,
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Text(
                            "Water",
                            style: darkText15Px,
                          ),
                        ],
                      ),
                    )),
                Positioned(
                    left: 280,
                    top: 15,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(children: [
                            TextSpan(text: "200", style: darkText15Px),
                            TextSpan(
                                text: " cals",
                                style: lightText12Px.copyWith(fontSize: 9)),
                          ])),
                          SizedBox(
                            height: 22,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(text: "200", style: darkText15Px),
                            TextSpan(
                                text: " cals",
                                style: lightText12Px.copyWith(fontSize: 9)),
                          ])),
                          SizedBox(
                            height: 28,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(text: "200", style: darkText15Px),
                            TextSpan(
                                text: " cals",
                                style: lightText12Px.copyWith(fontSize: 9)),
                          ])),
                          SizedBox(
                            height: 30,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(text: "200", style: darkText15Px),
                            TextSpan(
                                text: " cals",
                                style: lightText12Px.copyWith(fontSize: 9)),
                          ])),
                          SizedBox(
                            height: 28,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(text: "200", style: darkText15Px),
                            TextSpan(
                                text: " ml",
                                style: lightText12Px.copyWith(fontSize: 9)),
                          ])),
                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 3,
            ),
            Divider(
              height: 2,
              color: darkColor.withOpacity(0.1),
            ),
            Container(
              height: 50,
              child: DefaultTabController(
                length: 6,
                child: TabBar(
                  indicatorColor: Colors.white,
                  labelColor: primaryColor,
                  isScrollable: true,
                  unselectedLabelColor: Colors.black87,
                  labelPadding: EdgeInsets.only(left: 15),
                  labelStyle: TextStyle(
                      fontSize: 12,
                      color: darkColor,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w600),
                  tabs: [
                    new Container(
                      width: SizeConfig.screenWidth * 0.15,
                      child: new Tab(text: 'Breakfast'),
                    ),
                    new Container(
                      width: SizeConfig.screenWidth * 0.095,
                      child: new Tab(text: 'Lunch'),
                    ),
                    new Container(
                      width: SizeConfig.screenWidth * 0.11,
                      child: new Tab(text: 'Dinner'),
                    ),
                    new Container(
                      width: SizeConfig.screenWidth * 0.09,
                      child: new Tab(text: 'Snaks'),
                    ),
                    new Container(
                      width: SizeConfig.screenWidth * 0.15,
                      child: new Tab(text: 'Exercise'),
                    ),
                    new Container(
                      width: SizeConfig.screenWidth * 0.11,
                      child: new Tab(text: 'Water'),
                    ),
                  ],
                ),
              ),

              /*ListView.separated(
              scrollDirection: Axis.horizontal,
                itemCount: mealsList.length,
                separatorBuilder: (ctx,index)=>Container(width: 10,),
                itemBuilder:(ctx,index)=> Container(
                child: Text("${mealsList[index]}", style: darkText14Px.copyWith(
                  fontWeight: FontWeight.w500
                ),),
            )),*/
            ),
            Divider(
              height: 1,
              color: darkColor.withOpacity(0.05),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 200,
                child: DefaultTabController(
                  length: 6,
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: darkColor.withOpacity(0.07),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText13Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText13Px),
                                      TextSpan(
                                          text: " cals",
                                          style: lightText12Px.copyWith(
                                              fontSize: 9)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Egg 1",
                                      style: darkText13Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "120", style: darkText13Px),
                                      TextSpan(
                                          text: " cals",
                                          style: lightText12Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Milk 120ml",
                                      style: darkText13Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(text: "30", style: darkText13Px),
                                      TextSpan(
                                          text: " cals",
                                          style: lightText12Px.copyWith(
                                              fontSize: 9)),
                                    ])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          // ignore: deprecated_member_use
                          MaterialButton(
                            onPressed: () {},
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Add",
                              style: whiteText14Px,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: darkColor.withOpacity(0.07),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          // ignore: deprecated_member_use
                          MaterialButton(
                            onPressed: () {},
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Add",
                              style: whiteText14Px,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: darkColor.withOpacity(0.07),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          // ignore: deprecated_member_use
                          MaterialButton(
                            onPressed: () {},
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Add",
                              style: whiteText14Px,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: darkColor.withOpacity(0.07),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          // ignore: deprecated_member_use
                          MaterialButton(
                            onPressed: () {},
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Add",
                              style: whiteText14Px,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: darkColor.withOpacity(0.07),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          // ignore: deprecated_member_use
                          MaterialButton(
                            onPressed: () {},
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Add",
                              style: whiteText14Px,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: darkColor.withOpacity(0.07),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: darkColor.withOpacity(0.07),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Salad 250g",
                                      style: darkText12Px,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "200", style: darkText14Px),
                                      TextSpan(
                                          text: " cals",
                                          style: darkText14Px.copyWith(
                                              fontSize: 11)),
                                    ])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                          // ignore: deprecated_member_use
                          MaterialButton(
                            onPressed: () {},
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Add",
                              style: whiteText14Px,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
