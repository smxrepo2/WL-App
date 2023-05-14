import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/CustomExercisePlanProvider.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/burner_plan_model.dart';
import 'package:weight_loser/models/custom_exercise_provider_model.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/DietInnerTab.dart';

import 'package:weight_loser/screens/exercise_screens/CreateExerciseCustomPlan.dart';
import 'package:weight_loser/screens/exercise_screens/GetUpGoUp.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:http/http.dart' as http;
import 'package:weight_loser/widget/CustomAppBar.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

class SelectExercisePlan extends StatefulWidget {
  bool fromPlanSearch;

  SelectExercisePlan(this.fromPlanSearch);

  @override
  _SelectExercisePlanState createState() => _SelectExercisePlanState();
}

class _SelectExercisePlanState extends State<SelectExercisePlan>
    with TickerProviderStateMixin {
  TabController _tabController;

  List<Burners> tempBurners = [];
  List<Burners> allBurners = [];

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Today',
    ),
    Tab(text: 'Diet'),
    Tab(text: 'Exercise'),
    Tab(text: 'Mind'),
  ];

  Future<BurnerPlanModel> fetchAllBurner() async {
    final response = await http.get(
      Uri.parse('$apiUrl/api/burner'),
    );
    print("Res: ${response.body}");
    if (response.statusCode == 200) {
      setState(() {
        tempBurners =
            BurnerPlanModel.fromJson(jsonDecode(response.body)).burners;
        allBurners =
            BurnerPlanModel.fromJson(jsonDecode(response.body)).burners;

        print("Len: ${tempBurners.length}");
      });
      return BurnerPlanModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load burners');
    }
  }

  addExercise(int userId, int typeId, Burners burner, BuildContext context) {
    print("calories ${burner.calories}");
    post(
      Uri.parse('$apiUrl/api/diary'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "F_type_id": typeId,
        "Duration": burner.duration,
        "BurnerId": burner.id,
        "Burn_Cal": burner.calories
      }),
    ).then((value) {
      if (value.statusCode == 200) {
        final snackBar = SnackBar(
          content: Text(
            'Exercise Added',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightGreen,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      } else {
        final snackBar = SnackBar(
          content: Text(
            "Unable to add exercise",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      final snackBar = SnackBar(
        content: Text(
          error.toString(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllBurner();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.animateTo(2);
    final pp = Provider.of<UserDataProvider>(context, listen: false);
    if (!widget.fromPlanSearch) pp.setCustomPlanStatusCode(0);
  }

  @override
  Widget build(BuildContext context) {
    int initialIndex;

    double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.4;
    return Scaffold(
      appBar: titleAppBar(context: context, title: "Select Plan"),
      body: Container(
        child: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: MySize.size26,
            ),
            Container(
              decoration: BoxDecoration(
                // color: Colors.red,
                border: Border.all(
                  color: Colors.grey[100],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: MySize.size63,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (str) {
                          onSearchTextChanged(str);
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffdfdfdf),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: Container(
                            margin: EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.search,
                              color: Color(0xffafafaf),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(bottom: 4),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Color(0xffdfdfdf),
                              )),
                          // filled: true,
                          hintStyle: GoogleFonts.openSans(
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),

                          hintText: "Search..",
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MySize.size20,
            ),
            tempBurners == null || tempBurners.isEmpty
                ? Center(
                    child: Text("No any Plan avaliable"),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 280 / 350,
                        //childAspectRatio: (itemWidth / itemHeight),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: tempBurners.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          _showFoodDialog(
                              title: tempBurners[index].name,
                              imageUrl:
                                  '$imageBaseUrl${tempBurners[index].fileName}',
                              burner: tempBurners[index],
                              mainContext: context);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '$imageBaseUrl${tempBurners[index].fileName}'))),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(tempBurners[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "${tempBurners[index].duration} min",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }

  Future<void> _showFoodDialog(
      {title, imageUrl, Burners burner, BuildContext mainContext}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            var size = MediaQuery.of(context).size.width;
            var mobile = Responsive1.isMobile(context);
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              insetAnimationDuration: const Duration(seconds: 1),
              insetAnimationCurve: Curves.fastOutSlowIn,
              elevation: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.46,
                width: mobile ? MediaQuery.of(context).size.width : 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.38,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imageUrl))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20.0, left: 20),
                              child: DDText(title: title),
                            ),
                            GestureDetector(
                              onTap: () {
                                final provider = Provider.of<UserDataProvider>(
                                    context,
                                    listen: false);
                                if (provider.customPlanStatusCode == 0) {
                                  print(
                                      "provider type Id ${provider.foodTypeId}");
                                  int id = provider.foodTypeId;
                                  addExercise(1, 5, burner, mainContext);
                                } else if (provider.customPlanStatusCode == 1) {
                                  final tempProvider =
                                      Provider.of<CustomExercisePlanProvider>(
                                          context,
                                          listen: false);
                                  CustomExerciseProviderModel tempModel =
                                      tempProvider.customExercisePlanModel;
                                  ExerciseSetModel exerciseModel =
                                      new ExerciseSetModel(
                                    burner.id,
                                    tempProvider.selectDay.toString(),
                                    tempProvider.selectSet,
                                    burner.fileName.toString(),
                                    burner.calories.toString(),
                                    burner.duration.toString(),
                                    burner.name.toString(),
                                  );
                                  if (tempModel.exerciseItem.length == 0)
                                    tempModel.exerciseItem = [];
                                  tempModel.exerciseItem.add(exerciseModel);
                                  tempProvider
                                      .setTempCustomDietPlanData(tempModel);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateExerciseCustomPlan(1)));
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 20.0, right: 20),
                                child:
                                    DDText(title: "Add", color: primaryColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget leftRightheading(left, iconName, right, route) {
    return Container(
      padding: EdgeInsets.only(
        left: MySize.size16,
        right: MySize.size16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DDText(
            title: left,
            size: MySize.size15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => route));
            },
            child: Row(
              children: [
                Icon(
                  iconName,
                  size: 18,
                  color: primaryColor,
                ),
                DDText(
                  title: right,
                  size: MySize.size15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headingView(title, bottomPadding) {
    return Container(
      padding: EdgeInsets.only(left: MySize.size30, bottom: bottomPadding),
      child: Row(
        children: [
          DDText(
            title: title,
            size: MySize.size15,
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    List<Burners> list = [];

    if (text.isEmpty) {
      tempBurners = allBurners;
      setState(() {});
      return;
    } else {
      allBurners.forEach((burner) {
        if (burner.name.toLowerCase().contains(text)) list.add(burner);
      });

      tempBurners = list;
      setState(() {});
    }
  }
}
