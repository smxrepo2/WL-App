import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:weight_loser/models/nearbylocation.dart';

// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  //final client = Client();
  int radius = 5000;

  PlaceApiProvider();

  static final String androidKey = 'AIzaSyBJcZFz3EsQgbcvRTK5dymSXl3O1jMlvwI';
  static final String iosKey = 'AIzaSyBJcZFz3EsQgbcvRTK5dymSXl3O1jMlvwI';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<NearByLocationModel> fetchSuggestions(
      String input, LatLng location) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${location.latitude}%2C${location.longitude}&types=cafe|restaurant&radius=$radius&key=$apiKey';
    final response = await get(Uri.parse(request));
    print(response.body);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return NearByLocationModel.fromJson(result);
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return null;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
