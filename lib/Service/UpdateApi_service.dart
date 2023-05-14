import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/AuthService.dart';
import 'package:weight_loser/models/DashboardModel.dart';
import 'package:http/http.dart' as http;
import 'package:weight_loser/utils/AppConfig.dart';

int userid;

///Update Age
Future<bool> updateAge(int age) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.patch(
    Uri.parse('$apiUrl/api/goals/age'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{"UserId": userid, "Age": age}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update name
Future<bool> updateName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/profile/Name'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"userId": userid, "Name": name}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///Update Email
Future<bool> updateEmail(String Email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/profile/Email'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "Email": Email}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///Update Password
Future<bool> updatePassword(String Password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _currentUser = _auth.currentUser;

  final response = await post(
    Uri.parse('$apiUrl/api/Login/ChangePassword'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"Id": userid, "Password": Password}),
  );
  if (response.statusCode == 200) {
    await _currentUser.updatePassword(Password);
    return true;
  } else {
    return false;
    //throw Exception('Failed to Update.');
  }
}

///Update Height
Future<bool> updateHeight(double height) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.patch(
    Uri.parse('$apiUrl/api/goals/height'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "Height": height}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

Future<bool> updateSleepGoal(int hours) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/DietQuestions/Sleep'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "SleepTime": hours}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update gender
Future<bool> updateGender(String gender) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.patch(
    Uri.parse('$apiUrl/api/goals/gender'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "Gender": gender}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///Update Current Weight
Future<bool> updateCurrentWeight(int currentWeight) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.patch(
    Uri.parse('$apiUrl/api/goals/weight'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"UserId": userid, "CurrentWeight": currentWeight}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update GoalWeight
Future<bool> updateGoalWeight(int goalWeight) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.patch(
    Uri.parse('$apiUrl/api/goals/GoalWeight'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"UserId": userid, "GoalWeight": goalWeight}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

/// Favourite cuisines
Future<bool> updateFavCusine(String food) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/dietquestions/Cusine'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "FavCuisine": food}),
  );
  if (response.statusCode == 200) {
    return true;
    //return SignUpBody.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to Update.');
  }
}

///non favourite cuisines
Future<bool> updateNonFavCusine(String food) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/dietquestions/NoCusine'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "NoCuisine": food}),
  );
  if (response.statusCode == 200) {
    return true;
    //return SignUpBody.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to Update.');
  }
}

///update non favourite food
Future<bool> updateNonFavourite(String food) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/dietquestions/Food'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "NoFood": food}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update allergic food
Future<bool> updateAllergicFood(String food) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/dietquestions/AllergicFood'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
        jsonEncode(<String, dynamic>{"UserId": userid, "RestrictedFood": food}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update Dob
Future<bool> updateDob(String date) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/profile/dob'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"userId": userid, "dOB": date}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

Future<bool> updateFavRest(int restId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/favouriterestaurant'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
        jsonEncode(<String, dynamic>{"UserId": userid, "RestuarantId": restId}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update Medical condition
Future<bool> updateMedical(String medical) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/dietquestions/medical'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"UserId": userid, "MedicalCondition": medical}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update Gym MemberShip
Future<bool> updateMembership(String membership) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/burner/MemberShip/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"UserId": userid, "MemberShip": membership}),
  );
  if (response.statusCode == 200) {
    return true;
    //return SignUpBody.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to Update.');
  }
}

///update ExerciseType
Future<bool> updateExerciseType(String type) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/burner/ExerciseType/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "ExerciseType": type}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update BodyType
Future<bool> updateBodyType(String type) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/burner/BodyType/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "BodyType": type}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update 7 min exercise
Future<bool> updateMinExercise(String ans) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/burner/MinExercise/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "MinExercise": ans}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update food craving
Future<bool> updateFoodCraving(String craveFood) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/CraveFood/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"UserId": userid, "CraveFoods": craveFood}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

/// update mind Control
Future<bool> updateMindControl(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/Control/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "Control": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///
/// update preoccupied mind
Future<bool> updatePreoccupied(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/PreOccupied/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
        jsonEncode(<String, dynamic>{"UserId": userid, "Preoccupied": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update free food mind
Future<bool> updateFreeFood(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/FreeFood/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "FreeFood": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update eating round mind
Future<bool> updateEatingRound(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/EatingRound/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
        jsonEncode(<String, dynamic>{"UserId": userid, "EatingRound": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update craving mind
Future<bool> updateCravingMind(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/Cravings/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "Cravings": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update stress mind
Future<bool> updateStress(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/Stress/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "Stress": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update sad mind
Future<bool> updateSad(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/Sad/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "SadEating": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update lonely mind
Future<bool> updateLonely(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/Lonely/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
        jsonEncode(<String, dynamic>{"UserId": userid, "LonelyEating": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update bored mind
Future<bool> updateBored(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/Bored/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
        jsonEncode(<String, dynamic>{"UserId": userid, "BoredEating": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update large mind
Future<bool> updateLarge(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/Large/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:
        jsonEncode(<String, dynamic>{"UserId": userid, "LargeEating": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update watching eating mind
Future<bool> updateWatching(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/Watching/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"UserId": userid, "WatchingEating": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update free time eating mind
Future<bool> updateNothing(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/FreeTime/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"UserId": userid, "FreeTimeEating": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update water habit mind
Future<bool> updateWater(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/WaterHabit/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "WaterHabit": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///update lat night munching
Future<bool> updateLateNight(String option) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/mind/LateNight/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"UserId": userid, "LateNightHabit": option}),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to Update.');
  }
}

///Update Distance Unit
Future<dynamic> updateDistanceUnit(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  print("$name");
  final response = await http.post(
    Uri.parse('$apiUrl/api/goals/DistanceUnit'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "DistanceUnit": name}),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to Update.');
  }
}

///Update Liquid Unit
Future<dynamic> updateLiquidUnit(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await http.post(
    Uri.parse('$apiUrl/api/goals/WaterUnit'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "WaterUnit": name}),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to Update.');
  }
}

///Update Height Unit
Future<dynamic> updateHeightUnit(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await http.post(Uri.parse('$apiUrl/api/goals/HeightUnit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String, dynamic>{"UserId": userid, "HeightUnit": name}));
  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to Update.');
  }
}

Future<void> updateLifeStyle(String type) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.post(
    Uri.parse('$apiUrl/api/burner/Routine/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "Routine": type}),
  );
  if (response.statusCode == 200) {
    print("success");
  } else {
    throw Exception('Failed to Update.');
  }
}

///Update Weight Unit
Future<dynamic> updateWeightUnit(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  final response = await http.post(
    Uri.parse('$apiUrl/api/goals/WeightUnit'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"UserId": userid, "WeightUnit": name}),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to Update.');
  }
}
