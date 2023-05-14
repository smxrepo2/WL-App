import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/GroceryList.dart';
import 'package:weight_loser/screens/exercise_screens/RunningTab.dart';
import 'package:weight_loser/screens/food_screens/DietTabView.dart';
import 'package:weight_loser/screens/food_screens/NutritionScreenView.dart';
import 'package:weight_loser/screens/food_screens/SearchFood.dart';
import 'package:weight_loser/screens/mind_screens/MindTabView.dart';
import 'package:weight_loser/screens/mind_screens/PlansScreen.dart';
import 'package:weight_loser/screens/navigation_tabs/Todayscreen.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';
import 'package:weight_loser/widget/add_water_widget.dart';
import 'package:weight_loser/widget/add_weight_widget.dart';

import '../Daily Log/Daily_log.dart';
import '../UltimateSelfieView.dart';
import '../diet_plan_screens/tabs/FavouriteInnerTab.dart';
import '../recipie/views/body.dart';

class BottomBarNew extends StatefulWidget {
  static int currentTabIndex;
  bool tabBar = false;
  final checkIndex;

  BottomBarNew(this.checkIndex, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<BottomBarNew>
    with AutomaticKeepAliveClientMixin<BottomBarNew> {
  @override
  bool get wantKeepAlive => true;

  bool _isShowDial = false;
  bool _isVisible = false;
  UserDataProvider provider;
  Widget currentScreen;
  TabController _tabController;

  int _selectedIndexForBottomBar = 0;
  int _selectedIndexForTabBar = 0;

  //1
  final List<Widget> _widgetOptions = <Widget>[
    // DashboardScreen(),
    ShowCaseWidget(
      onStart: (index, key) {
        log('onStart: $index, $key');
      },
      onComplete: (index, key) async {
        log('onComplete: $index, $key');
        print("showcaseIndex:$index");

        if (index == 7) {
          print("walk through app completed");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("showcaseStatus", true);
        }
      },
      enableAutoScroll: true,
      builder: Builder(builder: (context) => const TodayScreen()),
    ),
    //TodayScreen(),
    //const CoachesList(),
    GroceryList(
      dashboard: true,
    ),
    const RecipieScreen(),
    //WatchScreen(),

    NutritionScreenView(),
    //const DiaryView(),
    const DailyLog(),
  ];

  //2
  final List<Widget> _widgetOptions1 = <Widget>[
    const TodayScreen(),
    const DietTabView(),
    const RunningTabView(),
    const MindTabView(),
  ];

  //3
  void _onItemTappedForBottomNavigationBar(int index) {
    setState(() {
      _selectedIndexForBottomBar = index;
      _selectedIndexForTabBar = 0;
    });
  }

  //4
  void _onItemTappedForTabBar(int index) {
    print("tapped tab bar");
    if (_selectedIndexForTabBar != 1) {
      setState(() {
        _selectedIndexForTabBar = index + 1;
        _selectedIndexForBottomBar = 0;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    provider = Provider.of<UserDataProvider>(context, listen: false);
    super.initState();
    setState(() {
      currentScreen = _widgetOptions[widget.checkIndex];
      _selectedIndexForBottomBar = widget.checkIndex;
      BottomBarNew.currentTabIndex = widget.checkIndex;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("Index $_selectedIndexForBottomBar   $_selectedIndexForTabBar");
    //5
    final tabBar = TabBar(
      controller: _tabController,
      labelPadding: const EdgeInsets.only(left: 4),
      indicatorColor: _selectedIndexForTabBar == 0
          ? Colors.transparent
          : _selectedIndexForTabBar == 1
              ? Colors.blue
              : Colors.blue,
      labelColor:
          _selectedIndexForTabBar == 0 ? Colors.black : const Color(0xff4885ED),
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: Colors.black87,
      onTap: _onItemTappedForTabBar,
      tabs: const <Widget>[
        Tab(
          text: "Today",
        ),
        Tab(
          text: "Diet",
        ),
        Tab(
          text: "Excercise",
        ),
        Tab(
          text: "Mind",
        ),
      ],
    );

    Size _size = MediaQuery.of(context).size;
    //6
        return WillPopScope(
        child: mobiletab(tabBar, context),
        onWillPop: () async {
          return false;
        });//return mobiletab(tabBar, context);
  }

  DefaultTabController mobiletab(TabBar tabBar, BuildContext context) {
    
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: const CustomDrawer(),
          floatingActionButton: _selectedIndexForBottomBar == 3
              ? Container()
              : _getFloatingActionButton(),
          appBar: AppBar(
            elevation: 0.3,
            bottom: tabBar,
            backgroundColor: Colors.white,
            title: const Text('Tabs Demo'),
            iconTheme: const IconThemeData(color: Colors.grey),
            leading: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    child: Image.asset(
                      ImagePath.menu,
                      color: const Color(0xff797A7A),
                    ),
                  ),
                );
              },
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  print("Notification Key:" + context.widget.key.toString());
                  //if (context.widget.key != NotificationScreen().key)
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FavouriteTabInnerPage();
                  }));
                },
                child: const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )),
              ),
            ],
          ),

          //7
          // body:  _selectedIndexForTabBar == 0
          //             ? _widgetOptions.elementAt(_selectedIndexForBottomBar)
          //             : TabBarView(
          //               children: [
          //                 TodayScreen(),
          //                 DietTabView(),
          //                 RunningTabView(),
          //                 MindTabView(),
          //                 //_widgetOptions1.elementAt(_selectedIndexForTabBar - 1),
          //               ],
          //             ),
          body: Center(
            child: _selectedIndexForTabBar == 0
                ? IndexedStack(
                    index: _selectedIndexForBottomBar,
                    children: _widgetOptions,
                  )
                : TabBarView(
                    controller: _tabController,
                    children: [
                      ShowCaseWidget(
                        onStart: (index, key) {
                          log('onStart: $index, $key');
                        },
                        onComplete: (index, key) async {
                          log('onComplete: $index, $key');
                          print("showcaseIndex:$index");

                          if (index == 7) {
                            print("walk through app completed");
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool("showcaseStatus", true);
                          }
                        },
                        enableAutoScroll: true,
                        builder: Builder(builder: (context) => const TodayScreen()),
                      ),
                      ShowCaseWidget(
                        onStart: (index, key) {
                          log('onStart: $index, $key');
                        },
                        onComplete: (index, key) async {
                          log('onComplete: $index, $key');
                          print("showcaseIndex:$index");

                          if (index == 1) {
                            print("walk through deit completed");
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool("dietshowcaseStatus", true);
                          }
                        },
                        enableAutoScroll: true,
                        builder:
                            Builder(builder: (context) => const DietTabView()),
                      ),
                      //                DietTabView(),
                      ShowCaseWidget(
                        onStart: (index, key) {
                          log('onStart: $index, $key');
                        },
                        onComplete: (index, key) async {
                          log('onComplete: $index, $key');
                          print("showcaseIndex:$index");

                          if (index == 2) {
                            print("walk through exercise completed");
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool("exeshowcaseStatus", true);
                          }
                        },
                        enableAutoScroll: true,
                        builder: Builder(
                            builder: (context) => const RunningTabView()),
                      ),
                      //RunningTabView(),
                      ShowCaseWidget(
                        onStart: (index, key) {
                          log('onStart: $index, $key');
                        },
                        onComplete: (index, key) async {
                          log('onComplete: $index, $key');
                          print("showcaseIndex:$index");

                          if (index == 1) {
                            print("walk through mind completed");
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool("mindshowcaseStatus", true);
                          }
                        },
                        enableAutoScroll: true,
                        builder:
                            Builder(builder: (context) => const PlansScreen()),
                      )

                      //PlansScreen(),
                      //_widgetOptions1.elementAt(_selectedIndexForTabBar - 1),
                    ],
                  ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: _selectedIndexForTabBar != 0
                ? Colors.grey[500]
                : const Color(0xff4885ED),
            unselectedItemColor: Colors.grey[500],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap:
                _onItemTappedForBottomNavigationBar, // this will be set when a new tab is tapped
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(
                  ImagePath.home,
                )),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.local_grocery_store_rounded,
                  size: 30,
                ),
                label: 'Coach',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.food_bank_rounded,
                  size: 30,
                ),
                label: 'Live Track',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.chartBar),
                label: 'Nutrition',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(
                  ImagePath.dairy,
                )),
                label: 'Dairy',
              ),
            ],
            currentIndex: _selectedIndexForBottomBar,
          ),
        ));
  }

  ///Floating Action buttton
  Widget _getFloatingActionButton() {
    return SpeedDialMenuButton(
      isEnableAnimation: true,

      //if needed to close the menu after clicking sub-FAB
      isShowSpeedDial: _isShowDial,
      //manually open or close menu
      updateSpeedDialStatus: (isShow) {
        //return any open or close change within the widget
        _isShowDial = isShow;
      },
      //general init
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
          isExtended: true,
          heroTag: "floating_button_menu",
          backgroundColor: primaryColor,
          mini: false,
          autofocus: true,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            _isVisible = !_isVisible;
            // setState(() {
            //   _isVisible = !_isVisible;
            // });
          },
          closeMenuChild: const Icon(Icons.close),
          closeMenuForegroundColor: Colors.white,
          closeMenuBackgroundColor: primaryColor),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(
          heroTag: "water",
          mini: true,
          child: const Tooltip(
            message: "Water",
            child: Icon(
              Icons.water,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            //if need to close menu after click

            setState(() {
              _isVisible = false;
              _isShowDial = false;
              print(_isVisible);
            });
            dialogForWater();
          },
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "selfie",
          mini: true,
          child: const Tooltip(
            message: "Selfie",
            child: Icon(
              FontAwesomeIcons.camera,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            //if need to toggle menu after click
            setState(() {
              _isShowDial = false;
              _isVisible = false;
            });

            Get.to(() => UltimateSelfieView());
            //setState(() {});
          },
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "food",
          mini: true,
          child: const Tooltip(
            message: "Food",
            child: Icon(
              Icons.food_bank,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            //_isVisible = false;
            //_isShowDial = false;
            print(_isVisible);
            setState(() {
              _isVisible = false;
              _isShowDial = false;
              print(_isVisible);
            });
            dialogForFood();
          },
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "weight",
          mini: true,
          child: const Tooltip(
            message: "Weight",
            child: Icon(
              Icons.monitor_weight,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            setState(() {
              _isVisible = false;
              _isShowDial = false;
            });

            //_isVisible = false;
            //_isShowDial = false;
            dialogForWeight();
          },
          backgroundColor: Colors.white,
        ),
      ],
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }

  // ############################## DIALOG FOR WATER IN FAB(Floating Action Button) ###########################

  dialogForWater() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, stateSet) {
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            // contentPadding: EdgeInsets.all(0),
            actions: <Widget>[AddWaterWidget()],
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

  // ############################## DIALOG FOR FOOD IN FAB(Floating Action Button) ###########################

  dialogForFood() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    provider.setTypeId(1);
                    //Responsive1.isMobile(context)?
                    Get.to(() => SearchFood(false));
                    // :showDialog(
                    // context: context,
                    // builder: (BuildContext context) => Padding(
                    //     padding: const EdgeInsets.only(left: 200,right: 200,bottom: 50,top: 50),
                    //     child:SearchFood(false)));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SearchFood(false)));
                  },
                  child: Container(
                    // padding: EdgeInsets.only(top: 20),
                    height: MySize.size100,
                    width: MySize.size100,
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImagePath.breakfast),
                          const SizedBox(
                            height: 10,
                          ),
                          DDText(
                            title: "Breakfast",
                            size: 12,
                          )
                        ],
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    provider.setTypeId(2);
                    Responsive1.isMobile(context)
                        ? Get.to(() => SearchFood(false))
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 200, right: 200, bottom: 50, top: 50),
                                child: SearchFood(false)));
                    // Get.to(() => SearchFood(false));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SearchFood(false)));
                  },
                  child: Container(
                    // padding: EdgeInsets.only(top: 20),
                    height: MySize.size100,
                    width: MySize.size100,
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImagePath.lunch),
                          const SizedBox(
                            height: 10,
                          ),
                          DDText(
                            title: "Lunch",
                            size: 12,
                          )
                        ],
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    provider.setTypeId(3);
                    Responsive1.isMobile(context)
                        ? Get.to(() => SearchFood(false))
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 200, right: 200, bottom: 50, top: 50),
                                child: SearchFood(false)));
                    //Get.to(() => SearchFood(false));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SearchFood(false)));
                  },
                  child: Container(
                    // padding: EdgeInsets.only(top: 20),
                    height: MySize.size100,
                    width: MySize.size100,
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImagePath.dinner),
                          const SizedBox(
                            height: 10,
                          ),
                          DDText(
                            title: "Dinner",
                            size: 12,
                          )
                        ],
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    provider.setTypeId(4);
                    Responsive1.isMobile(context)
                        ? Get.to(() => SearchFood(false))
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 200, right: 200, bottom: 50, top: 50),
                                child: SearchFood(false)));
                  },
                  child: Container(
                    // padding: EdgeInsets.only(top: 20),
                    height: MySize.size100,
                    width: MySize.size100,
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImagePath.snack),
                          const SizedBox(
                            height: 10,
                          ),
                          DDText(
                            title: "Snacks",
                            size: 12,
                          )
                        ],
                      ),
                    ),
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

  // ############################## DIALOG FOR WEIGHT IN FAB(Floating Action Button) ###########################

  dialogForWeight() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, stateSet) {
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            // contentPadding: EdgeInsets.all(0),
            actions: <Widget>[AddWeightWidget()],
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }
}
