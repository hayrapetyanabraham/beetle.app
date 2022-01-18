import 'package:app/data/place/place_api.dart';

class PlaceRepository {
  final PlaceApi _placeApi;

  PlaceRepository(this._placeApi);

  Future<List> getSuggestion({String input, String lang}) async {
    return await _placeApi
        .getSuggestion(input: input, lang: lang)
        .then((suggestions) {
      return suggestions;
    }).catchError((error) => throw error);
  }
}
