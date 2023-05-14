

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

showSimpleNotification() async {
  var androidDetails = AndroidNotificationDetails(''
      'id', 'channel ',channelDescription: 'description',
      priority: Priority.high, importance: Importance.max);
  var iOSDetails = IOSNotificationDetails();
  var platformDetails = new NotificationDetails(android: androidDetails,iOS: iOSDetails);
  await flutterLocalNotificationsPlugin.show(0, 'Message',
      'Welcome To Weight Loser', platformDetails,
      payload: 'Destination Screen (Simple Notification)');
}


showLoggedNotification(String msg) async {
  var androidDetails = AndroidNotificationDetails(''
      'id', 'channel ',channelDescription: 'description',
      priority: Priority.high, importance: Importance.max);
  var iOSDetails = IOSNotificationDetails();
  var platformDetails = new NotificationDetails(android: androidDetails,iOS: iOSDetails);
  await flutterLocalNotificationsPlugin.show(1, 'Message',
     msg, platformDetails,
      payload: 'Destination Screen (Simple Notification)');
}
// , 'description'