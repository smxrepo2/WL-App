import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Provider/CustomPlanProvider.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Diet_api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/dairy_model.dart';
import 'package:weight_loser/models/food_model.dart';
import 'package:weight_loser/models/temp_custom_diet_plan_model.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';
import 'package:weight_loser/screens/food_screens/CreateCustomPlan.dart';
import 'package:weight_loser/screens/navigation_tabs/Todayscreen.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/SideMenu.dart';
import 'package:weight_loser/widget/circlechartwidget.dart';

import 'package:weight_loser/screens/food_screens/NutritionScreenView.dart';

class NewAddFood extends StatefulWidget {
  String foodId;

  NewAddFood(this.foodId);

  @override
  _NewAddFoodState createState() => _NewAddFoodState();
}

class _NewAddFoodState extends State<NewAddFood> {
  TextEditingController noOfServingsController =
      TextEditingController(text: '1');

  TextEditingController servingSizeController = TextEditingController();

  int totalBreakFastCalories = 0;
  int totalLunchCalories = 0;
  int totalDinnerCalories = 0;
  int totalSnacksCalories = 0;
  int totalWaterServings = 0;
  int totalCalories = 0;
  num proteinPercent = 0.0;
  num carbPercent = 0.0;
  num fatPercent = 0.0;
  int totalExerciseList = 0;
  num percentCalories = 0.0;
  int userid;
  getTotalCalories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    var datetime = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch,
        isUtc: true);
    print(datetime.toIso8601String()); // Prints: 2021-01-26T21:00:00.000Z
    final response = await get(
      Uri.parse(
          '$apiUrl/api/diary/getbyid?userId=$userid&filter_date=${datetime.toIso8601String()}'),
    );
    print("response ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      Dairy _dairy = Dairy.fromJson(jsonDecode(response.body));

      _dairy.breakfastList.forEach((element) {
        setState(() {
          totalBreakFastCalories += element.consCalories.toInt() ?? 0;
        });
      });
      _dairy.luncheList.forEach((element) {
        setState(() {
          totalLunchCalories += element.consCalories.toInt() ?? 0;
        });
      });
      _dairy.dinnerList.forEach((element) {
        setState(() {
          totalDinnerCalories += element.consCalories.toInt() ?? 0;
        });
      });
      _dairy.snackList.forEach((element) {
        setState(() {
          totalSnacksCalories += element.consCalories.toInt() ?? 0;
        });
      });
      _dairy.waterList.forEach((element) {
        setState(() {
          totalWaterServings += element.serving.toInt() ?? 0;
        });
      });
      _dairy.userExcerciseList.forEach((element) {
        setState(() {
          totalExerciseList += element.burnCalories.toInt() ?? 0;
        });
      });
      setState(() {
        totalCalories = totalBreakFastCalories +
            totalSnacksCalories +
            totalLunchCalories +
            totalDinnerCalories;
        if (_dairy.budgetVM.carbs == 0 &&
            _dairy.budgetVM.carbs == 0 &&
            _dairy.budgetVM.carbs == 0) {
          print("zero value");
        } else {
          proteinPercent = _dairy.budgetVM.protein ??
              0 /
                  (_dairy.budgetVM.carbs ??
                      0 + _dairy.budgetVM.fat ??
                      0 + _dairy.budgetVM.protein ??
                      0);
          carbPercent = _dairy.budgetVM.carbs ??
              0 /
                  (_dairy.budgetVM.carbs ??
                      0 + _dairy.budgetVM.fat ??
                      0 + _dairy.budgetVM.protein ??
                      0);
          fatPercent = _dairy.budgetVM.fat ??
              0 /
                  (_dairy.budgetVM.carbs ??
                      0 + _dairy.budgetVM.fat ??
                      0 + _dairy.budgetVM.protein ??
                      0);

          print(carbPercent.toString() +
              " : " +
              proteinPercent.toString() +
              " : " +
              fatPercent.toString());

          if (proteinPercent > 0) proteinPercent = proteinPercent / 1000;
          if (carbPercent > 0) carbPercent = carbPercent / 1000;
          if (fatPercent > 0) fatPercent = fatPercent / 1000;
        }

        if (_dairy.budgetVM.consCalories / _dairy.budgetVM.targetCalories > 1) {
          proteinPercent = 1;
        } else {
          percentCalories =
              _dairy.budgetVM.consCalories / _dairy.budgetVM.targetCalories;
          if (percentCalories > 0) percentCalories = percentCalories / 100;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getTotalCalories();
  }

  Future<Response> createFood(
      int typeId, int userId, int servings, cal, serving, fat, protein, carb) {
    print(jsonEncode(<String, dynamic>{
      "userId": userId,
      "F_type_id": typeId,
      "FoodId": "${widget.foodId}",
      "Cons_Cal": cal * servings,
      "ServingSize": serving,
      "fat": fat * servings,
      "Protein": protein * servings,
      "Carbs": carb * servings
    }));
    // Future<Response> createFood(
    //     int typeId, FoodModel _food, int userId, int servings,cal,serving,fat,protein,carb) {
    //   print(jsonEncode(<String, dynamic>{
    //     "userId": userId,
    //     "F_type_id": typeId,
    //     "FoodId": "${widget.foodId}",
    //     "Cons_Cal": _food.calories * servings,
    //     "ServingSize": _food.servingSize,
    //     "fat": _food.fat * servings,
    //     "Protein": _food.protein * servings,
    //     "Carbs": _food.carbs * servings
    //   }));
    return post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "F_type_id": typeId,
        "FoodId": "${widget.foodId.toString()}",
        "Cons_Cal": cal * servings.toInt(),
        "ServingSize": serving.toInt(),
        "fat": fat * servings.toDouble(),
        "Protein": protein * servings.toDouble(),
        "Carbs": carb * servings.toDouble()
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Responsive1.isMobile(context)
              ? customAppBar(context)
              : Padding(padding: EdgeInsets.only(top: 5)),
        ),
        // appBar: customAppBar(context),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: getFoodDetail1(widget.foodId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Text('Food'),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      upperContainer(
                          context,
                          snapshot.data['Name'],
                          snapshot.data['Carbs'],
                          snapshot.data['Protein'],
                          snapshot.data['fat'],
                          snapshot.data['Calories']),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      middleContainer(snapshot.data['ServingSize']),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      /*   FutureBuilder<Dairy>(
                        future: fetchDairy(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return bottomContainer(snapshot.data);
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('No Internet Connectivity'),
                            );
                          }

                          // By default, show a loading spinner.
                          return Center(child: const CircularProgressIndicator());
                        },
                      ),*/

                      SizedBox(
                        height: size.height * 0.06,
                      ),

                      // ############################# ADD FOOD BUTTON ############################
                      GestureDetector(
                        onTap: () {
                          final provider = Provider.of<UserDataProvider>(
                              context,
                              listen: false);
                          if (noOfServingsController.text.isNotEmpty &&
                              noOfServingsController.text.trim() != '0') {
                            if (provider.customPlanStatusCode == 0) {
                              print("provider type Id ${provider.foodTypeId}");
                              int id = provider.foodTypeId;
                              final ProgressDialog pr = ProgressDialog(context);
                              pr.show();
                              createFood(
                                id,
                                provider.userData.user.id,
                                servings,
                                snapshot.data['Calories'],
                                snapshot.data['ServingSize'],
                                snapshot.data['fat'],
                                snapshot.data['Protein'],
                                snapshot.data['Carbs'],
                              ).then((value) {
                                print("Add Food ${value.body}");
                                pr.hide();
                                Responsive1.isMobile(context)
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomBarNew(0)))
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomBarNew(0)));
                              }).onError((error, stackTrace) {
                                pr.hide();
                                print(error.toString());
                              });
                            } else if (provider.customPlanStatusCode == 1) {
                              final tempProvider =
                                  Provider.of<CustomPlanProvider>(context,
                                      listen: false);
                              TempCustomDietPlanModel tempModel =
                                  tempProvider.customDietPlanModel;
                              TempDietFoodPlanItem foodItemModel =
                                  TempDietFoodPlanItem(
                                snapshot.data['Id'].toString(),
                                tempProvider.selectDay.toString(),
                                snapshot.data['Description'].toString(),
                                tempProvider.selectedTime,
                                snapshot.data['FileName'].toString(),
                                snapshot.data['Calories'].toString(),
                                snapshot.data['ServingSize'].toString(),
                                snapshot.data['Name'].toString(),
                              );
                              // new TempDietFoodPlanItem(
                              //   snapshot.data.foodId.toString(),
                              //   tempProvider.selectDay.toString(),
                              //   snapshot.data.description.toString(),
                              //   tempProvider.selectedTime,
                              //   snapshot.data.fileName.toString(),
                              //   snapshot.data.calories.toString(),
                              //   snapshot.data.servingSize.toString(),
                              //   snapshot.data.name.toString(),
                              // );
                              tempModel.foodItems.add(foodItemModel);
                              tempProvider.setTempCustomDietPlanData(tempModel);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomBarNew(0)));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Number of servings can not be empty",
                              ),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 11, right: 11, top: 10, bottom: 8),
                                child: Text(
                                  'Add Food',
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('No Internet Connectivity'),
              );
            }

            // By default, show a loading spinner.
            return Center(child: const CircularProgressIndicator());
          },
        ),
      ),
    );
  }

// ############################ UPPER CONTAINER VIEW ##################################

  int servings = 1;

  upperContainer(
      BuildContext context, String name, carb, protein, fat, int cal) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: darkGrey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 8, top: 15),
            child: Text(name, style: style1),
          ),
          Row(
            children: [
              SizedBox(
                width: size.width * 0.02,
              ),
              Container(
                width: 110,
                child: Stack(
                  children: [
                    Graph(
                        carb.toDouble() * servings,
                        protein.toDouble() * servings,
                        fat.toDouble() * servings),
                    // _food.carbs.toDouble() * servings,
                    // _food.protein.toDouble() * servings,
                    // _food.fat.toDouble() * servings),
                    Positioned(
                        right: 0,
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${cal * servings}",
                              // "${_food.calories * servings}",
                              style: style.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                  fontSize: 19),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Cal',
                              style: style.copyWith(fontSize: 14),
                            ),
                          ],
                        ))),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: LinearPercentIndicator(
                              width: 80.0,
                              lineHeight: 7.0,
                              percent: carb / (carb + fat + protein),
                              // percent: _food.carbs /
                              //     (_food.carbs + _food.fat + _food.protein),
                              linearStrokeCap: LinearStrokeCap.butt,
                              backgroundColor: Colors.grey[300],
                              progressColor: purple,
                            ),
                          ),
                          Text(
                            '${double.parse('${(carb / (carb + fat + protein)) * 100}').toStringAsFixed(1)}%',
                            // '${double.parse('${(_food.carbs / (_food.carbs + _food.fat + _food.protein)) * 100}').toStringAsFixed(1)}%',
                            style:
                                style.copyWith(color: darkColor, fontSize: 11),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${double.parse('${carb * servings.toInt()}').toStringAsFixed(1)}g",
                            // "${_food.carbs * servings}g",
                            style: style.copyWith(
                                fontWeight: FontWeight.w600, color: purple),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Carb',
                            style: style.copyWith(color: darkColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: LinearPercentIndicator(
                              width: 80.0,
                              lineHeight: 7.0,
                              percent: fat / (carb + fat + protein),
                              // percent: _food.fat /
                              //     (_food.carbs + _food.fat + _food.protein),
                              linearStrokeCap: LinearStrokeCap.butt,
                              backgroundColor: Colors.grey[300],
                              progressColor: secondaryColor,
                            ),
                          ),
                          Text(
                            '${double.parse('${(fat / (carb + fat + protein)) * 100}').toStringAsFixed(1)}%',
                            // '${double.parse('${(_food.fat / (_food.carbs + _food.fat + _food.protein)) * 100}').toStringAsFixed(1)}%',
                            style:
                                style.copyWith(fontSize: 11, color: darkColor),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${double.parse('${fat * servings.toInt()}').toStringAsFixed(1)}g",
                            // "${_food.fat * servings}g",
                            style: style.copyWith(
                                fontWeight: FontWeight.w600,
                                color: secondaryColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Fat',
                            style: style.copyWith(color: darkColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: LinearPercentIndicator(
                              width: 80.0,
                              lineHeight: 7.0,
                              percent:
                                  (protein / (carb + fat + protein) ?? 0.0),
                              // percent: (_food.protein /
                              //         (_food.carbs +
                              //             _food.fat +
                              //             _food.protein) ??
                              //     0.0),
                              linearStrokeCap: LinearStrokeCap.butt,
                              backgroundColor: Colors.grey[300],

                              progressColor: pinkColor,
                            ),
                          ),
                          Text(
                            '${double.parse('${(protein / (carb + fat + protein)) * 100}').toStringAsFixed(1)}%',
                            // '${double.parse('${(_food.protein / (_food.carbs + _food.fat + _food.protein)) * 100}').toStringAsFixed(1)}%',
                            style:
                                style.copyWith(fontSize: 11, color: darkColor),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${double.parse('${protein * servings.toInt()}').toStringAsFixed(1)}g",
                              // "${_food.protein * servings}g",
                              style: style.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: pinkColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Protein',
                              style: style.copyWith(color: darkColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
            ],
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 8),
            child: Text('      ',
                style: style.copyWith(color: pinkColor, fontSize: 10)),
          )),
        ],
      ),
    );
  }

// ############################ MIDDLE CONTAINER VIEW ##################################

  middleContainer(int servingSize) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: darkGrey.withOpacity(0.1)),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: Text(
                    'Number of servings',
                    style: style.copyWith(fontSize: 15),
                  ),
                ),
                Expanded(
                    child: TextField(
                  controller: noOfServingsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: style1.copyWith(color: primaryColor),
                  ),
                  onChanged: (str) {
                    if (int.tryParse(str) > 5 || int.tryParse(str) < 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Should be Less than 5",
                        ),
                        backgroundColor: Colors.red,
                      ));
                      setState(() {
                        noOfServingsController.text = servings.toString();
                      });
                    } else {
                      servingSizeController.text =
                          (int.tryParse(str) * servingSize).toString();
                      // servingSizeController.text =
                      //     (int.tryParse(str) * _food.servingSize).toString();
                      servings = int.tryParse(str);
                      setState(() {});
                    }
                  },
                  style: style1.copyWith(color: primaryColor),
                )),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: darkGrey.withOpacity(0.1),
              ),
              right: BorderSide(
                color: darkGrey.withOpacity(0.1),
              ),
              bottom: BorderSide(
                color: darkGrey.withOpacity(0.1),
              ),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: Text(
                    'Servings Size',
                    style: style.copyWith(fontSize: 15),
                  ),
                ),
                Expanded(
                    child: TextField(
                  controller: servingSizeController,
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${servingSize}',
                    // hintText: '${_food.servingSize}',
                    hintStyle: style1.copyWith(color: primaryColor),
                  ),
                  style: style1.copyWith(color: primaryColor),
                )),
                Text(' grams', style: style.copyWith(color: primaryColor)),
              ],
            ),
          ),
        ),
      ],
    );
  }

// ############################ BOTTOM CONTAINER VIEW ##################################
/*
  bottomContainer(Dairy _dairy) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: darkGrey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 8, top: 15),
            child: Text('Percent From Your Daily Budget', style: style.copyWith(fontSize: 15)),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                        child: Text(
                          'Calories',
                          style: style.copyWith(color: darkColor),
                        ),
                      ),
                      LinearPercentIndicator(
                        lineHeight: 7.0,
                        percent: double.parse(percentCalories.toStringAsFixed(1)),
                        linearStrokeCap: LinearStrokeCap.butt,
                        backgroundColor: Colors.grey[300],
                        progressColor: primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${double.parse('${((_dairy.budgetVM.consCalories) / (_dairy.budgetVM.targetCalories)) * 100}').toStringAsFixed(1)}%',
                              style: style.copyWith(color: primaryColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Text(
                                "${_dairy.budgetVM.consCalories}g",
                                style: style.copyWith(fontSize: 12, color: darkColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                        child: Text(
                          'Carbs',
                          style: style.copyWith(color: darkColor),
                        ),
                      ),
                      LinearPercentIndicator(
                        lineHeight: 7.0,
                        percent: double.parse(carbPercent.toStringAsFixed(1)),
                        linearStrokeCap: LinearStrokeCap.butt,
                        backgroundColor: Colors.grey[300],
                        progressColor: secondaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${double.parse('${carbPercent * 100}').toStringAsFixed(1)}%',
                              style: style.copyWith(color: secondaryColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Text(
                                "${_dairy.budgetVM.carbs}g",
                                style: style.copyWith(fontSize: 12, color: darkColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                        child: Text(
                          'Fat',
                          style: style.copyWith(color: darkColor),
                        ),
                      ),
                      LinearPercentIndicator(
                        lineHeight: 7.0,
                        percent: double.parse(fatPercent.toStringAsFixed(1)),
                        linearStrokeCap: LinearStrokeCap.butt,
                        backgroundColor: Colors.grey[300],
                        progressColor: redColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${double.parse('${fatPercent * 100}').toStringAsFixed(1)}%',
                              style: style.copyWith(color: redColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Text(
                                "${_dairy.budgetVM.fat}g",
                                style: style.copyWith(fontSize: 12, color: darkColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                        child: Text(
                          'Protein',
                          style: style.copyWith(color: darkColor),
                        ),
                      ),
                      LinearPercentIndicator(
                        lineHeight: 7.0,
                        percent: double.parse(proteinPercent.toStringAsFixed(1)),
                        linearStrokeCap: LinearStrokeCap.butt,
                        backgroundColor: Colors.grey[300],
                        progressColor: primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${double.parse('${proteinPercent * 100}').toStringAsFixed(1)}%',
                              style: style.copyWith(color: primaryColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Text(
                                "${_dairy.budgetVM.protein}g",
                                style: style.copyWith(fontSize: 12, color: darkColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }*/
}
