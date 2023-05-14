import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/CustomExercisePlanProvider.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/custom_exercise_provider_model.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/DietInnerTab.dart';
import 'package:weight_loser/screens/exercise_screens/MyPlansExercise.dart';

import 'package:weight_loser/screens/exercise_screens/SelectExercisePlan.dart';
import 'package:weight_loser/screens/exercise_screens/methods/methods.dart';
import 'package:weight_loser/screens/exercise_screens/models/added_exercises.dart';
import 'package:weight_loser/screens/exercise_screens/models/custom_exercise_model.dart';
import 'package:weight_loser/screens/exercise_screens/providers/add_exercise_provider.dart';
import 'package:weight_loser/screens/exercise_screens/providers/customexerciseProvider.dart';
import 'package:weight_loser/screens/exercise_screens/search/search.dart';

import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/AppBarView.dart';

import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/dialog_with_input_field_widget.dart';

import 'package:flutter/material.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

import '../../notifications/getit.dart';

int exerciseSelected = 0;

class CreateExerciseCustomPlan extends StatefulWidget {
  int activeCode;

  CreateExerciseCustomPlan(this.activeCode);

  @override
  State<CreateExerciseCustomPlan> createState() =>
      _CreateExerciseCustomPlanState();
}

class _CreateExerciseCustomPlanState extends State<CreateExerciseCustomPlan> {
  int day = 1;
  int daysAdded = 1;
  List<bool> plandays = [];

  List<AddedExercisePlanItem> _addedList = [];
  Future<CustomExerciseModel> _customExerciseFuture;
  var _customexerciseProvider = getit<customexerciseprovider>();
  var _exerciseProvider = getit<addedexerciselistprovider>();
  List<Burners> exerciseItems;
  GlobalKey<FormState> _exeCustomDays = GlobalKey<FormState>();
  GlobalKey<FormState> _exeCustomSelectedFood = GlobalKey<FormState>();
  GlobalKey<FormState> _exeCustomSearch = GlobalKey<FormState>();
  GlobalKey<FormState> _exeCustomCuisineList = GlobalKey<FormState>();
  //GlobalKey<FormState> _dietCustomAddFood = GlobalKey<FormState>();
  GlobalKey<FormState> _exeCustomSaveDiet = GlobalKey<FormState>();
  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("customexeshowcaseStatus");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 100; i++) {
      plandays.add(false);
    }
    _customExerciseFuture = GetCustomExerciseData();
    _exerciseProvider.deleteAll();
    _exerciseProvider.deleteAllItemId();
    _customexerciseProvider.setPlanId(null);
    print("Plan Id:${_customexerciseProvider.getPlanId()}");

    _exerciseProvider.addListener(() {
      if (mounted) setState(() {});
    });
    checkshowcaseStatus().then((value) {
      if (!value) {
        print("showcase:$value");
        setState(() {
          showcaseStatus = true;
        });
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
            _exeCustomDays,
            _exeCustomSelectedFood,
            _exeCustomSearch,
            //_exeCustomCuisineList,
            // _dietCustomAddFood,
            _exeCustomSaveDiet
          ]),
        );
      } else {
        setState(() {
          showcaseStatus = false;
        });
      }
    });
  }

  Future addExerciseToCustomPlan(int planId) {
    exerciseItems = _exerciseProvider.getBurnerList();

    exerciseItems.forEach((element) async {
      print("burner id ${element.id}");

      var response = await http.post(
        Uri.parse('$apiUrl/api/plan/ExercisePlan'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "BurnerId": element.id,
          "PlanId": planId,
          "Day": day.toString(),
          "Title": element.name ?? "No Name"
        }),
      );

      if (response.statusCode == 200) {
        print("exercise then ${response.statusCode}${response.body} ");
        //statusCodes.add(response.statusCode);
        _exerciseProvider.deleteAddedFood(int.parse(element.id.toString()));
        _exerciseProvider.deleteAddedFoodId(int.parse(element.id.toString()));
        print("Remaining Items ${_exerciseProvider.getBurnerList().length}");
        if (_exerciseProvider.getBurnerList().length == 0) {
          setState(() {
            UIBlock.unblock(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Row(
                  children: [
                    Icon(Icons.done_all_rounded),
                    SizedBox(width: 10),
                    Text("Custom Plan for Day $day is uploaded"),
                  ],
                )));

            if (day <= 100) {
              plandays.insert(day - 1, true);
              day += 1;
              daysAdded += 1;

              //print(plandays[day - 1]);
            }

            //foodItems.clear();
          });
        }
      } else
        print("Response:${response.statusCode}");
    });
  }

  Future<Response> AddPlan(username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');

    Dio dio = new Dio();
    FormData formdata = new FormData();
    //String fileName = imageFile.path.split('/').last;
    int max = 100;

    formdata = FormData.fromMap({
      "PlanTypeId": 2,
      "Title": "${Random().nextInt(max)}",
      "Description": "",
      "Details": "",
      "duration": 7,
      "Calories": 105,
      "UserId": userid,
      //"FileName" : fileName,
      //"ImageFile": await MultipartFile.fromFile(
      //imageFile.path,
      //filename: fileName,
      //contentType: new MediaType("image", "jpeg"),
      //  ),
      "Cuisine": "",
    });
    return dio.post('$apiUrl/api/plan/addplan',
        onSendProgress: (int sent, int total) {
      print('$sent $total');
    },
        data: formdata,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<CustomExerciseModel>(
        future: _customExerciseFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

              break;
            case ConnectionState.done:
            default:
              if (snapshot.hasError)
                return Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        'Create Custom Plan',
                        style: TextStyle(color: Colors.black),
                      ),
                      elevation: 1,
                      backgroundColor: Colors.white,
                      iconTheme: const IconThemeData(color: Colors.black),
                    ),
                    body: Center(child: Text("No Internet Connectivity")));
              else if (snapshot.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'Create Custom Plan',
                      style: TextStyle(color: Colors.black),
                    ),
                    elevation: 1,
                    backgroundColor: Colors.white,
                    iconTheme: const IconThemeData(color: Colors.black),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  day--;
                                  if (day < 1) {
                                    day = 1;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_back_ios, size: 12.5),
                            ),
                            ShowCaseView(
                              globalKey: _exeCustomDays,
                              title: "Select Day",
                              description:
                                  "Custom plan would be saved for selected day, select another day to save exercises in same plan",
                              shapeBorder: BeveledRectangleBorder(),
                              child: Text(
                                'Day ${day > 100 ? 100 : day}',
                                style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 12,
                                  color: Color(0xcc1e1e1e),
                                  fontWeight: FontWeight.w600,
                                ),
                                softWrap: false,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  day++;
                                  if (day > 100) {
                                    day = 100;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_forward_ios, size: 12.5),
                            ),
                            const Spacer(),
                            ShowCaseView(
                              globalKey: _exeCustomSelectedFood,
                              title: "Selected Exercises",
                              description:
                                  "Number of exercises selected for a day",
                              shapeBorder: BeveledRectangleBorder(),
                              child: Text(
                                'Exercise Selected: ${_exerciseProvider.getBurnerList().length}',
                                style: const TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 10,
                                  color: Color(0x991e1e1e),
                                ),
                                softWrap: false,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'Select Custom Exercise',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 10,
                              color: const Color(0x991e1e1e),
                            ),
                            softWrap: false,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchExercises(),
                                      ),
                                    );
                                  },
                                  child: ShowCaseView(
                                    globalKey: _exeCustomSearch,
                                    title: "Search Exercises",
                                    description:
                                        "Search for exercises to add in custom plan",
                                    shapeBorder: BeveledRectangleBorder(),
                                    child: TextField(
                                      style: lightText12Px,
                                      enabled: false,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                  color: Colors.black45,
                                                  width: 0.1)),
                                          prefixIcon: const Icon(
                                            Icons.search,
                                            size: 20,
                                            color: Colors.black45,
                                          ),
                                          hintText: "Search"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                            indent: 50,
                            endIndent: 50,
                            thickness: 2,
                            height: 10),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: _customexerciseProvider
                                  .getExerciseList()
                                  .length,
                              itemBuilder: (context, index) {
                                return ExerciseTile(
                                    listItem: snapshot.data.burners[index],
                                    notifyParent: () => setState(() {}));
                              }),
                        )
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: ShowCaseView(
                    globalKey: _exeCustomSaveDiet,
                    title: "Save Exercise",
                    description:
                        "Tap to save exercise for a specific day and a plan would be created",
                    child: FloatingActionButton.extended(
                      extendedPadding: const EdgeInsets.symmetric(
                          horizontal: 22.5, vertical: 0),
                      label: const Text('Save Exercises'),
                      extendedTextStyle: const TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 15,
                        color: Color(0xffffffff),
                        height: 0.9333333333333333,
                      ),
                      backgroundColor: Colors.blueAccent,
                      onPressed: () {
                        print("Plan Day $day is: ${plandays[day - 1]}");
                        if (daysAdded <= 100 && plandays[day - 1] == false) {
                          var _foodProvider =
                              getit<addedexerciselistprovider>();
                          List<Burners> foodItems =
                              _foodProvider.getBurnerList();
                          print("Food Items Length:" +
                              foodItems.length.toString());

                          if (foodItems.length > 0) {
                            UIBlock.block(context);

                            if (_customexerciseProvider.getPlanId() == null) {
                              print("Creating Plan Id");
                              AddPlan("").then((value) {
                                if (value.statusCode == 200) {
                                  print("Created Plan:" +
                                      value.data['planId'].toString());
                                  _customexerciseProvider
                                      .setPlanId(value.data['planId']);
                                  addExerciseToCustomPlan(value.data['planId']);
                                  //.then((value) {

                                  // });
                                }
                              });
                            } else {
                              addExerciseToCustomPlan(
                                  _customexerciseProvider.getPlanId());
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Row(
                                  children: [
                                    Icon(Icons.error_outline_rounded),
                                    SizedBox(width: 10),
                                    Text("Please select items to add in plan"),
                                  ],
                                )));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Row(
                                children: [
                                  Icon(Icons.error_outline_rounded),
                                  SizedBox(width: 10),
                                  Text("Already Added"),
                                ],
                              )));
                        }
                      },
                    ),
                  ),
                );
              } else
                return Center(child: Text("No Data"));
          }
        },
      ),
    );
  }
}

class ExerciseTile extends StatefulWidget {
  ExerciseTile({
    Key key,
    this.listItem,
    this.notifyParent,
  }) : super(key: key);
  final Burners listItem;
  final Function() notifyParent;

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  bool isSelected = false;
  List<int> exerciseItemsId;
  List<Burners> exerciseItems;
  var _exerciseProvider = getit<addedexerciselistprovider>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    exerciseItems = _exerciseProvider.getBurnerList();
    exerciseItemsId = _exerciseProvider.getExerciseListId();

    _exerciseProvider.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: Image.network(
                                  '$imageBaseUrl${widget.listItem.fileName ?? 'https://www.verywellfit.com/thmb/J2Nl2AnM4FS2IM_XtGKEn9QWBRs=/500x350/filters:no_upscale():max_bytes(150000):strip_icc()/what-is-vigorous-intensity-exercise-3435408-0973-1602bd0a4ec54abb8808648de38b52cd.jpg'}')
                              .image,
                          fit: BoxFit.cover)),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        widget.listItem.name ?? "Not Available",
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 15,
                          color: const Color(0xff2b2b2b),
                          fontWeight: FontWeight.w300,
                        ),
                        softWrap: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.002,
                      ),
                      Text(
                        '${widget.listItem.duration} mins',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: const Color(0xffafafaf),
                        ),
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Column(
                    children: [
                      Text(
                        '${widget.listItem.calories} kcal',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 15,
                          color: const Color(0xff2b2b2b),
                        ),
                        softWrap: false,
                      ),
                      IconButton(
                        onPressed: () {
                          if (!exerciseItemsId.contains(
                              int.parse(widget.listItem.id.toString()))) {
                            //isSelected = true;

                            _exerciseProvider.setListItem(widget.listItem);
                            _exerciseProvider.setAddedItemId(
                                int.parse(widget.listItem.id.toString()));
                          } else {
                            //isSelected = false;

                            _exerciseProvider.deleteAddedFood(
                                int.parse(widget.listItem.id.toString()));
                            _exerciseProvider.deleteAddedFoodId(
                                int.parse(widget.listItem.id.toString()));
                          }
                        },
                        icon: exerciseItemsId.contains(
                                int.parse(widget.listItem.id.toString()))
                            ? const Icon(Icons.check, color: Colors.blueAccent)
                            : const Icon(Icons.add, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(
              indent: 20,
              endIndent: 20,
              thickness: 2,
              height: 20,
              color: Colors.grey.shade200),
        ],
      ),
    );
  }
}
