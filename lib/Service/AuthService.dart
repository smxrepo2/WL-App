import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Model/UserDataModel.dart';
import 'package:weight_loser/utils/AppConfig.dart';

class AuthService {
  static UserLocal user;
  static setUserId(int userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userid', userid);
  }

  static deleteUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userid');
  }

  /// set question order
  static setQuestionOrder(int questionOrder) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('questionOrder', questionOrder);
  }

  /// get question order
  static Future<int> getQuestionOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('questionOrder');
  }

  /// set paid
  static setPaid(bool paid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('paid', paid);
  }

  /// get paid
  static Future<bool> getPaid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('paid');
  }

  /// check user id
  static Future<bool> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userid') != null;
  }

  /// Tokens preference get
  static Future<int> getTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userid');
  }
}

int userid;

Future<dynamic> forgetPassword(String email) async {
  var requestBody = {'email': email};
  final response = await post(
    Uri.parse('$apiUrl/api/login/otp'),
    body: requestBody,
  );
  if (response.statusCode == 200) {
    return json.encode(response.body);
  } else {
    throw Exception('unable to find your email');
  }
}

Future<String> verifyEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  var requestBody = {'email': email};
  final response = await post(
    Uri.parse('$apiUrl/api/login/EmailVerify'),
    body: requestBody,
  );
  if (response.statusCode == 200) {
    print(response.body);
    return json.encode(response.body);
  } else {
    throw Exception('unable to send otp');
  }
}
