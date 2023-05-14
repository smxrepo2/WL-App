import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:weight_loser/Component/DDToast.dart';
import 'package:weight_loser/Provider/ConnectionService.dart';
import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/Today_api.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';

import 'package:weight_loser/screens/navigation_tabs/Todayscreen.dart';
import 'package:weight_loser/screens/navigation_tabs/foodreplacementprov.dart';
import 'package:weight_loser/screens/navigation_tabs/homepage/middle.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
//import 'package:weight_loser/widget/FoodDialog.dart';
import 'package:weight_loser/widget/Shimmer/Food%20Dialog%20Shimmer.dart';
import 'package:weight_loser/widget/SideMenu.dart';
import 'package:weight_loser/widget/home.dart';

import '../../Provider/UserDataProvider.dart';
import '../../constants/constant.dart';
import '../../notifications/getit.dart';

SimpleFontelicoProgressDialog _dialog;

class ReplaceDietPlan extends StatefulWidget {
  ReplaceDietPlan(
      {Key key,
      @required this.eatingTime,
      @required this.foodId,
      @required this.planId,
      @required this.reLoad})
      : super(key: key);
  int eatingTime;
  int foodId;
  int planId;
  Function() reLoad;

  @override
  State<ReplaceDietPlan> createState() => _ReplaceDietPlanState();
}

class _ReplaceDietPlanState extends State<ReplaceDietPlan> {
  TextEditingController _searchC = TextEditingController();
  TabController innerTabController;
  int userid;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Responsive1.isMobile(context)
              ? customAppBar(
                  context,
                  elevation: 0.0,
                )
              : Padding(padding: EdgeInsets.only(top: 5)),
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            /*
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //DDText(title: "${widget.type}", size: MySize.size14),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 15),
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Colors.blue)),
                      child: TextField(
                        controller: _searchC,
                        // onChanged: onSearchTextChanged,
                        decoration: InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.blue),
                            contentPadding: EdgeInsets.only(top: 4, bottom: 0)),
                      ),
                    ),
                  ),
                  Transform.rotate(
                      angle: pi / 2,
                      child: Icon(Icons.tune_rounded, color: Colors.blue))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            */
            TabBar(
              controller: innerTabController,
              labelColor: Colors.blue,
              labelStyle: GoogleFonts.openSans(
                  fontSize: 12, fontWeight: FontWeight.w500),
              //unselectedLabelColor: Colors.grey,
              tabs: [
                widget.eatingTime == 0
                    ? Tab(text: 'Breakfast')
                    : widget.eatingTime == 1
                        ? Tab(text: "Snacks")
                        : widget.eatingTime == 2
                            ? Tab(text: "lunch")
                            : Tab(text: "Dinner"),
                //Tab(text: 'Snacks'),
                //Tab(text: 'Lunch'),
                //Tab(text: 'Dinner'),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              child: TabBarView(
                controller: innerTabController,
                children: [
                  tabWidget(
                      eatingTime: widget.eatingTime,
                      foodId: widget.foodId,
                      planId: widget.planId,
                      reLoad: widget.reLoad),
                  //tabWidget(),
                  //tabWidget(),
                  //tabWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class tabWidget extends StatefulWidget {
  tabWidget(
      {Key key,
      @required this.eatingTime,
      @required this.foodId,
      @required this.planId,
      @required this.reLoad})
      : super(key: key);
  int eatingTime;
  int foodId;
  int planId;
  Function() reLoad;
  @override
  State<tabWidget> createState() => _tabWidgetState();
}

class _tabWidgetState extends State<tabWidget> {
  List foodItems = [];
  bool isLoading = true;
  int _currMax;
  List myList = [];
  ScrollController _scrollController = ScrollController();
  int _noofdoc;
  int listgen;
  Future<List<dynamic>> _replaceFoodFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    replaceFood(widget.eatingTime, context).then((foodList) {
      UserDataProvider _userDataProvider = Provider.of(context, listen: false);
      foodItems = foodList;

      _noofdoc = _userDataProvider.itemCount;
      _noofdoc <= 2
          ? () {
              _currMax = 2;
              listgen = 2;
            }()
          : _noofdoc <= 4
              ? () {
                  _currMax = 2;
                  listgen = 2;
                }()
              : _noofdoc <= 6
                  ? () {
                      _currMax = 4;
                      listgen = 4;
                    }()
                  : _noofdoc <= 8
                      ? () {
                          _currMax = 6;
                          listgen = 6;
                        }()
                      : () {
                          _currMax = 6;
                          listgen = 6;
                        }();
      print("No of docs:" + _noofdoc.toString());
      print("No of items:" + foodItems.length.toString());
      myList = List.generate(listgen, (index) => index);
      setState(() {
        isLoading = false;
      });
    });
    _scrollController.addListener(() {
      print("scrolled");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("scrolled down for more");
        print("myListLength:" + myList.length.toString());
        if (myList.length + 2 < _noofdoc) {
          loadmoreitems();
        }

        //print(listitems);
      }
    });
    //foodItems.clear();
  }

  Future replaceSingleFood(int foodId, int planId, int repFoodId) async {
    _dialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    _dialog.show(
        message: "Please wait", type: SimpleFontelicoProgressDialogType.normal);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('userid');

    var client = http.Client();

    try {
      var url =
          Uri.parse('https://weightchoper.somee.com/api/food/Replacement/');
      var response = await client.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept': '*/*',
            'User-Agent': 'PostmanRuntime/7.28.4',
            'Cookie':
                '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
          },
          body: json.encode({
            "userId": userid,
            "PlanFoodId": "$foodId",
            "PlanId": planId,
            "RepFoodId": "$repFoodId"
          }));
      print("Replacement Response:" + response.body);
    } catch (e) {
      print(e);
    } finally {
      _dialog.hide();
      client.close();
    }
  }

  loadmoreitems() async {
    print("load more items");
    await replaceFood(widget.eatingTime, context)
        .then((List<dynamic> foodList) {
      foodList.forEach((element) {
        foodItems.add(element);
      });
      for (int i = _currMax; i < _currMax + 6; i++) {
        myList.add(i);
      }
      //if (myList.length < _totalDocs)
      _currMax = _currMax + 6;
      if (_currMax >= _noofdoc) {
        int length = _currMax - _noofdoc;
        _currMax = _currMax - length;
        myList.length = _currMax - 2;
        print("List Length:" + myList.length.toString());
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    int ingredientOrProcedure = 0;
    //foodItems.clear();

    return !isLoading
        ? GridView.builder(
            //shrinkWrap: true,
            controller: _scrollController,
            itemCount: myList.length + 2,
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              if (index == myList.length + 1 && myList.length + 2 != _noofdoc) {
                //CupertinoColors.activeOrange;
                print("load cupertino:" + index.toString());
                return Center(
                  child: CupertinoTheme(
                    data: CupertinoTheme.of(context).copyWith(
                        brightness: Brightness.dark,
                        primaryColor: Colors.black),
                    child: CupertinoActivityIndicator(
                        color: Colors.black, radius: 14),
                  ),
                );
                //return CupertinoActivityIndicator();
              }
              if (index == myList.length && myList.length + 2 != _noofdoc) {
                return CupertinoTheme(
                  data: CupertinoTheme.of(context).copyWith(
                      brightness: Brightness.dark, primaryColor: Colors.black),
                  child: CupertinoActivityIndicator(
                      color: Colors.black, radius: 14),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await replaceSingleFood(widget.foodId, widget.planId,
                              int.parse(foodItems[index]['FoodId']))
                          .then((value) {
                        print("eatingTime ${widget.eatingTime}");

                        _dialog.hide();
                        //Navigator.of(context).push(MaterialPageRoute(
                        //  builder: (_) => BottomBarNew(0)));
                        Navigator.of(context).pop();
                        widget.reLoad();
                      });

                      /*
                showReplaceFoodDialog(
                    context,
                    foodItems[index]['Name'],
                    foodItems[index]['ServingSize'],
                    foodItems[index]['Calories'],
                    foodItems[index]['Carbs'],
                    foodItems[index]['fat'],
                    foodItems[index]['Protein'],
                    foodItems[index]['Description'],
                    foodItems[index]['Ingredients'],
                    "$imageBaseUrl${foodItems[index]['FileName']}",
                    foodItems[index]['MealType'],
                    widget.eatingTime,
                    foodItems[index]['FoodId']);
              */
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Card(
                        elevation: 0.9,
                        child: Column(
                          children: [
                            Container(
                                height: 80,
                                width: double.infinity,
                                child: Image.network(
                                  "$imageBaseUrl${foodItems[index]['FileName']}",
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(height: 2),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 60,
                                    child: Text(
                                      foodItems[index]['Name'],
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${foodItems[index]['ServingSize']} g",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 3),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8, bottom: 4),
                              child: Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    print("tapped");
                                    showReplaceFoodDialog(
                                        context,
                                        foodItems[index]['Name'],
                                        foodItems[index]['ServingSize'],
                                        foodItems[index]['Calories'],
                                        foodItems[index]['Carbs'],
                                        foodItems[index]['fat'],
                                        foodItems[index]['Protein'],
                                        foodItems[index]['Description'],
                                        foodItems[index]['Ingredients'],
                                        "$imageBaseUrl${foodItems[index]['FileName']}",
                                        foodItems[index]['MealType'],
                                        widget.eatingTime,
                                        foodItems[index]['FoodId']);
                                  },
                                  child: Text(
                                    "Details",
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            /*
                      SizedBox(height: 3),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8, bottom: 4),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "${foodItems[index]['Calories']} cal",
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      */
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            })
        : Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                physics: ScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                              height: 130,
                              child: Image.network(
                                  '$imageBaseUrl${foodItems[index]['FileName']}')),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("chiken"),
                              Text("25 g"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "3 cal",
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}

showReplaceFoodDialog(
    BuildContext context,
    title,
    serving,
    cal,
    carb,
    fat,
    protein,
    description,
    ingredients,
    imageurl,
    mealtype,
    selectedEatingTime,
    foodId) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      var id = int.parse(foodId);
      var ingradient = jsonDecode(ingredients);
      print(id);
      var other;
      return StatefulBuilder(
        builder: (context, setState) {
          var size = MediaQuery.of(context).size.width;
          var mobile = Responsive1.isMobile(context);
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: Responsive1.isMobile(context)
                  ? EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      right: MediaQuery.of(context).size.width * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.width * 0.05)
                  : EdgeInsets.only(left: 400, right: 400, top: 10),
              child: Container(
                width: Responsive1.isMobile(context) ? double.infinity : 500,
                height: Responsive1.isMobile(context) ? double.infinity : 560,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            mobile ? EdgeInsets.all(8.0) : EdgeInsets.all(2.0),
                        child: SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: mobile
                                    ? MediaQuery.of(context).size.width * 0.20
                                    : size * 0.15,
                                height: mobile
                                    ? MediaQuery.of(context).size.width * 0.2
                                    : size * 0.09,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: Image.network(imageurl)
                                            //'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=')
                                            .image,
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: mobile
                                    ? MediaQuery.of(context).size.width * 0.03
                                    : size * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    title,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.002,
                                  ),
                                  Text(
                                    '${serving} Serving, ${serving} grams',
                                    style: GoogleFonts.openSans(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Container(
                                    // width:55,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: FutureBuilder(
                                        future: fetchOtherDetail(id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.connectionState ==
                                                  ConnectionState.done) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                snapshot.data['Cuisine'] ??
                                                    "indian",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            );
                                          } else if (snapshot.hasData &&
                                              snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[100],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "indian",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            );
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "  ",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                width: mobile
                                    ? MediaQuery.of(context).size.width * 0.2
                                    : size * 0.07,
                                height: mobile
                                    ? MediaQuery.of(context).size.width * 0.2
                                    : size * 0.07,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cals',
                                      style: GoogleFonts.openSans(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                    Text(
                                      "${cal.toString()}",
                                      style: GoogleFonts.openSans(
                                          color: Colors.black, fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: mobile
                                    ? MediaQuery.of(context).size.width * 0.03
                                    : size * .02,
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: Responsive1.isMobile(context),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.01,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Carb',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${carb}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Fat',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${fat}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Protein',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Text(
                                      '${protein}g',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Other',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 15,
                                      child: FutureBuilder(
                                          future: fetchOtherDetail(id),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot.connectionState ==
                                                    ConnectionState.done) {
                                              return Text(
                                                '${snapshot.data['SatFat'] + snapshot.data['Sodium'] + snapshot.data['Fiber']}g',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              );
                                            } else if (snapshot.hasData &&
                                                snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey[300],
                                                highlightColor:
                                                    Colors.grey[100],
                                                child: Text(
                                                  // '${other ?? 0}g',
                                                  '0g',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              );
                                            }
                                            return Text(
                                              // '${other ?? 0}g',
                                              '0g',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                                Text(
                                  '0g left',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile
                            ? MediaQuery.of(context).size.width * 0.02
                            : size * 0.00,
                      ),
                      Padding(
                        padding: mobile
                            ? EdgeInsets.symmetric(horizontal: 10)
                            : EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 0;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 0
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Morning',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 1;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 1
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Snack',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 2;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 2
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Lunch',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedEatingTime = 3;
                                // });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedEatingTime == 3
                                        ? Color(0xff4885ED)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Padding(
                                  padding: mobile
                                      ? EdgeInsets.symmetric(
                                          horizontal: size * 0.03,
                                          vertical: size * 0.02)
                                      : EdgeInsets.symmetric(
                                          horizontal: size * 0.01,
                                          vertical: size * 0.01),
                                  child: Text(
                                    'Dinner',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      color: selectedEatingTime == 3
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          'Serving Size',
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              serving.toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Grams',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.00,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: mobile ? size * 0.02 : size * 0.01,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ingredientOrProcedure = 0;
                                        });
                                      },
                                      child: Text(
                                        'Ingredients',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: ingredientOrProcedure == 0
                                                ? Colors.black
                                                : Colors.grey),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.001,
                                    ),
                                    ingredientOrProcedure == 0
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.002,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color(0xff4885ED)),
                                          )
                                        : Container()
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ingredientOrProcedure = 1;
                                        });
                                      },
                                      child: Text(
                                        'Procedure',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: ingredientOrProcedure == 1
                                                ? Colors.black
                                                : Colors.grey),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.001,
                                    ),
                                    ingredientOrProcedure == 1
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.002,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color(0xff4885ED)),
                                          )
                                        : Container()
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey, width: .5)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: ingredientOrProcedure == 0
                                    ? ingradient == null
                                        ? Text("No any Ingradients")
                                        : ListView.builder(
                                            itemCount: ingradient.length,
                                            itemBuilder: (context, index) {
                                              return Text(ingradient[index]);
                                            })
                                    : ingredientOrProcedure == 1
                                        ? description == null
                                            ? Text("No Description Updated")
                                            : Text(description
                                                .replaceAll("[", "")
                                                .replaceAll("\"", "")
                                                .replaceAll("]", "")
                                                .replaceAll("<p>", "")
                                                .replaceAll("</p>", ""))
                                        : "Not Available",
                                // child: Text(
                                //   ingredientOrProcedure == 0
                                //       ? ingredients == null
                                //           ? "No Ingredients Updated"
                                //           : ingredients
                                //       .replaceAll("<p>", "")
                                //       .replaceAll("</p>", "")
                                //       .replaceAll("[", "")
                                //       .replaceAll("\"", "")
                                //       .replaceAll("]", "")
                                //       : ingredientOrProcedure == 1
                                //           ? description == null
                                //               ? "No Description Updated"
                                //               : description
                                //                   .replaceAll("[", "")
                                //                   .replaceAll("\"", "")
                                //                   .replaceAll("]", "")
                                //                   .replaceAll("<p>", "")
                                //                   .replaceAll("</p>", "")
                                //           : "Not Available",
                                //   style: GoogleFonts.montserrat(
                                //       fontSize: 12, color: Colors.grey),
                                // ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      /*
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _dialog = SimpleFontelicoProgressDialog(
                                  context: context, barrierDimisable: true);
                              _dialog.show(
                                  message: "Please wait",
                                  type:
                                      SimpleFontelicoProgressDialogType.normal);
                              print(mealtype);
                              double servingDouble =
                                  double.parse(serving.toString());
                              int servings = servingDouble.toInt();
                              var typeId;
                              if (mealtype == "Breakfast") {
                                typeId = 1;
                              } else if (mealtype == "Lunch") {
                                typeId = 2;
                              } else if (mealtype == "Dinner") {
                                typeId = 3;
                              } else if (mealtype == "Snacks") {
                                typeId = 4;
                              }
                              int user;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              user = prefs.getInt('userid');
                              post(
                                Uri.parse('$apiUrl/api/diary'),
                                headers: <String, String>{
                                  'Content-Type': 'application/json',
                                },
                                body: jsonEncode(<String, dynamic>{
                                  "userId": user,
                                  "F_type_id": typeId,
                                  "FoodId": id.toString(),
                                  "Cons_Cal": cal,
                                  "ServingSize": servings,
                                  "fat": fat,
                                  "Protein": protein,
                                  "Carbs": carb
                                }),
                              ).then((value) {
                                _dialog.hide();
                                print(value.body);
                                /*final snackBar = SnackBar(
                                        content: Text(
                                          'Meal Added',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.lightGreen,
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);*/
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SideMenu()));
                              }).onError((error, stackTrace) {
                                _dialog.hide();
                                print(error.toString());
                                DDToast().showToast(
                                    "message", error.toString(), true);
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xff4885ED)),
                              child: Center(
                                child: Text(
                                  'Add Food',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ), */
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ));
        },
      );
    },
  );
}
