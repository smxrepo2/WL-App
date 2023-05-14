import 'dart:convert';

import 'package:http/http.dart';
import 'package:weight_loser/main.dart';
import 'package:weight_loser/screens/screentext/model/screenModel.dart';

import '../../../utils/AppConfig.dart';

Future<ScreenTextModel> GetScreenTextData() async {
  final response = await get(Uri.parse('$apiUrl/api/screentext/ByScreen'));
  if (response.statusCode == 200) {
    logger.d("BY Screen response:" + response.statusCode.toString());

    ScreenTextModel _data = ScreenTextModel.fromJson(jsonDecode(response.body));

    logger.d("Body :" + _data.toJson().toString());

    return _data;
  } else {
    throw Exception('Failed to load dairy');
  }
}
