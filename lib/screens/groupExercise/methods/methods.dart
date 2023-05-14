import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loser/screens/groupExercise/models/exercise_group_model.dart';
import 'package:weight_loser/screens/groupExercise/models/user_exercise_model.dart';
import 'package:weight_loser/screens/groupExercise/providers/exercise_group_provider.dart';
import 'package:weight_loser/screens/groupExercise/providers/user_exercise_provider.dart';

import '../../../utils/AppConfig.dart';
import '../../../notifications/getit.dart';

int userid;

Future<ExerciseGroupsModel> GetGroupExerciseData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.get(Uri.parse('$apiUrl/api/exercisegroup'));

  if (response.statusCode == 200) {
    //print("response: ${response.statusCode}");
    ExerciseGroupsModel _data =
        ExerciseGroupsModel.fromJson(jsonDecode(response.body));
    print("response:" + response.statusCode.toString());
    print("Length of Groups:" + _data.exerciseGroups.length.toString());
    var _groupProvider = getit<exercisegroupprovider>();
    _groupProvider.setExerciseGroups(_data);

    return _data;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<ExerciseUserModel> GetUserExerciseData(int groupId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');

  final response = await http.get(Uri.parse(
      '$apiUrl/api/exercisegroup/GetByUser?groupId=$groupId&userId=$userid'));

  if (response.statusCode == 200) {
    //print("response: ${response.statusCode}");
    ExerciseUserModel _data =
        ExerciseUserModel.fromJson(jsonDecode(response.body));
    print("Get Exercise  response:" + response.statusCode.toString());
    //print("Length of Groups:" + _data.exerciseGroups.length.toString());
    var _userProvider = getit<exerciseuserprovider>();
    _userProvider.setExerciseUser(_data);

    return _data;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Response> JoinGroup(int groupId, int slotId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  Dio dio = new Dio();
  FormData formdata = new FormData();

  formdata = FormData.fromMap({
    "GroupId": groupId,
    "FollowerId": userid,
    "SlotId": slotId,
  });

  var response = await dio.post(
    '$apiUrl/api/exercisegroup/JoinGroup',
    onSendProgress: (int sent, int total) {
      print('$sent $total');
    },
    data: formdata,
    options: Options(
        method: 'POST', responseType: ResponseType.json // or ResponseType.JSON
        ),
  );
  print("response of Joining:" + response.toString());
  //if (response.statusCode == 200) {
  //return response;
  //}
  return response;
}

Future<Response> AddUserExercise(int groupId, int slotId, int burntCalories,
    int distance, int userTime) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('userid');
  Dio dio = new Dio();
  FormData formdata = new FormData();

  formdata = FormData.fromMap({
    "GroupId": groupId,
    "UserId": userid,
    "SlotId": slotId,
    "UserTime": userTime,
    "BurnCalories": burntCalories,
    "Distance": distance,
  });

  var response = await dio.post(
    '$apiUrl/api/exercisegroup/UserDetails',
    onSendProgress: (int sent, int total) {
      print('$sent $total');
    },
    data: formdata,
    options: Options(
        method: 'POST', responseType: ResponseType.json // or ResponseType.JSON
        ),
  );
  print("response of Adding Exercise:" + response.toString());
  //if (response.statusCode == 200) {
  return response;
  //}
}
