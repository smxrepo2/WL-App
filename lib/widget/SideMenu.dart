import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final menu = SizedBox(
        width: 230,
        child: const SafeArea(
            //right: false,
            ));
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Row(
        children: [
          Expanded(
              child: Navigator(
            key: navigatorKey,
            initialRoute: '/',
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      body: Responsive1.isMobile(context)
                          ? BottomBarNew(0)
                          : BottomBarNew(0),
                    );
                  },
                  settings: settings);
            },
          ))
        ],
      ),
    );
  }
}



class HeadingWeb extends StatefulWidget {
  const HeadingWeb({Key key}) : super(key: key);

  @override
  State<HeadingWeb> createState() => _HeadingWebState();
}

class _HeadingWebState extends State<HeadingWeb> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Responsive1.isDesktop(context),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, right: 15, left: 15),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              FutureBuilder<DashboardModel>(
                future: fetchDashboardData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: snapshot.data.profileVM.imageUrl != null
                                ? NetworkImage(snapshot.data.profileVM.imageUrl)
                                : Image.asset('assets/images/ice_cream.png'),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            snapshot.data.profileVM.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('No Internet Connectivity'),
                    );
                  }

                  // By default, show a loading spinner.
                  return const Text("");
                },
              ),

              // Padding(
              //   padding: const EdgeInsets.only(right: 15),
              //   //child:_getFloatingActionButton()
              //   child: FloatingActionButton(backgroundColor:primaryColor,onPressed: (){print("Flat Button");
              //   _getFloatingActionButton();
              //   },child: Icon(Icons.add,color: Colors.white,),),
              // )
            ],
          ),
        ),
      ),
    );
  }

  bool _isShowDial = false;
  bool _isVisible = false;

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
        print("Flat");
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
            //dialogForWater();
          },
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "exercise",
          mini: true,
          child: const Tooltip(
            message: "Exercise",
            child: Icon(
              FontAwesomeIcons.running,
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            //if need to toggle menu after click
            _isShowDial = !_isShowDial;
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
            _isVisible = false;
            _isShowDial = false;
            print(_isVisible);
            // setState(() {
            //   _isVisible = false;
            //   _isShowDial = false;
            //   print(_isVisible);
            // });
            //dialogForFood();
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
            // setState(() {
            //   _isVisible = false;
            //   _isShowDial = false;
            // });
            _isVisible = false;
            _isShowDial = false;
            //dialogForWeight();
          },
          backgroundColor: Colors.white,
        ),
      ],
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }
}
