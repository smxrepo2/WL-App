import 'dart:convert';

import 'package:http/http.dart';
import 'package:weight_loser/utils/AppConfig.dart';

Future <dynamic> getFoodCategories()async{
  final response = await get(
    Uri.parse('$apiUrl/api/category/food'),
  );
  print("response ${response.statusCode} ${response.body}");

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Unable to Load');
  }
}