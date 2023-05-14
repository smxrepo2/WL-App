import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  var data;
  var notiData;
  var waterdata = {
    "Water": [
      {
        "id": "0",
        "topic": "Water",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var restaurantdata = {
    "Restaurant": [
      {
        "id": "0",
        "topic": "Restaurant",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };

  var weightdata = {
    "Weight": [
      {
        "id": "0",
        "topic": "Weight",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var sleepdata = {
    "Sleep": [
      {
        "id": "0",
        "topic": "Sleep",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var minddata = {
    "Mind": [
      {
        "id": "0",
        "topic": "Mind",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var selfiedata = {
    "Selfie": [
      {
        "id": "0",
        "topic": "Selfie",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var exercisedata = {
    "Exercise": [
      {
        "id": "0",
        "topic": "Exercise",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var breakfastdata = {
    "Breakfast": [
      {
        "id": "0",
        "topic": "Breakfast",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var morningsnacksdata = {
    "MorningSnacks": [
      {
        "id": "0",
        "topic": "MorningSnacks",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var earlysnacksdata = {
    "EarlySnacks": [
      {
        "id": "0",
        "topic": "EarlySnacks",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var lunchdata = {
    "Lunch": [
      {
        "id": "0",
        "topic": "Lunch",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var afternoondata = {
    "AfterNoon": [
      {
        "id": "0",
        "topic": "AfterNoon",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var dinnerdata = {
    "Dinner": [
      {
        "id": "0",
        "topic": "Dinner",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  var snacksdata = {
    "snacks": [
      {
        "id": "0",
        "topic": "snacks",
        "starthours": "00",
        "startmin": "00",
        "endhour": "00",
        "endmin": "00",
        "count": "00",
        "subscribed": "false"
      }
    ]
  };
  Future setallNotiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.clear();
    notiData = prefs.getString("water_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("water_reminder", json.encode(waterdata));
    }
    bool showcaseStatus = prefs.getBool("showcaseStatus");
    if (showcaseStatus == null) {
      prefs.setBool("showcaseStatus", true);
    }
    /*********************************************Diet SHow case Settings********************************/
    bool dietshowcaseStatus = prefs.getBool("dietshowcaseStatus");
    if (dietshowcaseStatus == null) {
      prefs.setBool("dietshowcaseStatus", true);
    }
    bool innerdietshowcaseStatus = prefs.getBool("innerdietshowcaseStatus");
    if (innerdietshowcaseStatus == null) {
      prefs.setBool("innerdietshowcaseStatus", true);
    }
    bool singledietshowcaseStatus = prefs.getBool("singledietshowcaseStatus");
    if (singledietshowcaseStatus == null) {
      prefs.setBool("singledietshowcaseStatus", true);
    }
    bool customdietshowcaseStatus = prefs.getBool("customdietshowcaseStatus");
    if (customdietshowcaseStatus == null) {
      prefs.setBool("customdietshowcaseStatus", true);
    }
    /********************************************* Exercise Show case Settings ***************************** */

    bool exeshowcaseStatus = prefs.getBool("exeshowcaseStatus");
    if (exeshowcaseStatus == null) {
      prefs.setBool("exeshowcaseStatus", true);
    }
    bool innerexeshowcaseStatus = prefs.getBool("innerexeshowcaseStatus");
    if (innerexeshowcaseStatus == null) {
      prefs.setBool("innerexeshowcaseStatus", true);
    }
    bool singleexeshowcaseStatus = prefs.getBool("singleexeshowcaseStatus");
    if (singleexeshowcaseStatus == null) {
      prefs.setBool("singleexeshowcaseStatus", true);
    }
    bool customexeshowcaseStatus = prefs.getBool("customexeshowcaseStatus");
    if (customexeshowcaseStatus == null) {
      prefs.setBool("customexeshowcaseStatus", true);
    }

    /*********************************************** Mind Show case Settings ***************************** */

    bool mindshowcaseStatus = prefs.getBool("mindshowcaseStatus");
    if (mindshowcaseStatus == null) {
      prefs.setBool("mindshowcaseStatus", true);
    }
    bool innermindshowcaseStatus = prefs.getBool("innermindshowcaseStatus");
    if (innermindshowcaseStatus == null) {
      prefs.setBool("innermindshowcaseStatus", true);
    }
    bool singlemindshowcaseStatus = prefs.getBool("singlemindshowcaseStatus");
    if (singlemindshowcaseStatus == null) {
      prefs.setBool("singlemindshowcaseStatus", true);
    }
    bool custommindshowcaseStatus = prefs.getBool("custommindshowcaseStatus");
    if (custommindshowcaseStatus == null) {
      prefs.setBool("custommindshowcaseStatus", true);
    }

    notiData = prefs.getString("sleep_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("sleep_reminder", json.encode(sleepdata));
    }
    notiData = prefs.getString("selfie_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("selfie_reminder", json.encode(selfiedata));
    }
    notiData = prefs.getString("weight_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("weight_reminder", json.encode(weightdata));
    }
    notiData = prefs.getString("restaurant_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("restaurant_reminder", json.encode(restaurantdata));
      print(prefs.getString("restaurant_reminder"));
    }
    notiData = prefs.getString("mind_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("mind_reminder", json.encode(minddata));
    }
    notiData = prefs.getString("exercise_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("exercise_reminder", json.encode(exercisedata));
    }
    notiData = prefs.getString("earlysnacks_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("earlysnacks_reminder", json.encode(earlysnacksdata));
    }
    notiData = prefs.getString("breakfast_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("breakfast_reminder", json.encode(breakfastdata));
    }
    notiData = prefs.getString("morningsnacks_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("morningsnacks_reminder", json.encode(morningsnacksdata));
    }
    notiData = prefs.getString("lunch_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("lunch_reminder", json.encode(lunchdata));
    }
    notiData = prefs.getString("afternoon_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("afternoon_reminder", json.encode(afternoondata));
    }
    notiData = prefs.getString("dinner_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("dinner_reminder", json.encode(dinnerdata));
    }
    notiData = prefs.getString("snacks_reminder") ?? "";
    if (notiData == "") {
      prefs.setString("snacks_reminder", json.encode(snacksdata));
    }
  }
}
