import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
  }
  // Or do other work.
}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
          (message) async {
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification.title);
        bodyCtlr.sink.add(message.notification.body);
      },
    );
    // With this token you can test it easily on your phone
    final token =
    _firebaseMessaging.getToken().then((value) => print('Token: $value'));
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}
// String notificationTitle = 'No Title';
// String notificationBody = 'No Body';
// String notificationData = 'No Data';
//
// @override
// void initState() {
//   // TODO: implement initState
//   final firebaseMessaging = FCM();
//   firebaseMessaging.setNotifications();
//
//   firebaseMessaging.streamCtlr.stream.listen(_changeData);
//   firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
//   firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
//
//   super.initState();
// }
// _changeData(String msg) => setState(() => notificationData = msg);
// _changeBody(String msg) => setState(() => notificationBody = msg);
// _changeTitle(String msg) => setState(() => notificationTitle = msg);
//