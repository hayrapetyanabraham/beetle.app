import 'dart:io';

import 'package:app/data/network/dio_client.dart';
import 'package:app/models/place/place.dart';
import 'package:uuid/uuid.dart';

class PlaceApi {
  final DioClient _dioClient;

  static const String androidKey = '';
  static const String iosKey = 'YOUR_API_KEY_HERE';

  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  PlaceApi(this._dioClient);

  Future<List> getSuggestion({String input, String lang}) async {
    final sessionToken = const Uuid().v4();
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';
    final res = await _dioClient.get(request);
    return (res.data as List).map((x) => Suggestion.fromMap(x)).toList();
  }

/* Future<List<Suggestion>?> getSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';
    final res = await _dioClient.get(request);
    return (res.data as List).map((x) => Suggestion.fromJson(x)).toList();
  */ /*  final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }*/ /*
  }*/

}
