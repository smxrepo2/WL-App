//shared preference code here

import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/notifications/notificationmodel.dart';

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
getNotidata(keyvalue) async {
  //deleteNotidata("water_reminder");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var getData = prefs.getString(keyvalue);

  /*
  
  if (getData == "") {
    if (keyvalue == "water_reminder") {
      data = waterdata;
    } else if (keyvalue == "sleep_reminder")
      data = sleepdata;
    else if (keyvalue == "weight_reminder")
      data = weightdata;
    else if (keyvalue == "selfie_reminder") data = selfiedata;

    prefs.setString(keyvalue, json.encode(data));
    var getData = prefs.getString(keyvalue);
    print("water data" + data);
    return getData;
  }
  */
  return getData;
}

getNotidatasleep() async {
  //deleteNotidata("sleep_reminder");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var getData = prefs.getString("sleep_reminder") ?? "";
  if (getData == "") {
    /*
    if (keyvalue == "water_reminder") {
      data = waterdata;
     
    } else if (keyvalue == "sleep_reminder") {
      data = sleepdata;
      prefs.setString(keyvalue, json.encode(data));
      var getData = prefs.getString(keyvalue);
      print("water data" + data);
      return getData;
    }
    */
    prefs.setString("sleep_reminder", json.encode(sleepdata));
    var getData = prefs.getString("sleep_reminder");
    print("sleep data" + data);
    return getData;
  }

  return getData;
}

setNotidata(setdata, keyvalue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(keyvalue, json.encode(setdata));
}

/*

deleteNotidata(keyvalue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(keyvalue);
}
*/

Future setallNotiData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //await prefs.clear();
  notiData = prefs.getString("water_reminder") ?? "";
  if (notiData == "") {
    prefs.setString("water_reminder", json.encode(waterdata));
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
