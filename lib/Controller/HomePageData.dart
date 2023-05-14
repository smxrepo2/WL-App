import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/Today_api.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/models/dairy_model.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';

import 'package:weight_loser/screens/food_screens/NutritionScreenView.dart';
import 'package:weight_loser/screens/navigation_tabs/homepage/middle.dart';
import 'package:weight_loser/screens/navigation_tabs/replace_food.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

import '../utils/sizeconfig.dart';
import 'DashBoardController.dart';

var quotation =
    "sAs they say it\'s all in the mind. the better the mind state more likely you succeed";
String message =
    "Suggested Items can not be replaced.\nDo you want to load actual plan?";
// ############################ Goal, Food, Exercise, Calories #################################

Future<void> _showReplaceDialog(
    String title, Function() onYes, Function() onNo, context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              onYes();
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}

Widget goalFoodExerciseCaloriesView(
    DashboardModel _dbm, left, right, context, key) {
  var mobile = Responsive1.isMobile(context);
  /*
  var carbgauge = _dbm.budgetVM.carbs / _dbm.goalCarbCount;
  var proteingauge = _dbm.budgetVM.protein / _dbm.goalProteinCount;
  var fatgauge = _dbm.budgetVM.fat / _dbm.goalFatCount;
  if (carbgauge > 1) carbgauge = 0.9;
  if (proteingauge > 1) proteingauge = 0.9;
  if (fatgauge > 1) fatgauge = 0.9;
  */
  return ShowCaseView(
    globalKey: key,
    title: "Goals",
    description:
        "View your daily goal upon your initial questions and daily progress",
    child: Container(
      // color: Colors.red,
      margin: EdgeInsets.only(
        left: MySize.size20,
      ),
      padding: EdgeInsets.only(
        left: left,
        right: right,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomBarNew(3)));
            },
            child: circularProgress("Carbs", const Color(0xffe09a9a),
                _dbm.budgetVM.carbs, _dbm.goalCarbCount),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomBarNew(3)));
            },
            child: circularProgress("Fat", const Color(0xffffb711),
                _dbm.budgetVM.fat, _dbm.goalFatCount),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomBarNew(3)));
            },
            child: circularProgress("Protein", const Color(0xff13be24),
                _dbm.budgetVM.protein, _dbm.goalProteinCount),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomBarNew(3)));
            },
            child: circularProgress("Calories", Color(0xff4885ed),
                _dbm.budgetVM.consCalories, _dbm.budgetVM.targetCalories),
          ),
          /*
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DDText(
                    title: "Goal",
                    size: mobile ? 15 : 20,
                    weight: FontWeight.w500,
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Countup(
                        begin: 0,
                        end: _dairy.budgetVM.targetCalories.toDouble(),
                        duration: Duration(seconds: 1),
                        separator: ',',
                        style: GoogleFonts.openSans(
                            fontSize: mobile ? 15 : 18,
                            fontWeight: FontWeight.w300),
                      ),
  
                      // DDText(
                      //   title: "11,00",
                      //   size: MySize.size15,
                      //   weight:
                      //       FontWeight.w300,
                      // ),
                    ],
                  ),
                  SizedBox(height: MySize.size10),
                  Container(
                    // margin: EdgeInsets.only(left: MySize.size20),
                    width: MySize.size34,
                    child: StepProgressIndicator(
                      totalSteps: 100,
                      direction: Axis.horizontal,
                      currentStep: 100,
                      padding: 0,
                      selectedColor: primaryColor,
                      unselectedColor: Colors.black12,
                      progressDirection: TextDirection.ltr,
                      //selectedSize: 10.0,
                      // roundedEdges: Radius.elliptical(6, 30),
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
                      size: mobile ? 15 : 20,
                    ),
                    Countup(
                      begin: 0,
                      end: _dairy.budgetVM.consCalories.toDouble(),
                      duration: Duration(seconds: 1),
                      separator: ',',
                      style: GoogleFonts.openSans(
                          fontSize: mobile ? 15 : 18,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: MySize.size10),
                    Container(
                      // margin: EdgeInsets.only(left: MySize.size20),
                      width: MySize.size36,
                      child: StepProgressIndicator(
                        //totalSteps: 100,
                        totalSteps: _dairy.budgetVM.targetCalories.toInt() == 0
                            ? 10
                            : _dairy.budgetVM.targetCalories.toInt(),
                        direction: Axis.horizontal,
                        currentStep: _dairy.budgetVM.consCalories.toInt() >
                                _dairy.budgetVM.targetCalories.toInt()
                            ? _dairy.budgetVM.targetCalories.toInt()
                            : _dairy.budgetVM.consCalories.toInt(),
                        padding: 0,
                        selectedColor: primaryColor,
                        unselectedColor: Colors.black12,
                        progressDirection: TextDirection.ltr,
                        //selectedSize: 10.0,
                        // roundedEdges: Radius.elliptical(6, 30),
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
                    size: mobile ? 15 : 20,
                  ),
                  Countup(
                    begin: 0,
                    end: _dairy.budgetVM.burnCalories.toDouble(),
                    duration: Duration(seconds: 1),
                    separator: ',',
                    style: GoogleFonts.openSans(
                        fontSize: mobile ? 15 : 18, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: MySize.size10),
                  Container(
                    width: MySize.size56,
                    child: StepProgressIndicator(
                      // totalSteps: 100,
                      totalSteps: _dairy.budgetVM.targetCalories.toInt() == 0
                          ? 10
                          : _dairy.budgetVM.targetCalories.toInt(),
                      direction: Axis.horizontal,
                      currentStep: _dairy.budgetVM.burnCalories.toInt() >
                              _dairy.budgetVM.targetCalories.toInt()
                          ? _dairy.budgetVM.targetCalories.toInt()
                          : _dairy.budgetVM.burnCalories.toInt(),
                      padding: 0,
                      selectedColor: primaryColor,
                      unselectedColor: Colors.black12,
                      progressDirection: TextDirection.ltr,
                      //selectedSize: 10.0,
                      // roundedEdges: Radius.elliptical(6, 30),
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
                    size: mobile ? MySize.size15 : 20,
                  ),
                  Countup(
                    begin: 0,
                    end: _dairy.budgetVM.targetCalories.toDouble() != 0
                        ? (_dairy.budgetVM.targetCalories.toDouble() -
                                    (_dairy.budgetVM.consCalories.toDouble() +
                                        _dairy.budgetVM.burnCalories
                                            .toDouble())) <
                                0
                            ? 0
                            : (_dairy.budgetVM.targetCalories.toDouble() -
                                (_dairy.budgetVM.consCalories.toDouble() +
                                    _dairy.budgetVM.burnCalories.toDouble()))
                        : 0,
                    duration: Duration(seconds: 1),
                    separator: ',',
                    style: GoogleFonts.openSans(
                        fontSize: mobile ? 15 : 18, fontWeight: FontWeight.w300),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MySize.size10,
                      ),
                      Container(
                        width: MySize.size84,
                        child: StepProgressIndicator(
                          // totalSteps: 100,
                          totalSteps: _dairy.budgetVM.targetCalories.toInt() == 0
                              ? 10
                              : _dairy.budgetVM.targetCalories.toInt(),
                          direction: Axis.horizontal,
                          currentStep: (_dairy.budgetVM.consCalories.toDouble() +
                                          _dairy.budgetVM.burnCalories.toDouble())
                                      .toInt() >
                                  _dairy.budgetVM.targetCalories.toInt()
                              ? _dairy.budgetVM.targetCalories.toInt()
                              : (_dairy.budgetVM.consCalories.toDouble() +
                                      _dairy.budgetVM.burnCalories.toDouble())
                                  .toInt(),
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
          */
        ],
      ),
    ),
  );
}

// ############################ Left Side Items #################################

Widget foodItemLeft(
    BuildContext context,
    id,
    ingredients,
    name,
    serving,
    calories,
    carb,
    fat,
    pro,
    desc,
    procedure,
    imagePath,
    typeId,
    eatingTime,
    cuisine,
    planId,
    offsetY,
    ispressed,
    Function() onReload) {
  print("I am in food item left");

  DashboardController c = Get.put(DashboardController());
  UserDataProvider _userDataProvider =
      Provider.of<UserDataProvider>(context, listen: false);
  print(
      "Network Connection in foodList Left:${_userDataProvider.networkConnection}");
  return Container(
    width: MediaQuery.of(context).size.width * 0.4,
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Row(
          children: [
            GetX<DashboardController>(
              init: DashboardController(),
              builder: (val) => TweenAnimationBuilder(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOut,
                tween: Tween<double>(
                    begin: 0, end: c.offset.value == 90 ? 180 : 0),
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      print("food id $id");

                      fetchRecipe1(int.parse(id)).then(
                        (value) => showFoodDialog1(
                            context,
                            name,
                            value,
                            serving,
                            calories,
                            carb,
                            fat,
                            pro,
                            desc,
                            procedure,
                            imagePath,
                            typeId,
                            eatingTime,
                            cuisine,
                            ActiveFoodPlans(),
                            id),
                      );
                    },
                    child: RotationY(
                        rotationY: value,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.14,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: NetworkImage(imagePath),
                                  fit: BoxFit.cover)),
                        )),
                  );
                },
              ),
            ),
            SizedBox(
              width: MySize.size10,
            ),
            if (_userDataProvider.networkConnection)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Responsive1.isMobile(context)
                        ? MediaQuery.of(context).size.width * 0.2
                        : null,
                    child: DDText(
                      toverflow: TextOverflow.ellipsis,
                      title: name,
                      line: 1,
                      size: MySize.size15,
                    ),
                  ),
                  DDText(
                    title: serving,
                    size: MySize.size11,
                    color: const Color(0xffafafaf),
                  ),
                  DDText(
                    title: calories.toString(),
                    size: MySize.size15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_userDataProvider.networkConnection) {
                            UIBlock.block(context);
                            print("Food Id :-$id");
                            print("typeId:$typeId");
                            print("active food plan:" + planId.toString());
                            fetchRecipe(int.parse(id)).then(
                              (value) => AddFoodToDiary(
                                      context,
                                      name,
                                      "Ingredients",
                                      serving,
                                      calories,
                                      carb,
                                      fat,
                                      pro,
                                      desc,
                                      procedure,
                                      imagePath,
                                      typeId,
                                      eatingTime,
                                      cuisine,
                                      //ActiveFoodPlans(),
                                      id)
                                  .then((value) {
                                if (value) {
                                  UIBlock.unblock(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomBarNew(0)));
                                } else
                                  UIBlock.unblock(context);
                              }),
                            );
                          }
                        },
                        child: DDText(
                          title: "Add",
                          size: MySize.size12,
                          color: const Color(0xff4885ed),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_userDataProvider.networkConnection) {
                            if (!ispressed)
                              Get.to(() => TrackFood(
                                    eatingTime: eatingTime,
                                    foodId: int.parse(id),
                                    planId: planId,
                                  ));
                            else {
                              return _showReplaceDialog("Message", () {
                                onReload();
                              }, () {
                                // Navigator.of(context).pop();
                              }, context);
                            }
                          }
                        },
                        child: DDText(
                          title: "Replace",
                          size: MySize.size12,
                          color: const Color(0xffb20000),
                        ),
                      )
                    ],
                  )
                ],
              ),
          ],
        ),
      ],
    ),
  );
}

Widget itemLeft(
    BuildContext context,
    id,
    name,
    serving,
    calories,
    carb,
    fat,
    pro,
    desc,
    procedure,
    imagePath,
    typeId,
    eatingTime,
    cuisine,
    planId,
    offsetY) {
  print("im in item left");
  DashboardController c = Get.put(DashboardController());
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var orientation = MediaQuery.of(context).orientation;
  UserDataProvider _userDataProvider =
      Provider.of<UserDataProvider>(context, listen: false);
  return Container(
    width: orientation == Orientation.portrait ? width * 0.4 : width * .3,
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Row(
          children: [
            GetX<DashboardController>(
              init: DashboardController(),
              builder: (val) => TweenAnimationBuilder(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOut,
                tween: Tween<double>(
                    begin: 0, end: c.offset.value == 90 ? 180 : 0),
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      print("Food Id :-$id");
                      print("active food plan:" + planId.toString());
                      fetchRecipe(int.parse(id)).then(
                        (value) => showFoodDialog(
                            context,
                            name,
                            serving,
                            calories,
                            carb,
                            fat,
                            pro,
                            desc,
                            procedure,
                            imagePath,
                            typeId,
                            eatingTime,
                            cuisine,
                            ActiveFoodPlans(),
                            id),
                      );
                    },
                    child: RotationY(
                        rotationY: value,
                        child: Container(
                          height: orientation == Orientation.portrait
                              ? height * 0.11
                              : height * .14,
                          width: orientation == Orientation.portrait
                              ? width * 0.14
                              : width * .11,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: NetworkImage(imagePath),
                                  fit: BoxFit.cover)),
                        )),
                  );
                },
              ),
            ),

            SizedBox(
              width: MySize.size10,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Responsive1.isMobile(context)
                      ? orientation == Orientation.portrait
                          ? width * 0.2
                          : width * .1
                      : null,
                  child: DDText(
                    toverflow: TextOverflow.ellipsis,
                    title: name,
                    line: 1,
                    size: MySize.size15,
                  ),
                ),
                /*
                DDText(
                  title: "${serving}Qty",
                  size: MySize.size11,
                  color: const Color(0xffafafaf),
                ),
                */
                DDText(
                  title: "${calories}Cal",
                  size: MySize.size15,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_userDataProvider.networkConnection) {
                          UIBlock.block(context);
                          print("Food Id :-$id");
                          print("active food plan:" + planId.toString());
                          fetchRecipe(int.parse(id)).then(
                            (value) => AddFoodToDiary(
                                    context,
                                    name,
                                    "Ingredients",
                                    serving,
                                    calories,
                                    carb,
                                    fat,
                                    pro,
                                    desc,
                                    procedure,
                                    imagePath,
                                    typeId,
                                    eatingTime,
                                    cuisine,
                                    //ActiveFoodPlans(),
                                    id)
                                .then((value) {
                              if (value) {
                                UIBlock.unblock(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomBarNew(0)));
                              } else
                                UIBlock.unblock(context);
                            }),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(noInternetsnackBar);
                        }
                      },
                      child: DDText(
                        title: "Add",
                        size: MySize.size12,
                        color: const Color(0xff4885ed),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_userDataProvider.networkConnection) {
                          Get.to(TrackFood(
                            eatingTime: eatingTime,
                            foodId: int.parse(id),
                            planId: planId,
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(noInternetsnackBar);
                        }
                      },
                      child: DDText(
                        title: "Replace",
                        size: MySize.size12,
                        color: const Color(0xffb20000),
                      ),
                    )
                  ],
                )
              ],
            ),
            // InkWell(
            //    onTap: (){  _showChoiceDialog(context);},
            //    child: Column(
            //      crossAxisAlignment: CrossAxisAlignment.start,
            //      children: [
            //         SizedBox(
            //            width: Responsive1.isMobile(context)?MediaQuery.of(context).size.width * 0.2:null,
            //            child:
            //            DDText(
            //              toverflow:TextOverflow.ellipsis,
            //              title: title,
            //              line: 1,
            //              size: MySize.size15,
            //            ),
            //          ),
            //
            //        DDText(
            //          title: weight,
            //          size: MySize.size11,
            //          color: Color(0xffafafaf),
            //        ),
            //        DDText(
            //          title: calories,
            //          size: MySize.size15,
            //        ),
            //
            //      ],
            //    ),
            //  )
          ],
        ),
      ],
    ),
  );
}

Widget waterLeft(imagePath, title, weight, calories, BuildContext context) {
  DashboardController c = Get.put(DashboardController());
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var orientation = MediaQuery.of(context).orientation;
  return Container(
    width: orientation == Orientation.portrait ? width * 0.4 : width * .3,
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Row(
          children: [
            Obx(() {
              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOut,
                tween: Tween<double>(
                    begin: 0, end: c.offset.value == 90 ? 180 : 0),
                builder: (context, value, child) {
                  return RotationY(
                    rotationY: value,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        height: orientation == Orientation.portrait
                            ? height * 0.11
                            : height * .14,
                        width: orientation == Orientation.portrait
                            ? width * 0.14
                            : width * .11,
                      ),
                    ),
                  );
                },
              );
            }),
            SizedBox(
              width: MySize.size10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DDText(
                  title: title,
                  size: MySize.size15,
                ),
                DDText(
                  title: weight,
                  size: MySize.size11,
                  color: const Color(0xffafafaf),
                ),
                DDText(
                  title: calories,
                  size: MySize.size12,
                  color: const Color(0xff4885ed),
                ),
              ],
            )
          ],
        ),
      ],
    ),
  );
}

// ############################ Right Side Items #################################

Widget foodItemRight(
    BuildContext context,
    id,
    ingredients,
    name,
    serving,
    calories,
    carb,
    fat,
    pro,
    desc,
    procedure,
    imagePath,
    typeId,
    eatingTime,
    cuisine,
    planId,
    isPress,
    Function() reLoad) {
  String shortName = name;
  print("I am in food item right");
  if (shortName.toString().length > 7) {
    shortName = shortName.toString().substring(0, 7);
    shortName = "$shortName ...";
  }
  DashboardController c = Get.put(DashboardController());
  UserDataProvider _userDataProvider =
      Provider.of<UserDataProvider>(context, listen: false);
  return Container(
    width: Responsive1.isMobile(context)
        ? MediaQuery.of(context).size.width * 0.38
        : MediaQuery.of(context).size.width * 0.20,
    //padding: const EdgeInsets.only(left: 10),
    // padding: EdgeInsets.only(left: MySize.size18),
    child: Row(
      children: [
        Row(
          children: [
            //if (_userDataProvider.networkConnection)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: DDText(
                    toverflow: TextOverflow.ellipsis,
                    title: shortName,
                    line: 1,
                    size: MySize.size15,
                  ),
                ),
                DDText(
                  title: serving,
                  size: MySize.size11,
                  color: const Color(0xffafafaf),
                ),
                /*
                  DDText(
                    title: "${serving}Qty",
                    size: MySize.size11,
                    color: const Color(0xffafafaf),
                  ),
                  */
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: DDText(
                    title: "${calories}Cal",
                    size: MySize.size15,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_userDataProvider.networkConnection) {
                          UIBlock.block(context);
                          print("Food Id :-$id");
                          print("active food plan:" + planId.toString());
                          fetchRecipe(int.parse(id)).then(
                            (value) => AddFoodToDiary(
                                    context,
                                    name,
                                    "Ingredients",
                                    serving,
                                    calories,
                                    carb,
                                    fat,
                                    pro,
                                    desc,
                                    procedure,
                                    imagePath,
                                    typeId,
                                    eatingTime,
                                    cuisine,
                                    //ActiveFoodPlans(),
                                    id)
                                .then((value) {
                              if (value) {
                                UIBlock.unblock(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomBarNew(0)));
                              } else
                                UIBlock.unblock(context);
                            }),
                          );
                        }
                      },
                      child: DDText(
                        title: "Add",
                        size: MySize.size12,
                        color: const Color(0xff4885ed),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_userDataProvider.networkConnection) {
                          if (!isPress)
                            Get.to(() => TrackFood(
                                  eatingTime: eatingTime,
                                  foodId: int.parse(id),
                                  planId: planId,
                                ));
                          else {
                            return _showReplaceDialog("Message", () {
                              reLoad();
                            }, () {
                              // Navigator.of(context).pop();
                            }, context);
                          }
                        }
                      },
                      child: DDText(
                        title: "Replace",
                        size: MySize.size12,
                        color: const Color(0xffb20000),
                      ),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: MySize.size4),
              child: Obx(() {
                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  tween: Tween<double>(
                      begin: 0, end: c.offset.value == 90 ? 180 : 0),
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () {
                        print("Food id $id");
                        fetchRecipe1(int.parse(id)).then(
                          (value) => showFoodDialog1(
                              context,
                              name,
                              ingredients,
                              serving,
                              calories,
                              carb,
                              fat,
                              pro,
                              desc,
                              procedure,
                              imagePath,
                              typeId,
                              eatingTime,
                              cuisine,
                              ActiveFoodPlans(),
                              id),
                        );
                      },
                      child: RotationY(
                          rotationY: value,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            width: MediaQuery.of(context).size.width * 0.14,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: NetworkImage(imagePath),
                                    fit: BoxFit.cover)),
                          )),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget itemRight(
  BuildContext context,
  id,
  name,
  serving,
  calories,
  carb,
  fat,
  pro,
  desc,
  procedure,
  imagePath,
  typeId,
  eatingTime,
  cuisine,
  planId,
) {
  DashboardController c = Get.put(DashboardController());
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var orientation = MediaQuery.of(context).orientation;
  UserDataProvider _userDataProvider =
      Provider.of<UserDataProvider>(context, listen: false);
  return Container(
    width: Responsive1.isMobile(context)
        ? orientation == Orientation.portrait
            ? width * 0.38
            : width * 0.19
        : width * 0.20,
    //padding: const EdgeInsets.only(left: 10),
    // padding: EdgeInsets.only(left: MySize.size18),
    child: Row(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  width: Responsive1.isMobile(context)
                      ? orientation == Orientation.portrait
                          ? width * 0.2
                          : width * 0.1
                      : null,
                  child: DDText(
                    toverflow: TextOverflow.ellipsis,
                    title: name,
                    line: 1,
                    size: MySize.size15,
                  ),
                ),

                /*
                DDText(
                  title: "${serving}Qty",
                  size: MySize.size11,
                  color: const Color(0xffafafaf),
                ),
                */
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: DDText(
                    title: "${calories}Cal",
                    size: MySize.size15,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_userDataProvider.networkConnection) {
                          UIBlock.block(context);
                          print("Food Id :-$id");
                          print("active food plan:" + planId.toString());
                          fetchRecipe(int.parse(id)).then(
                            (value) => AddFoodToDiary(
                                    context,
                                    name,
                                    "Ingredients",
                                    serving,
                                    calories,
                                    carb,
                                    fat,
                                    pro,
                                    desc,
                                    procedure,
                                    imagePath,
                                    typeId,
                                    eatingTime,
                                    cuisine,
                                    //ActiveFoodPlans(),
                                    id)
                                .then((value) {
                              if (value) {
                                UIBlock.unblock(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomBarNew(0)));
                              } else
                                UIBlock.unblock(context);
                            }),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(noInternetsnackBar);
                        }
                      },
                      child: DDText(
                        title: "Add",
                        size: MySize.size12,
                        color: const Color(0xff4885ed),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_userDataProvider.networkConnection) {
                          Get.to(TrackFood(
                            eatingTime: eatingTime,
                            foodId: int.parse(id),
                            planId: planId,
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(noInternetsnackBar);
                        }
                      },
                      child: DDText(
                        title: "Replace",
                        size: MySize.size12,
                        color: const Color(0xffb20000),
                      ),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: MySize.size8),
              child: Obx(() {
                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  tween: Tween<double>(
                      begin: 0, end: c.offset.value == 90 ? 180 : 0),
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () {
                        print("Food id $id");
                        fetchRecipe(int.parse(id)).then(
                          (value) => showFoodDialog(
                              context,
                              name,
                              serving,
                              calories,
                              carb,
                              fat,
                              pro,
                              desc,
                              procedure,
                              imagePath,
                              typeId,
                              eatingTime,
                              cuisine,
                              ActiveFoodPlans(),
                              id),
                        );
                      },
                      child: RotationY(
                          rotationY: value,
                          child: Container(
                            height: orientation == Orientation.portrait
                                ? height * 0.11
                                : height * .14,
                            width: orientation == Orientation.portrait
                                ? width * 0.14
                                : width * .11,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: NetworkImage(imagePath),
                                    fit: BoxFit.cover)),
                          )),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget circularProgress(text, color, count, cal) {
  double percent = count / cal;
  print("Percent:$percent");
  percent = 1 - percent;
  count = cal - count;
  if (count < 0) {
    color = Colors.red;
  }

  if (percent >= 1)
    percent = 0.99999999;
  else if (percent < 0) percent = 0.9999;
  //if (percent > 10) percent = percent / 100;
  return CircularPercentIndicator(
    animation: true,
    animationDuration: 3000,
    radius: 60.0,
    lineWidth: 5.0,
    percent: percent,
    center: new Text(
      text == "Calories"
          ? '$text\n${double.parse(count.toString()).toStringAsFixed(0)}'
          : '$text\n${double.parse(count.toString()).toStringAsFixed(0)}g',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 11,
      ),
    ),
    progressColor: color,
  );
}

Widget waterRight(imagePath, title, weight, calories, BuildContext context) {
  DashboardController c = Get.put(DashboardController());
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var orientation = MediaQuery.of(context).orientation;
  return Container(
    width: Responsive1.isMobile(context)
        ? orientation == Orientation.portrait
            ? width * 0.38
            : width * 0.30
        : width * 0.20,
    padding: const EdgeInsets.only(left: 10),
    // padding: EdgeInsets.only(left: MySize.size18),
    child: Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Responsive1.isMobile(context)
                  ? orientation == Orientation.portrait
                      ? width * 0.18
                      : width * 0.14
                  : MediaQuery.of(context).size.width * 0.04,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DDText(
                    title: title,
                    size: MySize.size15,
                  ),
                  DDText(
                    title: weight,
                    size: MySize.size11,
                    color: const Color(0xffafafaf),
                  ),
                  DDText(
                      title: calories,
                      size: MySize.size12,
                      color: const Color(0xff4885ed)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MySize.size4),
              child: Obx(() {
                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  tween: Tween<double>(
                      begin: 0, end: c.offset.value == 90 ? 180 : 0),
                  builder: (context, value, child) {
                    return RotationY(
                      rotationY: value,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          height: orientation == Orientation.portrait
                              ? height * 0.11
                              : height * .14,
                          width: orientation == Orientation.portrait
                              ? width * 0.14
                              : width * .11,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ],
    ),
  );
}

//  AnimatedContainer(
//                   duration: Duration(milliseconds: 600),
//                   curve: Curves.bounceInOut,
//                   alignment: FractionalOffset.center,
//                   transform: Matrix4.rotationY(c.offset.value == 90 ? (pi) : 0.0),
//                   child: Image.asset(
//                     imagePath,
//                     width: MediaQuery.of(context).size.width * 0.14,
//                   ),
//                 );
//               }),

// ############################ QUOTATION SECTION #################################

Widget quotationSection(left, right) {
  return Container(
    padding: EdgeInsets.only(left: left, right: right),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(
        //   height: SizeConfig.safeBlockVertical * 2,
        // ),

        FutureBuilder(
          future: getMindPlanQuote(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (snapshot.data.length > 0)
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            snapshot.data.length > 0
                                ? '"${snapshot.data[0]['Qoute']}"'
                                : '',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.4),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Text("");
          },
        )
      ],
    ),
  );
}

class RotationY extends StatelessWidget {
  //Degrees to rads constant
  static const double degrees2Radians = pi / 180;

  final Widget child;
  final double rotationY;

  const RotationY({Key key, @required this.child, this.rotationY = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) //These are magic numbers, just use them :)
          ..rotateY(rotationY * degrees2Radians),
        child: child);
  }
}
