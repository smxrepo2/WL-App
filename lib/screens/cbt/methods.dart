import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/AppConfig.dart';
import '../../models/get_cbt_questions.dart';

Future<CbtQuestions> getCbtQuestions() async {
  final response = await get(
    Uri.parse('$apiUrl/api/cbt/GetQuestion'),
  );

  if (response.statusCode == 200) {
    return CbtQuestions.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load dairy');
  }
}

Future submitCbtAnswer(int questionId, String answer, String notes) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int userid = preferences.getInt('userid');

  final response = await post(
    Uri.parse('$apiUrl/api/cbt'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "UserId": userid,
      "QuestionId": questionId,
      "Answer": answer,
      "Notes": notes
    }),
  );
  if (response.statusCode == 200) {
    return true;
    // return SignUpBody.fromJson(jsonDecode(response.body)['restaurants']);
  } else {
    return false;
    //throw Exception('Failed to Update.');
  }
}
