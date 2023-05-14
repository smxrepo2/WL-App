import 'dart:convert';

import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/screens/Questions_screen/models/all_questions_model.dart';
import 'package:weight_loser/screens/Questions_screen/providers/all_questions_provider.dart';

import '../../../notifications/getit.dart';

Future<GetAllQuestionsModel> GetAllQueestions() async {
  final response = await get(Uri.parse('$apiUrl/api/Questionair'));

  if (response.statusCode == 200) {
    print("response:" + response.statusCode.toString());
    GetAllQuestionsModel _data =
        GetAllQuestionsModel.fromJson(jsonDecode(response.body));

    //print("Length of foodItems:" + _data.foodList.length.toString());
    return _data;
  } else {
    throw Exception('Failed to load dairy');
  }
}
