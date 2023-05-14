import 'dart:convert';

import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as h;
import '../Component/DDToast.dart';
import '../Component/DDText.dart';
import '../utils/AppConfig.dart';
import '../utils/ColorConfig.dart';

import '../utils/Locator.dart';
import '../utils/NavigationService.dart';

class BaseService {
  String baseURL = "https://weightchoper.somee.com/";
  String token;
  GetStorage storage = GetStorage();

  // ignore: unused_field
  static NavigationService _navigationService = locator<NavigationService>();

  static Alice alice = Alice(
      showNotification: false,
      //navigatorKey: Modular.navigatorKey,
      darkTheme: true);

  Future baseGetAPI(url,
      {successMsg,
      loading,
      status,
      utfDecoded,
      bool return404 = false,
      bool errorToast = true,
      bool direct = false}) async {
    if (loading == true && loading != null) {}

    // String bearerAuth = 'Basic ' + token;

    http.Response response;
    try {
      response = await http.get(
        Uri.parse(baseURL + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'authorization': bearerAuth
        },
      );
      _logRequestOnAlice(response);
      if (direct == true) {
        return response.body;
      }

      if (status != null) {
        return response.statusCode;
      }

      var jsonData;
      if (response.statusCode == 200) {
        if (utfDecoded == true) {
          jsonData = json.decode(utf8.decode(response.bodyBytes));

          return jsonData;
        }
        jsonData = json.decode(response.body);
        if (successMsg != null) {
          DDToast().showToast("", successMsg, false);
        }
        return jsonData;
      } else if (response.statusCode == 401) {
        jsonData = json.decode(response.body);

        return {};
      } else {
        jsonData = json.decode(response.body);
      }
    } catch (SocketException) {
      //DDToast().showToast("No Internet Connection",true);
      AlertDialog(
        content: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 20,
                ),
                SizedBox(height: 10),
                DDText(
                  title:
                      "There seems to be your network problem or a server side issue. Please try again or report the bug to the manager.",
                  color: ColorConfig().primaryColor,
                  size: 13,
                ),
                SizedBox(height: 20),
              ],
            )),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                // color: terColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: new DDText(
                    title: "Okay",
                    size: 13,
                    color: Colors.red,
                  ),
                ),
                // color: secondaryColor,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ],
      );
      return null;
    }
  }

  Future basePostAPI(url, body, context, {successMsg, loading}) async {
    if (loading == true && loading != null) {}

    String bearerAuth = 'Basic ' + token;

    http.Response response;

    try {
      response = await http.post(Uri.parse(baseURL + url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': bearerAuth
          },
          body: jsonEncode(body));

      _logRequestOnAlice(response);

      var jsonData;
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        if (successMsg != null) {
          DDToast().showToast("Message", successMsg, false);
        }
        return jsonData;
      } else if (response.statusCode == 401) {
        jsonData = json.decode(response.body);

        return {};
      } else {
        throw Exception('Failed');
      }
    } catch (SocketException) {
      return null;
    }
  }

  Future baseFormPostAPI(url, Map<String, String> body, files, context,
      {successMsg, loading, pop = true}) async {
    if (loading == true && loading != null) {}

    String bearerAuth = 'Basic ' + token;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseURL + url));

      request.headers.addAll({"authorization": "$bearerAuth"});

      for (int i = 0; i < files.length && files != null; i++) {
        request.files
            .add(await http.MultipartFile.fromPath('file', files[i].path));
      }
      request.fields.addAll(body);

      var response = await request.send();

      if (response.statusCode == 200) {
        if (successMsg != null) {
          DDToast().showToast("Message", successMsg, false);
        }
        if (pop == true) {
          // Modular.to.pop();
        }
      } else if (response.statusCode == 401) {
      } else {
        response.stream.bytesToString().then((value) {
          //DDToast().showToast(value, true);
          print(value);
        });
        throw Exception('Failed');
      }
    } catch (SocketException) {
      return null;
    }
  }

  static void _logRequestOnAlice(h.Response response) {
    if (isDevelopmentMode == true) {
      alice.onHttpResponse(response);
    }
  }
}
