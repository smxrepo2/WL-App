import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:rxdart/subjects.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    // Android initialization
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // ios initialization
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    // the initialization settings are initialized after they are setted
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('Notification payload: ' + payload);
      }
    });
  }

/*
  void configureDidReceiveLocalNotificationSubject(context) {
    print("configuringdidrecieve");
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {},
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }
*/
  tz.TZDateTime _nextInstanceOfdaily(
      int starthour, int startmin, int endhour, int endmin, int remindme) {
    final tz.TZDateTime today = tz.TZDateTime.now(tz.local);
    tz.TZDateTime newstarttime = tz.TZDateTime(
        tz.local, today.year, today.month, today.day, starthour, startmin);
    newstarttime = newstarttime.add(Duration(minutes: -remindme));
    print("Start time" + newstarttime.toString());
    if (newstarttime.isBefore(today)) {
      newstarttime = newstarttime.add(const Duration(days: 1));
    }
    return newstarttime;
  }

  tz.TZDateTime _nextInstanceOfweekly(
      int starthour, int startmin, int endhour, int endmin, int remindme) {
    final tz.TZDateTime today = tz.TZDateTime.now(tz.local);
    tz.TZDateTime newstarttime = tz.TZDateTime(
        tz.local, today.year, today.month, today.day, starthour, startmin);
    newstarttime = newstarttime.add(Duration(minutes: -remindme));
    print("Start time" + newstarttime.toString());
    if (newstarttime.isBefore(today)) {
      newstarttime = newstarttime.add(const Duration(days: 7));
    }
    return newstarttime;
  }

  tz.TZDateTime _nextInstanceOfweeklytwice(
      int starthour, int startmin, int endhour, int endmin, int remindme) {
    final tz.TZDateTime today = tz.TZDateTime.now(tz.local);
    tz.TZDateTime newstarttime = tz.TZDateTime(
        tz.local, today.year, today.month, today.day, starthour, startmin);
    newstarttime = newstarttime.add(Duration(minutes: -remindme));
    print("Start time" + newstarttime.toString());
    if (newstarttime.isBefore(today)) {
      newstarttime = newstarttime.add(const Duration(days: 3));
    }
    return newstarttime;
  }

  tz.TZDateTime _nextInstanceOfmonthly(
      int starthour, int startmin, int endhour, int endmin, int remindme) {
    final tz.TZDateTime today = tz.TZDateTime.now(tz.local);
    tz.TZDateTime newstarttime = tz.TZDateTime(
        tz.local, today.year, today.month, today.day, starthour, startmin);
    newstarttime = newstarttime.add(Duration(minutes: -remindme));
    print("Start time" + newstarttime.toString());
    if (newstarttime.isBefore(today)) {
      newstarttime = newstarttime.add(const Duration(days: 30));
    }
    return newstarttime;
  }

  Future<void> showNotification(
      int id,
      String title,
      String body,
      int starthour,
      int startmin,
      int endhour,
      int endmin,
      int count,
      int remindme) async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    print("timezone = $currentTimeZone");
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    //var currentloc = tz.getLocation(currentTimeZone);
    var today = tz.TZDateTime.now(tz.local);
    print("today date:" + today.toString());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfdaily(starthour, startmin, endhour, endmin,
            count), //schedule the notification to show after 2 seconds.
        const NotificationDetails(
          // Android details
          android: AndroidNotificationDetails('Water Notification', 'Water',
              channelDescription: "Water Subscription Notifications",
              importance: Importance.max,
              priority: Priority.max),
          // iOS details
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),

        // Type of time interpretation
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time
        // To show notification even when the app is closed
        );
  }

  Future<void> showweeklynotification(
      int id,
      String title,
      String body,
      int starthour,
      int startmin,
      int endhour,
      int endmin,
      int count,
      int remindme) async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    print("timezone = $currentTimeZone");
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    //var currentloc = tz.getLocation(currentTimeZone);
    var today = tz.TZDateTime.now(tz.local);
    print("today date:" + today.toString());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfweekly(starthour, startmin, endhour, endmin,
            count), //schedule the notification to show after 2 seconds.
        const NotificationDetails(
          // Android details
          android: AndroidNotificationDetails('Water Notification', 'Water',
              channelDescription: "Water Subscription Notifications",
              importance: Importance.max,
              priority: Priority.max),
          // iOS details
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),

        // Type of time interpretation
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time
        // To show notification even when the app is closed
        );
  }

  Future<void> showweeklynotificationtwice(
      int id,
      String title,
      String body,
      int starthour,
      int startmin,
      int endhour,
      int endmin,
      int count,
      int remindme) async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    print("timezone = $currentTimeZone");
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    //var currentloc = tz.getLocation(currentTimeZone);
    var today = tz.TZDateTime.now(tz.local);
    print("today date:" + today.toString());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfweeklytwice(starthour, startmin, endhour, endmin,
            count), //schedule the notification to show after 2 seconds.
        const NotificationDetails(
          // Android details
          android: AndroidNotificationDetails('Water Notification', 'Water',
              channelDescription: "Water Subscription Notifications",
              importance: Importance.max,
              priority: Priority.max),
          // iOS details
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),

        // Type of time interpretation
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time
        // To show notification even when the app is closed
        );
  }

  tz.TZDateTime _nextInstanceOfmonthly29(
      int starthour, int startmin, int endhour, int endmin, int remindme) {
    final tz.TZDateTime today = tz.TZDateTime.now(tz.local);
    tz.TZDateTime newstarttime = tz.TZDateTime(
        tz.local, today.year, today.month, 29, starthour, startmin);
    newstarttime = newstarttime.add(Duration(minutes: -remindme));
    print("Start time" + newstarttime.toString());
    if (newstarttime.isBefore(today)) {
      newstarttime = tz.TZDateTime(
          tz.local, today.year, today.month, 29, starthour, startmin);
      newstarttime = newstarttime.add(Duration(minutes: -remindme));
    }
    return newstarttime;
  }

  Future<void> showmonthlynotification(
      int id,
      String title,
      String body,
      int starthour,
      int startmin,
      int endhour,
      int endmin,
      int count,
      int remindme) async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    print("timezone = $currentTimeZone");
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    //var currentloc = tz.getLocation(currentTimeZone);
    var today = tz.TZDateTime.now(tz.local);
    print("today date:" + today.toString());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfmonthly(starthour, startmin, endhour, endmin,
            count), //schedule the notification to show after 2 seconds.
        const NotificationDetails(
          // Android details
          android: AndroidNotificationDetails('Water Notification', 'Water',
              channelDescription: "Water Subscription Notifications",
              importance: Importance.max,
              priority: Priority.max),
          // iOS details
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),

        // Type of time interpretation
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time
        // To show notification even when the app is closed
        );
  }

  Future<void> showmonthlynotification29(
      int id,
      String title,
      String body,
      int starthour,
      int startmin,
      int endhour,
      int endmin,
      int count,
      int remindme) async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    print("timezone = $currentTimeZone");
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    //var currentloc = tz.getLocation(currentTimeZone);
    var today = tz.TZDateTime.now(tz.local);
    print("today date:" + today.toString());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfmonthly29(starthour, startmin, endhour, endmin,
            count), //schedule the notification to show after 2 seconds.
        const NotificationDetails(
          // Android details
          android: AndroidNotificationDetails('Water Notification', 'Water',
              channelDescription: "Water Subscription Notifications",
              importance: Importance.max,
              priority: Priority.max),
          // iOS details
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),

        // Type of time interpretation
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time
        // To show notification even when the app is closed
        );
  }

  Future<void> deleteNotification(channelName) async {
    //const int notificationId = 0;
    //print("hello");
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel(channelName);
    //await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> deletesingleNotification(int notificationId) async {
    //const int notificationId = 0;
    //print("hello");

    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
