import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/grocerylistProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/other_api.dart';
import 'package:weight_loser/models/grocery_model.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/FavouriteInnerTab.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomBottomNavigationBar.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

import '../notifications/getit.dart';
import '../utils/ImagePath.dart';

class GroceryList extends StatefulWidget {
  GroceryList({Key key, this.dashboard = false}) : super(key: key);
  bool dashboard;
  @override
  _GroceryListState createState() => _GroceryListState();
}

bool pressed = false;
int val = -1;

class _GroceryListState extends State<GroceryList> {
  GroceryListModel _groceryList;
  var groceryProvider = getit<groceryprovider>();
  Future<GroceryListModel> _groceryListFuture;
  var daysList = ["Today", "Week", "Month"];
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _groceryListFuture = fetchGrocery("today");
    groceryProvider?.addListener(UpdateGroceryDetails);
  }

  Future<GroceryListModel> fetchGrocery(String duration) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    final response = await http.get(Uri.parse(
        '$apiUrl/api/activeplans/grocerylist/?userId=$userid&duration=$duration'));
    if (response.statusCode == 200) {
      print("grocery data:" + response.body);
      var data = json.decode(response.body);
      _groceryList = GroceryListModel.fromJson(data);

      groceryProvider.setGroceryList(_groceryList);
      print("grocery data:" + _groceryList.toString());
      return _groceryList;
    } else {
      throw Exception('Failed to load grocery');
    }
  }

  void UpdateGroceryDetails() {
    if (mounted) setState(() {});
  }

  Future setPurchased(listId) async {
    print("ListId:" + listId.toString());
    int userId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userid');

    var response = await post(
      Uri.parse('$apiUrl/api/grocery'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{"ListId": listId, "UserID": userId}),
    );
    print("response:" + response.body);
    if (response.statusCode == 200) {
      UIBlock.unblock(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: response.body.contains("saved")
              ? Text("Item Added...")
              : Text("Item Removed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    // ignore: unused_local_variable
    int selectedIndex;

    return Scaffold(
        appBar: !widget.dashboard
            ? AppBar(
                iconTheme: IconThemeData(color: Colors.grey),
                elevation: 0.5,
                backgroundColor: Colors.white,
                actions: [
                  GestureDetector(
                    onTap: () {
                      print(
                          "Notification Key:" + context.widget.key.toString());
                      //if (context.widget.key != NotificationScreen().key)
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FavouriteTabInnerPage();
                      }));
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )),
                  ),
                ],
              )
            : PreferredSize(
                child: Padding(padding: EdgeInsets.only(top: 5)),
                preferredSize: Size.fromHeight(5)),
        body: FutureBuilder<GroceryListModel>(
          future: _groceryListFuture,
          builder: (context, snapshot) {
            //print(snapshot.data);
            if (snapshot.hasData) {
              GroceryListModel groceryList = groceryProvider.getGroceryList();

              //DateTime firstDate = DateTime.parse(groceryList.startDate);
              DateTime today = DateTime.now();
              DateTime secondDate = DateTime.parse(groceryList.endDate);
              var days = secondDate.difference(today).inDays;
              var formmatedDate = DateFormat('dd MMM').format(secondDate);
              int pending = 0;
              groceryList.groceryList.forEach(
                (element) {
                  element.items.forEach((element) {
                    if (element.purchased == false) pending += 1;
                  });
                },
              );

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          size: MySize.size14,
                        ),
                        onPressed: () {
                          setState(() {
                            counter++;
                            if (counter > 2) {
                              counter = 0;
                            }
                            if (counter == 0) {
                              _groceryListFuture = fetchGrocery("today");
                            } else if (counter == 1) {
                              _groceryListFuture = fetchGrocery("week");
                            } else if (counter == 2) {
                              _groceryListFuture = fetchGrocery("monthly");
                            }
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(MySize.size4),
                        child: DDText(
                          title: daysList[counter],
                          size: MySize.size15,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          size: MySize.size14,
                        ),
                        onPressed: () {
                          setState(() {
                            counter++;
                            if (counter > 2) {
                              counter = 0;
                            }
                            if (counter == 0) {
                              _groceryListFuture = fetchGrocery("today");
                            } else if (counter == 1) {
                              _groceryListFuture = fetchGrocery("weekly");
                            } else if (counter == 2) {
                              _groceryListFuture = fetchGrocery("monthly");
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: MySize.size10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DDText(
                                title: "Today - $formmatedDate",
                                center: false,
                                size: MySize.size11,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MySize.size16),
                                child: DDText(
                                  title: "$days days remaining",
                                  size: MySize.size11,
                                  center: false,
                                  weight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: MySize.size10),
                          child: Column(
                            children: [
                              DDText(title: "$pending"),
                              DDText(
                                title: "items pending",
                                size: MySize.size11,
                                weight: FontWeight.w300,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  snapshot.data.groceryList.length == 0
                      ? Center(child: Text("No Data is Available"))
                      : Expanded(
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: groceryList.groceryList.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        title: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        // right: MySize.size10,
                                                        bottom: MySize.size5,
                                                      ),
                                                      child: DDText(
                                                        title:
                                                            "${groceryList.groceryList[i].category}",
                                                        size: MySize.size15,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                        children: <Widget>[
                                          Column(children: [
                                            for (int index = 0;
                                                index <
                                                    groceryList.groceryList[i]
                                                        .items.length;
                                                index++)
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        top: BorderSide(
                                                            color: Colors
                                                                .grey[300],
                                                            width: 0.5))),
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        UIBlock.block(context);
                                                        groceryProvider
                                                            .setGroceryListItem(
                                                                !groceryList
                                                                    .groceryList[
                                                                        i]
                                                                    .items[
                                                                        index]
                                                                    .purchased,
                                                                i,
                                                                index);
                                                        await setPurchased(
                                                                groceryList
                                                                    .groceryList[
                                                                        i]
                                                                    .items[
                                                                        index]
                                                                    .listId)
                                                            .then((value) {});

                                                        //UpdateGroceryDetails();
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: ListTile(
                                                              leading: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              6.0),
                                                                  child:
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              Icon(
                                                                            Icons.check_circle,
                                                                            color: groceryList.groceryList[i].items[index].purchased
                                                                                ? Colors.green
                                                                                : Colors.grey,
                                                                          ))),
                                                              dense: true,
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 14),
                                                              horizontalTitleGap:
                                                                  2.0,
                                                              // leading: Padding(
                                                              //   padding: EdgeInsets.only(
                                                              //       bottom: 16.0),
                                                              //   child: Radio(
                                                              //     toggleable: true,
                                                              //     value: index,
                                                              //     groupValue: val,
                                                              //     onChanged: (int value) {
                                                              //       setState(() {
                                                              //         val = value;
                                                              //       });
                                                              //       print(index);
                                                              //     },
                                                              //     activeColor: Colors.green,
                                                              //   ),
                                                              // ),
                                                              // trailing: Icon(
                                                              //   Icons.check,
                                                              //   color: expansionTileData[index]
                                                              //           ["selected"]
                                                              //       ? Colors.green
                                                              //       : Colors.grey,
                                                              // ),
                                                              title:
                                                                  GestureDetector(
                                                                onTap: () {},
                                                                child: Text(
                                                                  groceryList
                                                                      .groceryList[
                                                                          i]
                                                                      .items[
                                                                          index]
                                                                      .item,
                                                                  style: GoogleFonts
                                                                      .openSans(
                                                                    fontSize: MySize
                                                                        .size11,
                                                                    decoration: !groceryList
                                                                            .groceryList[
                                                                                i]
                                                                            .items[
                                                                                index]
                                                                            .purchased
                                                                        ? TextDecoration
                                                                            .lineThrough
                                                                        : TextDecoration
                                                                            .none,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child:
                                                                  Container()),
                                                          Expanded(
                                                            child: Icon(
                                                              Icons.check,
                                                              color: groceryList
                                                                      .groceryList[
                                                                          i]
                                                                      .items[
                                                                          index]
                                                                      .purchased
                                                                  ? Colors.green
                                                                  : Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    // expansionTileData[index] ==
                                                    //         expansionTileData.last
                                                    //     ? Divider(
                                                    //         height: 0,
                                                    //         thickness: 0.5,
                                                    //         color: Colors.transparent,
                                                    //       )
                                                    //     : Divider(
                                                    //         height: 0,
                                                    //         thickness: 0.5,
                                                    //         color: Colors.grey[300],
                                                    //       )
                                                  ],
                                                ),
                                              ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                    ),
                                  ],
                                );
                              }),
                        )
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
