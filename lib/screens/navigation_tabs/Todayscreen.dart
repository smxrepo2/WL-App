import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:countup/countup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_popup/internet_popup.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:uuid/uuid.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/Controller/HomePageData.dart';
import 'package:weight_loser/Controller/video.dart';
import 'package:weight_loser/Controller/video_player.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/DashboardProvider.dart';
import 'package:weight_loser/Service/DashBord%20Api.dart';
import 'package:weight_loser/Service/Diet_api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/Today_api.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:weight_loser/models/dairy_model.dart';
import 'package:weight_loser/models/to_do_task_model.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/GroceryList.dart';

import 'package:weight_loser/screens/articles_screens/ArticleDetails.dart';
import 'package:weight_loser/screens/cbt/body.dart';
import 'package:weight_loser/screens/diet_plan_screens/tabs/FavouriteInnerTab.dart';
import 'package:weight_loser/screens/food_screens/SearchFood.dart';

import 'package:weight_loser/screens/navigation_tabs/replace_food.dart';
import 'package:weight_loser/screens/splash_screen.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/Shimmer/GoalShimmer.dart';
import 'package:weight_loser/widget/Shimmer/ProfileShimmer.dart';
import 'package:weight_loser/widget/Shimmer/WorkOutShimmer.dart';
import 'package:weight_loser/widget/SizeConfig.dart';
import 'package:weight_loser/widget/Shimmer/today_shimmer_widget.dart';
import 'package:weight_loser/widget/show_case_widget.dart';

import '../../Provider/UserDataProvider.dart';
import '../../widget/no_internet_dialog.dart';
import '../../widget/no_internet_widget.dart';
import '../story/profilePage.dart';
import 'New_meditation.dart';

import 'homepage/middle.dart';
import 'profilepicmethods/methods.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key key}) : super(key: key);

  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen>
    with AutomaticKeepAliveClientMixin<TodayScreen> {
  @override
  bool get wantKeepAlive => true;

  int userid;
  bool networkConnection = true;
  var subscription;
  Future<DashboardModel> _dashboardFuture;
  Future<DashboardModel> _offlinedashboardFuture;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  UserDataProvider _userDataProvider;
  final Connectivity _connectivity = Connectivity();
  final ImagePicker _picker = ImagePicker();

  GlobalKey<FormState> _profilePic = GlobalKey<FormState>();
  GlobalKey<FormState> _Story = GlobalKey<FormState>();
  GlobalKey<FormState> _GroceryList = GlobalKey<FormState>();
  GlobalKey<FormState> _Calories = GlobalKey<FormState>();
  GlobalKey<FormState> _Replace = GlobalKey<FormState>();
  GlobalKey<FormState> _cheatFood = GlobalKey<FormState>();
  GlobalKey<FormState> _todaysWorkout = GlobalKey<FormState>();
  GlobalKey<FormState> _cbt = GlobalKey<FormState>();
  GlobalKey<FormState> _mindfullness = GlobalKey<FormState>();
  GlobalKey<FormState> _todo = GlobalKey<FormState>();

  Future saveFcmTokenToServer(int uid, String deviceId, String fcmToken) async {
    print("User: $uid - device: $deviceId - token:$fcmToken");
    final response = await post(
      Uri.parse('$apiUrl/api/userdevices'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "UserId": uid,
        "Device": deviceId,
        "DeviceId": fcmToken
      }),
    );
    print("fcmToken Response:${response.statusCode}");
    if (response.statusCode == 200) {
      print("fcmToken:${response.body}");
    } else {
      throw Exception('Failed to Update.');
    }
  }

  _saveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');

    // For contacts
    if (prefs.getString('device_id') == null) {
      prefs.setString('device_id', const Uuid().v1());
    }

    //if (prefs.getString('fcmToken') == null) {
    FirebaseMessaging.instance.getToken().then((token) {
      prefs.setString('fcmToken', token);
      saveFcmTokenToServer(userid, prefs.getString('device_id'), token);
    });
    //}
    //print(token);
  }

  List<XFile> _imageFileList;
  var selectedImage;

  set _imageFile(XFile value) {
    _imageFileList = value == null ? null : [value];
  }

  // ignore: unused_field
  dynamic _pickImageError;

  Future getImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _imageFile = pickedFile;
      });
      return _imageFileList;
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Future image_cropper() async {
    CroppedFile croppedFile = await ImageCropper().cropImage(
      sourcePath: selectedImage[0].path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Edit Picture',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return croppedFile;
  }

  uploadProfilePic(value) {
    final ProgressDialog pr = ProgressDialog(context);
    pr.show();
    upload(value).then((value) {
      print("pic uploaded");
      if (value.statusCode == 200) {
        pr.hide();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BottomBarNew(0),
          ),
        );
      } else {
        pr.hide();
        print("res error ${value.statusCode} ${value.statusMessage}");
        Navigator.pop(context);
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(value.statusMessage),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }).onError((error, stackTrace) {
      print("error ${error.toString()}");
      Navigator.pop(context);
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(error.toString()),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future requestRemotePermissions() async {
    print("requesting remote notification permissions");
    NotificationSettings getSettings =
        await messaging.getNotificationSettings();
    if (getSettings.authorizationStatus == AuthorizationStatus.authorized) {
      print("already authorized");
    } else if (getSettings.authorizationStatus == AuthorizationStatus.denied) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        messaging.subscribeToTopic("remoteNotifications");
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        messaging.unsubscribeFromTopic("remoteNotifications");
      }
    }
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status');
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      if (_connectionStatus == ConnectivityResult.mobile ||
          _connectionStatus == ConnectivityResult.wifi) {
        _userDataProvider =
            Provider.of<UserDataProvider>(context, listen: false);
        _userDataProvider.setnetworkConnection(true);
        networkConnection = true;
      } else {
        _userDataProvider =
            Provider.of<UserDataProvider>(context, listen: false);
        _userDataProvider.setnetworkConnection(false);
        networkConnection = false;
      }
    });
  }

  bool showcaseStatus = false;

  Future<bool> checkshowcaseStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("showcaseStatus");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkshowcaseStatus().then((value) {
      if (!value) {
        print("showcase:$value");
        setState(() {
          showcaseStatus = true;
        });
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
            _profilePic,
            _Story,
            //_GroceryList,
            _Calories,
            _Replace,
            _cheatFood,
            //_todaysWorkout,
            _cbt,
            _mindfullness,
            _todo
          ]),
        );
      } else {
        setState(() {
          showcaseStatus = false;
        });
      }
    });

    initConnectivity();
    _dashboardFuture = fetchDashboardData();
    if (Platform.isIOS) requestRemotePermissions();
    //InternetPopup().initialize(context: context);
    subscription = new Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        setState(() {
          networkConnection = true;
          _userDataProvider =
              Provider.of<UserDataProvider>(context, listen: false);
          _userDataProvider.setnetworkConnection(true);
          print("internet connectivity:$networkConnection");
        });
      } else {
        setState(() {
          networkConnection = false;
          _userDataProvider =
              Provider.of<UserDataProvider>(context, listen: false);
          _userDataProvider.setnetworkConnection(false);
          print("internet connectivity:$networkConnection");
        });
      }
    });
    _saveDeviceToken();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var orientation = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;
    super.build(context);
    return Container(
      child: Column(
        children: [
          !networkConnection ? NoInternetDialogue() : Text(''),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: Responsive1.isMobile(context),
                    child: FutureBuilder<DashboardModel>(
                      future: networkConnection
                          ? fetchDashboardData()
                          : fetchOfflineDashboardData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          final provider = Provider.of<DashboardProvider>(
                              context,
                              listen: false);
                          provider.setDashboardModel(snapshot.data);
                          return orientation == Orientation.portrait
                              ? profileSection(snapshot.data.profileVM)
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: width * .1, right: width * .1),
                                  child:
                                      profileSection(snapshot.data.profileVM),
                                );
                        }
                        /*
                        else if (snapshot.hasError) {
                          return Text('');
                        }
                        */

                        // By default, show a loading spinner.
                        return const Profileshimmer();
                      },
                    ),
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  SizedBox(height: MySize.size16),
                  /*
                  FutureBuilder<Dairy>(
                    future: fetchDairy(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Responsive1(
                            mobile: orientation == Orientation.portrait
                                ? goalFoodExerciseCaloriesView(snapshot.data,
                                    MySize.size4, MySize.size26, context)
                                : goalFoodExerciseCaloriesView(snapshot.data,
                                    width * .2, width * .2, context),
                            desktop: goalFoodExerciseCaloriesView(
                                snapshot.data, 150.0, 150.0, context));
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('No Internet Connectivity'),
                        );
                      }
    
                      // By default, show a loading spinner.
                      return const GoalShimmer();
                    },
                  ),
                  */
                  FutureBuilder<DashboardModel>(
                    future: networkConnection
                        ? fetchDashboardData()
                        : fetchOfflineDashboardData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Responsive1(
                            mobile: orientation == Orientation.portrait
                                ? goalFoodExerciseCaloriesView(
                                    snapshot.data,
                                    MySize.size4,
                                    MySize.size26,
                                    context,
                                    _Calories)
                                : goalFoodExerciseCaloriesView(snapshot.data,
                                    width * .2, width * .2, context, _Calories),
                            desktop: goalFoodExerciseCaloriesView(snapshot.data,
                                150.0, 150.0, context, _Calories));
                      }
                      /*
                      else if (snapshot.hasError) {
                        return const Center(
                          child: Text(''),
                        );
                      }
*/
                      // By default, show a loading spinner.
                      return const GoalShimmer();
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 4,
                  ),
                  FutureBuilder<DashboardModel>(
                    future: networkConnection
                        ? fetchDashboardData()
                        : fetchOfflineDashboardData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        final provider = Provider.of<DashboardProvider>(context,
                            listen: false);
                        provider.setDashboardModel(snapshot.data);
                        return Column(
                          children: [
                            Responsive1(
                              mobile: orientation == Orientation.portrait
                                  ? ShowCaseView(
                                      globalKey: _Replace,
                                      title: "Food Actions",
                                      shapeBorder: RoundedRectangleBorder(),
                                      description:
                                          "1: Replace Food from your other favorite cuisines\n2: Add food which you eat outside of our provided food items\n3: View favorite cusines menu and find nearest restaurants on map ",
                                      child: Middle(
                                          networkConnection: networkConnection,
                                          replace: _Replace),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          left: width * .1, right: width * .1),
                                      child: Middle(
                                          networkConnection: networkConnection,
                                          replace: _Replace),
                                    ),
                              desktop: Padding(
                                padding: const EdgeInsets.only(
                                    left: 120, right: 120),
                                child: Middle(
                                    networkConnection: networkConnection,
                                    replace: _Replace),
                              ),
                            ),

                            // HomeMiddle(),
                            //HomePageMiddle(),

                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 4,
                            ),
/*
                            Responsive1(
                                mobile: orientation == Orientation.portrait
                                    ? cheatFoodText(
                                        MySize.size18, MySize.size18)
                                    : cheatFoodText(
                                        MySize.size18, MySize.size18),
                                desktop: cheatFoodText(300.0, 300.0)),

                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 3,
                            ),
  */
                            Responsive1(
                                mobile: orientation == Orientation.portrait
                                    ? CheatFood(MySize.size18, MySize.size18)
                                    : CheatFood(MySize.size18, MySize.size18),
                                desktop: CheatFood(300.0, 300.0)),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 2,
                            ),
                            Responsive1(
                                mobile: orientation == Orientation.portrait
                                    ? cheatFoodBar(MySize.size18, MySize.size18)
                                    : cheatFoodBar(
                                        MySize.size18, MySize.size18),
                                desktop: cheatFoodBar(300.0, 300.0)),

                            Responsive1(
                                mobile: orientation == Orientation.portrait
                                    ? quotationSection(
                                        MySize.size36, MySize.size32)
                                    : quotationSection(width * .2, width * .2),
                                desktop: quotationSection(300.0, 300.0)),

                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 3,
                            ),

                            Responsive1(
                                mobile: orientation == Orientation.portrait
                                    ? workoutSection1()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: width * .2,
                                            right: width * .2),
                                        child: workoutSection1(),
                                      ),
                                desktop: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 200, right: 200),
                                  child: workoutSection1(),
                                )),

                            // workoutSection(snapshot.data.activeExercisePlans),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 2,
                            ),
                            // psychologicalSectionView(),
                            // SizedBox(
                            //   height: SizeConfig.safeBlockVertical * 2,
                            // ),
                            Responsive1(
                                mobile: orientation == Orientation.portrait
                                    ? psychologicalSection(
                                        snapshot.data.meditation,
                                        snapshot.data.mindPlans)
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: width * .2,
                                            right: width * .2),
                                        child: psychologicalSection(
                                            snapshot.data.meditation,
                                            snapshot.data.mindPlans),
                                      ),
                                desktop: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 200, right: 200),
                                  child: psychologicalSection(
                                      snapshot.data.meditation,
                                      snapshot.data.mindPlans),
                                )),

                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 2,
                            ),
                            Responsive1(
                                mobile: orientation == Orientation.portrait
                                    ? ShowCaseView(
                                        globalKey: _todo,
                                        title: "Todo List",
                                        shapeBorder: RoundedRectangleBorder(),
                                        description:
                                            "Check tasks you have done so far for today",
                                        child: blogSection())
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: width * .1,
                                            right: width * .1),
                                        child: blogSection()),
                                desktop: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 200, right: 200),
                                    child: blogSection())),
                          ],
                        );
                      }

                      /*                        
                      else if (snapshot.hasError &&
                          snapshot.connectionState == ConnectionState.done) {
                        log(snapshot.hasError.toString());
                        return NoInternetDialogue();
                      
                      }
                      */

                      // By default, show a loading spinner.
                      return const TodayShimmerWidget();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//####################### Cheat Food ###########################
  Widget cheatFoodText(left, right) {
    return Container(
      padding: EdgeInsets.only(left: left, right: right),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Cheat Food',
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 11,
            color: Colors.black,
          ),
          softWrap: false,
        ),
      ),
    );
  }

  Widget cheatFoodBar(left, right) {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    double streakLevel =
        double.parse(provider.dashboardModel.profileVM.streakLevel);
    streakLevel = streakLevel / 7;
    streakLevel > 0.9 ? streakLevel = 0.9999 : streakLevel;
    return Container(
      padding: EdgeInsets.only(left: left, right: right),
      width: double.infinity,
      height: 7,
      //color: Colors.grey[300],
      child: LinearPercentIndicator(
        //width: double.infinity,
        lineHeight: 5.0,
        percent: streakLevel,
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.grey[300],
        progressColor: Colors.orange,
      ),
    );
  }

  Widget CheatFood(left, right) {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    int streakLevel = int.parse(provider.dashboardModel.profileVM.streakLevel);
    print("StreakLevel:$streakLevel");
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ShowCaseView(
          globalKey: _cheatFood,
          title: "Redeem Food",
          shapeBorder: RoundedRectangleBorder(),
          description:
              "Add food of your choice, redeem button would be active after 7 days",
          child: Text(
            'Cheat Food',
            style: labelStyle(13, semiBold, Colors.black),
          ),
        ),
        streakLevel < 7
            ? Text("Redeemed ", style: labelStyle(11, light, Colors.grey))
            : GestureDetector(
                onTap: () {
                  Get.to(() => SearchFood(false));
                },
                child: Text("Redeem ",
                    style: labelStyle(11, light, Colors.black))),
      ]),
    );
  }

  // ############################ PROFILE SECTION #################################

  Widget profileSection(ProfileVM profile) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(
          left: MySize.size16, top: MySize.size20, right: MySize.size20),
      child: Row(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  getImageFromGallery().then((value) async {
                    print(value);
                    if (value != null) {
                      setState(() {
                        selectedImage = value;
                      });
                      //Navigator.pop(this.context);

                      await image_cropper().then((value) {
                        print("cropped image ${value}");

                        if (value != null) {
                          uploadProfilePic(value);
                        }
                      });
                    }
                  });
                },
                child: ShowCaseView(
                  globalKey: _profilePic,
                  title: "Profile Picture",
                  description: "Upload your profile picture",
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage('$imageBaseUrl${profile.fileName}'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("tapped profile name");
                  Get.to(() => ProfilePage());
                },
                child: Padding(
                  padding: EdgeInsets.only(left: MySize.size6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowCaseView(
                        title: "Story and Profile View",
                        description: "View story and share with your friends",
                        shapeBorder: RoundedRectangleBorder(),
                        globalKey: _Story,
                        child: DDText(
                          title: profile.name,
                          size: MySize.size13,
                        ),
                      ),
                      DDText(
                        title: "",
                        size: MySize.size11,
                        color: greyColor,
                        weight: FontWeight.w300,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(child: Container()),
          /*
          GestureDetector(
            onTap: () {
              //Get.to(() => GroceryList());
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => GroceryList()));
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: MySize.size14),
              child: Row(
                children: [
                  ShowCaseView(
                    globalKey: _GroceryList,
                    title: "Grocery List",
                    description: "View grocery list by day, week and month",
                    shapeBorder: BeveledRectangleBorder(),
                    child: DDText(
                      title: "Grocery List",
                      size: MySize.size13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          */
        ],
      ),
    );
  }

  bool isloading = false;

  Widget workoutSection1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: MySize.size18),
          child: DDText(
            title: "Today's Workout",
            size: MySize.size12,
          ),
        ),
        FutureBuilder(
            future: networkConnection
                ? fetchTodayExercise()
                : fetchOfflineTodayExercise(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return Container(
                    height: snapshot.data.length == 0 ? 0 : 155,
                    margin: const EdgeInsets.all(10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 2.1,
                          height: MediaQuery.of(context).size.height * 2,
                          child: GestureDetector(
                            onTap: () {
                              Responsive1.isMobile(context)
                                  ? Get.to(() => VideoWidget(
                                      url:
                                          '$videosBaseUrl${snapshot.data[index]['VideoFile']}',
                                      play: true,
                                      videoId: snapshot.data[index]['vidId']))
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) => Padding(
                                          padding: const EdgeInsets.only(
                                              left: 300,
                                              right: 300,
                                              bottom: 100,
                                              top: 100),
                                          child: VideoWidget(
                                              url:
                                                  '$videosBaseUrl${snapshot.data[index]['VideoFile']}',
                                              play: true,
                                              videoId: snapshot.data[index]
                                                  ['vidId'])));
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return VideoWidget(
                              //       url: '$videosBaseUrl${values[index].videoFile}',
                              //       play: true);
                              // }));
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
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            topLeft: Radius.circular(5)),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '$imageBaseUrl${snapshot.data[index]['BurnerImage']}'),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 10, 0, 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                                snapshot.data[index]['Name'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize:
                                                        Responsive1.isMobile(
                                                                context)
                                                            ? 12
                                                            : 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black)),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Text(
                                                    "${snapshot.data[index]['BurnerDuration']} minutes",
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        snapshot.data[index]
                                                                ['Calories']
                                                            .toStringAsFixed(1),
                                                        style: const TextStyle(
                                                            color: black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(width: 2),
                                                      const Text(
                                                        "cal",
                                                        style: const TextStyle(
                                                            color: greyColor,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

/*

                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        '$imageBaseUrl${snapshot.data[index]['BurnerImage']}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 10, 0, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data[index]['Name'],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: black)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            /*
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    "10 values",
                                                    style: TextStyle(
                                                        color: greyColor,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  SizedBox(
                                                    width: MySize.size4,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0),
                                                    child: const Text(
                                                      "*",
                                                      style: const TextStyle(
                                                          color: greyColor,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  const Text(
                                                    "5 sets",
                                                    style: const TextStyle(
                                                        color: greyColor,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: Container()), */
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5.0,
                                                  right: MySize.size10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    snapshot.data[index]
                                                            ['TotalCalories']
                                                        .toStringAsFixed(1),
                                                    style: const TextStyle(
                                                        color: black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  const Text(
                                                    "cal",
                                                    style: const TextStyle(
                                                        color: greyColor,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

*/
                          ),
                        );
                      },
                    ));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const WorkOutShimmer();
              } else if (snapshot.hasError) {
                return const Center(
                  child: const Text(''),
                );
              }
              return Container(
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Center(child: Text("Today No any workout")),
                ),
              );
              // return WorkOutShimmer();
            })
      ],
    );
  }

// ############################ PSYCHOLOGICAL SECTION #################################

  Widget psychologicalSection(Meditation meditation, MindPlans plans) {
    var mobile = Responsive1.isMobile(context);
    print(meditation);
    List psychologicalData = [
      {
        "title": "Cognitive Check in",
        "subtitle": "Healthy mind healthy you",
        "icon": ImagePath.theraphy,
        // "route": VideoWidget(url: '${meditation.videoFile}', play: true)
        "route": CBTScreen()
        //meditation == null
        //? NewMeditation()
        //: VideoWidget(
        //  url: '$videosBaseUrl${meditation.videoFile}', play: true)
      },
      {
        "title": "Mindfullness",
        "subtitle": "7 values",
        "icon": ImagePath.meditation,
        "route": NewMeditation(),
        // "route": MeditationViewMind(plans['PlanImage'],"", plans['MindPlanId'], 4,)
      },
    ];

    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: mobile ? MySize.size300 : MySize.size350,
            childAspectRatio: mobile ? 3 / 2 : 3 / 1.5,
            crossAxisSpacing: mobile ? MySize.size7 : MySize.size50,
            mainAxisSpacing: MySize.size100),
        itemCount: psychologicalData.length,
        itemBuilder: (BuildContext ctx, index) {
          GlobalKey _temp;
          String tTiile;
          String tDesc;
          if (index == 0) {
            _temp = _cbt;
            tTiile = "Cognitive check in";
            tDesc = "Cbt is provided which has to be submitted with details";
          } else {
            _temp = _mindfullness;
            tTiile = "Mindfullnes";
            tDesc = "View video for mind therapy";
          }

          return GestureDetector(
            onTap: () {
              Responsive1.isMobile(context)
                  ? Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                      return psychologicalData[index]["route"];
                    }))
                  : Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, top: 50, bottom: 50),
                        child: psychologicalData[index]["route"],
                      );
                    }));
              // } else {
              //   getMind();
              //   Navigator.push(context, MaterialPageRoute(builder: (context) {
              //     return psychologicalData[index]["route"];
              //   }));
            },
            child: ShowCaseView(
              globalKey: _temp,
              title: tTiile,
              description: tDesc,
              shapeBorder: RoundedRectangleBorder(),
              child: Container(
                margin: index == 0
                    ? EdgeInsets.only(
                        left: MySize.size14,
                        // right: MySize.size5,
                      )
                    : EdgeInsets.only(right: MySize.size14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xffDFDFDF),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: MySize.size10,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        psychologicalData[index]["icon"],
                        // width: index == 4 ? 300 : 200,
                        // height: index == 4 ? 300 : 200,
                      ),
                      index % 2 == 0
                          ? SizedBox(
                              height: MySize.size15,
                            )
                          : SizedBox(
                              height: MySize.size15,
                            ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          // padding: EdgeInsets.only(left: 10),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DDText(
                                // title: plan.title,
                                title: psychologicalData[index]["title"],
                                center: true,
                                size: Responsive1.isMobile(context)
                                    ? MySize.size11
                                    : MySize.size15,
                                weight: FontWeight.w600,
                              ),
                              index == 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3.0),
                                          child: DDText(
                                            title: psychologicalData[index]
                                                ["subtitle"],
                                            center: true,
                                            size: Responsive1.isMobile(context)
                                                ? MySize.size11
                                                : MySize.size15,
                                            weight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DDText(
                                          title: '',
                                          // title:psychologicalData[index]["title"],
                                          center: true,
                                          size: MySize.size11,
                                          weight: FontWeight.w300,
                                        ),
                                        SizedBox(
                                          width: MySize.size4,
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: const Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                        const Text(
                                          // "${plan.duration} min",
                                          "10 min",
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // ############################ BLOG SECTION #################################

  Widget blogSection() {
    return FutureBuilder<UserTodoTaskModel>(
      future: networkConnection
          ? getTodoTasks(context)
          : getOfflineTodoTasks(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final provider = Provider.of<UserDataProvider>(context, listen: true);

          return Padding(
            padding: EdgeInsets.only(
                left: MySize.size6,
                bottom: MySize.size30,
                right: MySize.size14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                snapshot.data.tasks.length > 0
                    ? Padding(
                        padding: EdgeInsets.only(left: MySize.size18),
                        child: DDText(
                          title: "Today's to do",
                          size: MySize.size12,
                        ),
                      )
                    : Text(""),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.tasks.length,
                  itemBuilder: (context, i) {
                    bool selected =
                        provider.userTodoTaskModel.tasks[i].completed;
                    print("isSelected:$selected");
                    return Card(
                      margin: EdgeInsets.only(
                        left: MySize.size10,
                        top: MySize.size5,
                        bottom: MySize.size5,
                      ),
                      elevation: 0,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[100],
                                      spreadRadius: 1,
                                      blurRadius: 0.2)
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (networkConnection) {
                                    provider.setTodoTask(i);
                                    saveTask(
                                            snapshot.data.tasks[i].id,
                                            provider.userTodoTaskModel.tasks[i]
                                                .completed)
                                        .then((value) {
                                      if (value.statusCode == 200) {}
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(noInternetsnackBar);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: MySize.size8),
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        color: selected
                                            ? Colors.green
                                            : Colors.grey,
                                        size: 14,
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.only(
                                        top: MySize.size20,
                                        // bottom: MySize.size8,
                                        //left: MySize.size8,
                                        //right: MySize.size28
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: MySize.size20),
                                            child: DDText(
                                              line: 3,
                                              title:
                                                  snapshot.data.tasks[i].name,
                                              weight: FontWeight.w500,
                                              center: null,
                                              size: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                    Container(
                                      height: MySize.size100,
                                      width: Responsive1.isMobile(context)
                                          ? MediaQuery.of(context).size.width /
                                              6
                                          : MediaQuery.of(context).size.width *
                                              0.1,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                '$imageBaseUrl${snapshot.data.tasks[i].fileName}',
                                              ),
                                              scale: 4,
                                              fit: BoxFit.cover)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
        return Text('');
      },
    );
  }
}
