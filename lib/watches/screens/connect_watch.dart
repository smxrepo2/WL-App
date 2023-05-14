import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:fit_kit/fit_kit.dart';
// import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/strings.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom_bar.dart';
import 'package:weight_loser/screens/navigation_tabs/LiveTracking.dart';
import 'package:weight_loser/watches/constants/strings.dart';
import 'package:weight_loser/watches/models/connected_watch_model.dart';
import 'package:weight_loser/watches/models/withings.dart';
import 'package:weight_loser/watches/providers/connected_watch_provider.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

import '../../utils/AppConfig.dart';
import '../../notifications/getit.dart';
import '../../screens/Bottom_Navigation/bottom.dart';
import '../../screens/SettingScreen/components.dart';

class ConnectWatch extends StatefulWidget {
  const ConnectWatch({Key key}) : super(key: key);

  @override
  _ConnectWatchState createState() => _ConnectWatchState();
}

class _ConnectWatchState extends State<ConnectWatch> {
  ///fitbit
  int cal1, distance1, steps1;
  double calories = 0, dis = 0, step = 0;

  ///google fit
  List<Widget> _list = [];
  bool dayToday = false;
  //DataType type, type1, type2;
  double steps = 0, cal = 0, miles = 0;

  String fitbit = "connect";

  String connectedWatch;
  final isFitData = GetStorage();
  final internalStorage = GetStorage();
  Future<ConnectedWatchModel> _connectedWatchFuture;

/*
  Future<bool> checkPermissions() async {
    var status = await Permission.activityRecognition.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      var permission = await Permission.activityRecognition.request();
      if (permission.isGranted) {
        return true;
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
*/
  Future SetConnectedWatch(String connectedWatch) async {
    UIBlock.block(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
    var response = await post(
      Uri.parse('$apiUrl/api/userdevices'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          <String, dynamic>{"Device": connectedWatch, "UserID": userid}),
    );
    print("response:" + response.body);
    UIBlock.unblock(context);
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  Future<ConnectedWatchModel> GetConnectedWatch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
    final response = await get(
      Uri.parse('$apiUrl/api/userdevices/GetByUser/$userid'),
    );
    print("Watch response ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      ConnectedWatchModel _cwm =
          ConnectedWatchModel.fromJson(jsonDecode(response.body));
      var provider = getit<connectedwatchprovider>();
      provider.setConnectedWatch(_cwm);
      return _cwm;
    }
  }

  void Refresh() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomBarNew(2)),
        (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Future to optain connected Watch
    _connectedWatchFuture = GetConnectedWatch();

/*
    if (internalStorage.read('connectedWatch') != null) {
      //setState(() {
      connectedWatch = internalStorage.read('connectedWatch');

      print("connected Watch:$connectedWatch");
      //});
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<ConnectedWatchModel>(
        future: _connectedWatchFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
            default:
              if (snapshot.hasError)
                return Text("No Internet Connectivity");
              else if (snapshot.hasData) {
                connectedWatch = snapshot.data.userDevices.device;
                if (connectedWatch == "Withings") RefreshWithingToken();
                return Scaffold(
                  body: SafeArea(
                    child: Padding(
                      padding: Responsive1.isMobile(context)
                          ? const EdgeInsets.all(0)
                          : const EdgeInsets.only(left: 100, right: 100),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: Responsive1.isMobile(context)
                                ? MediaQuery.of(context).size.height * 0.02
                                : 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Connect To Your Smart Watch',
                              style: GoogleFonts.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          //if(Platform.isAndroid)
                          selectWatches(
                              context: context,
                              text: connectedWatch == "FitKit"
                                  ? "Disconnect"
                                  : "connect",
                              name: Platform.isAndroid
                                  ? 'Google Fit'
                                  : Platform.isIOS
                                      ? "Health"
                                      : "",
                              icon: Platform.isAndroid
                                  ? 'assets/icons/googlefit_icon.png'
                                  : Platform.isIOS
                                      ? 'assets/icons/applewatch_icon.png'
                                      : "",
                              onTap: () async {
                                if (connectedWatch == "FitKit") {
                                  SetConnectedWatch("none").then(
                                    (value) async {
                                      if (value) Refresh();
                                      await HealthFactory.revokePermissions();

                                      //setState(() {
                                      //_connectedWatchFuture =
                                      //  GetConnectedWatch();
                                      //});
                                    },
                                  );
                                } else {
                                  //checkPermissions().then((value) {
                                  //if (value) {
                                  readPermissions().then((value) {
                                    if (value)
                                      SetConnectedWatch("FitKit").then(
                                        (value) {
                                          if (value) Refresh();
                                          //setState(() {
                                          //_connectedWatchFuture =
                                          //  GetConnectedWatch();
                                          //});
                                        },
                                      );
                                    //});
                                    //}
                                  });
                                }
                              }),
                          /*
                          selectWatches(
                              context: context,
                              text: 'connect',
                              name: 'Samsung health',
                              icon: 'assets/icons/samsunghealth_icon.png'),
                          */
                          selectWatches(
                              context: context,
                              text: connectedWatch == "FitBit"
                                  ? "Disconnect"
                                  : "connect",
                              name: 'FitBit',
                              icon: 'assets/icons/bitfit_icon.png',
                              onTap: () async {
                                if (connectedWatch == "FitBit") {
                                  SetConnectedWatch("none").then(
                                    (value) {
                                      if (value) Refresh();
                                    },
                                  );
                                } else {
                         /*         FitbitLogin().then(
                                    (value) {
                                      if (value != null)
                                        SetConnectedWatch("FitBit").then(
                                          (value) {
                                            Refresh();
                                          },
                                        );
                                    },
                                  );*/
                                }
                              }),
                          selectWatches(
                              context: context,
                              text: connectedWatch == "Withings"
                                  ? "Disconnect"
                                  : "connect",
                              name: 'Withings',
                              icon: 'assets/icons/withings_icon.png',
                              onTap: () async {
                                if (connectedWatch == "Withings") {
                                  SetConnectedWatch("none").then(
                                    (value) {
                                      if (value) Refresh();
                                    },
                                  );
                                } else {
                                  WithingsLogin(context).then(
                                    (value) {
                                      if (value != null)
                                        SetConnectedWatch("Withings").then(
                                          (value) {
                                            Refresh();
                                          },
                                        );
                                    },
                                  );
                                }
                              }),
                          /*
                          selectWatches(
                              context: context,
                              text: 'connect',
                              name: 'Apple watch',
                              icon: 'assets/icons/applewatch_icon.png'),
                         */
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Did not find your device?',
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Text("No Data Available");
              }
          }
        },
      ),
    );
  }

  ///Google fit
  Future<bool> readPermissions() async {
    HealthFactory health = HealthFactory();

    bool requested =
        await health.requestAuthorization(types, permissions: permissions);

    print('requested: $requested');
    if (requested) return true;
  }
}

///Withings

Future RefreshWithingToken() async {
  final prefs = await SharedPreferences.getInstance();

  final accesToken = prefs.getString('accessTokenWithing');
  final refreshToken = prefs.getString('refreshTokenWithing');
  Dio dio = new Dio();
  FormData formdata = new FormData();

  formdata = FormData.fromMap({
    "action": "requesttoken",
    "client_id": Strings.withingClientID,
    "client_secret": Strings.withingClientSecret,
    "grant_type": "refresh_token",
    "refresh_token": refreshToken
  });
  //UIBlock.block(context);
  var response = await dio.post(
    '${Strings.withingBaseUrl}/v2/oauth2',
    onSendProgress: (int sent, int total) {},
    data: formdata,
    options: Options(
        method: 'POST', responseType: ResponseType.json // or ResponseType.JSON
        ),
  );
  if (response.statusCode == 200) {
    withingsAuth data = withingsAuth.fromJson(response.data);
    final accessToken = data.body.accessToken as String;
    final refreshToken = data.body.refreshToken as String;

    print("Withings access Token:" + accessToken);
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('accessTokenWithing', accessToken);
    await prefs.setString('refreshTokenWithing', refreshToken);
    //print("Refresh Token Response:" + response.data);
  }
}

Future<String> WithingsLogin(BuildContext context) async {
  String userID;
  try {
    var url =
        'https://account.withings.com/oauth2_user/authorize2?response_type=code&client_id=${Strings.withingClientID}&redirect_uri=${Strings.withingRedirectUri}&state=1&scope=user.sleepevents,user.metrics,user.activity';
    final result = await FlutterWebAuth.authenticate(
        url: url, callbackUrlScheme: Strings.withingCallbackScheme);
    final code = Uri.parse(result).queryParameters['code'];
    print("Withing Auth Result" + result);
    Dio dio = new Dio();
    FormData formdata = new FormData();

    formdata = FormData.fromMap({
      "action": "requesttoken",
      "client_id": Strings.withingClientID,
      "client_secret": Strings.withingClientSecret,
      "grant_type": "authorization_code",
      "code": code,
      "redirect_uri": Strings.withingRedirectUri
    });
    UIBlock.block(context);
    var response = await dio.post(
      '${Strings.withingBaseUrl}/v2/oauth2',
      onSendProgress: (int sent, int total) {},
      data: formdata,
      options: Options(
          method: 'POST',
          responseType: ResponseType.json // or ResponseType.JSON
          ),
    );
    if (response.statusCode == 200) {
      print(response.data);
      withingsAuth data = withingsAuth.fromJson(response.data);
      final accessToken = data.body.accessToken as String;
      final refreshToken = data.body.refreshToken as String;
      userID = data.body.userid as String;
      print("Withings Access Token:" + refreshToken);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userWithing', userID);
      await prefs.setString('accessTokenWithing', accessToken);
      await prefs.setString('refreshTokenWithing', refreshToken);
      UIBlock.unblock(context);
    } else
      UIBlock.unblock(context);
  } catch (ex) {
    print(ex);
  }
  return userID;
}

///fitbit
/*Future<String> FitbitLogin() async {
  Dio dio = Dio();
  var response;
  String userID;

  // Generate the fitbit url
  final fitbitAuthorizeFormUrl = FitbitAuthAPIURL.authorizeForm(
     // userID: userID,
      redirectUri: Strings.fitbitRedirectUri,
      clientID: Strings.fitbitClientID);

  // Perform authentication
  try {
    final result = await FlutterWebAuth.authenticate(
        url: fitbitAuthorizeFormUrl.url,
        callbackUrlScheme: Strings.fitbitCallbackScheme);
    //Get the auth code
    final code = Uri.parse(result).queryParameters['code'];

    // Generate the fitbit url
    final fitbitAuthorizeUrl = FitbitAuthAPIURL.authorize(
        //userID: userID,
        redirectUri: Strings.fitbitRedirectUri,
        code: code,
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret);

    response = await dio.post(
      fitbitAuthorizeUrl.url,
      data: fitbitAuthorizeUrl.data,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'Authorization': fitbitAuthorizeUrl.authorizationHeader,
        },
      ),
    );

    // Debugging
    final logger = Logger();
    logger.i('$response');

    // Save authorization tokens
    final accessToken = response.data['access_token'] as String;
    final refreshToken = response.data['refresh_token'] as String;
    print(accessToken);
    userID = response.data['user_id'] as String;

*//*
    await FitbitConnector.storage.write(key: 'fitbitAccessToken', value: accessToken);
    await FitbitConnector.storage.write(key: 'fitbitRefreshToken', value: refreshToken);
*//*

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userFitbit', userID);
    await prefs.setString('accessToken', accessToken);

    print(response.data);
  } catch (e) {
    print(e);
  } // catch

  return userID;
}*/
