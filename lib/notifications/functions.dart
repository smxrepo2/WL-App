import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getDeviceToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('fcmToken').toString();
}

showflushbar(context) {
  return Flushbar(
    title: 'Success',
    message: 'Reminder is Set',
    duration: Duration(seconds: 3),
    backgroundColor: Colors.green,
  )..show(context);
}
