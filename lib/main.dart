// @dart=2.9
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:weight_loser/constants/payments.dart';
import 'package:weight_loser/screens/Questions_screen/providers/all_questions_provider.dart';
import 'package:weight_loser/screens/auth/signup.dart';
import 'package:weight_loser/screens/exercise_screens/RunningTab.dart';
import 'package:weight_loser/screens/food_screens/DietTabView.dart';
import 'package:weight_loser/screens/mind_screens/MindTabView.dart';
import 'package:weight_loser/screens/navigation_tabs/Todayscreen.dart';

import 'AppRoutes/page_routes.dart';
import 'Controller/settingsController.dart';
import 'Provider/ChatProvider.dart';
import 'Provider/ConnectionService.dart';
import 'Provider/CustomExercisePlanProvider.dart';
import 'Provider/CustomMindPlanProvider.dart';
import 'Provider/CustomPlanProvider.dart';
import 'Provider/DashboardProvider.dart';
import 'Provider/UserDataProvider.dart';
import 'Provider/laravel_provider.dart';
import 'Service/Scroll_behavior.dart';
import 'Service/global_service.dart';
import 'Service/settingsService.dart';
import 'notifications/getit.dart';
import 'notifications/notificationservice.dart';
// 08/01, 10:46 am] .: 1-otp position in start
// 2-signing up via Google and Facebook
// 3-Next button removing
// 4-default value of Wight height and
// 5-forecast screen cleaning
// 6-payment and subscription plan properly implementation
// 7-Next button again and    again typing issue by one question submission
Logger logger = Logger();
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  AndroidNotification android = message.notification?.android;
  print(message.data);
  if (message.data.isNotEmpty) {
    flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            icon: android?.smallIcon),
        iOS: const IOSNotificationDetails(presentSound: true),
      ),
    );
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title

  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/*
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
*/
final stripeConfiguration = StripePaymentConfigurations();

void main() async {
  await initServices();
  //await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = stripeConfiguration.publishKey;
  await Firebase.initializeApp(

      // options: FirebaseOptions(
      //   apiKey: "AIzaSyB9AZVB5yZ7WfnCc1ufzhqHgrna_7lr3vs",
      //   appId: "1:702064832074:android:ae0fd8b47a216c3c3380b3",
      //   messagingSenderId: "XXX",
      //   projectId: "weightloser-2de95",
      // ),
      );
  HttpOverrides.global = MyHttpOverrides();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  NotificationService().initNotification();
  final SettingsController settingsController = SettingsController(
    SettingsService(),
  );
  await settingsController.loadSettings();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(InitProviders(settingsController));
  /*
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message clicked!');
  });
  FirebaseMessaging.onMessage.listen((message) {
    print(message);
  });
  */
}

Future<bool> initServices() async {
  Get.log('starting services ...');
  await GetStorage.init();
  await Get.putAsync(() => GlobalService().init());
  await Get.putAsync(() => LaravelApiClient().init());

  Get.log('All services started...');
  return true;
}

class InitProviders extends StatelessWidget {
  const InitProviders(
    this.settingsController, {
    Key key,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => settingsController,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //String token;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //FirebaseFirestore _db = FirebaseFirestore.instance;

  final ConnectivityResult _connectionStatus = ConnectivityResult.none;
  UserDataProvider _userDataProvider;

  requestPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

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
      FirebaseMessaging.instance.subscribeToTopic("remoteNotifications");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tz.initializeTimeZones();

    setup();
    //initConnectivity();

    //dailylogSetup();
    //setallNotiData();

    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        print("android forground");
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android?.smallIcon,
              ),
            ));
      } else {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
                iOS: IOSNotificationDetails(presentSound: true)));
      }
    });
    //getToken();
    //getTopics();
    if (Platform.isAndroid) {
      FirebaseMessaging.instance.subscribeToTopic("remoteNotifications");
    } else if (Platform.isIOS) {
      requestPermissions();
    }
    //_saveDeviceToken();
  }

  /*
  void firebaseCloudMessaging_Listeners() {
    //if (Platform.isIOS) iOS_Permission();

    //_firebaseMessaging.getToken().then((token) {
    //print(token);
    //});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
    });
    _saveDeviceToken();

    /// Get the token, save it to the database for current user
  }
  

  _saveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // For contacts
    if (prefs.getString('device_id') == null) {
      prefs.setString('device_id', Uuid().v1());
    }

    if (prefs.getString('fcmToken') == null) {
      _firebaseMessaging.getToken().then((token) {
        prefs.setString('fcmToken', token);
      });
    }
    //print(token);
  }

*/
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectionService()),
        ChangeNotifierProvider<ChatProvider>(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider<CustomPlanProvider>(
          create: (_) => CustomPlanProvider(),
        ),
        ChangeNotifierProvider<CustomMindPlanProvider>(
          create: (_) => CustomMindPlanProvider(),
        ),
        ChangeNotifierProvider<CustomExercisePlanProvider>(
          create: (_) => CustomExercisePlanProvider(),
        ),
        ChangeNotifierProvider<UserDataProvider>(
          create: (_) => UserDataProvider(),
        ),
        ChangeNotifierProvider<DashboardProvider>(
          create: (_) => DashboardProvider(),
        ),
        ChangeNotifierProvider<allquestionprovider>(
          create: (_) => allquestionprovider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Weight Chopper',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Open Sans",
        ),
        scrollBehavior: MyCustomScrollBehavior(),
       home:    const  SignUpScreen (),
       // home:  (),
        routes: {
          '/today': (_) => const TodayScreen(),
          AppRoutes.diet: (_) => const DietTabView(),
          AppRoutes.mind: (_) => const MindTabView(),
          AppRoutes.exercise: (_) => const RunningTabView(),
        },
        // home: ChooseMethod(),
      ),
    );
  }
/*
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print(token);
    _saveDeviceToken();
  }
  getTopics() async {
    await FirebaseFirestore.instance
        .collection('topics')
        .get()
        .then((value) => value.docs.forEach((element) {
              if (token == element.id) {
                subscribed = element.data().keys.toList();
              }
            }));

    setState(() {
      subscribed = subscribed;
    });
  }
  */
}
