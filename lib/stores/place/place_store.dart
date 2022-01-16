import 'package:app/constants/secrets.dart';
import 'package:app/repositories/place/place_repository.dart';
import 'package:app/stores/error/error_store.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:mobx/mobx.dart';

part 'place_store.g.dart';

class PlaceStore = _PlaceStore with _$PlaceStore;

abstract class _PlaceStore with Store {
  final ErrorStore errorStore = ErrorStore();
  final googleGeocoding = GoogleGeocoding(Secrets.API_KEY);

  late PlaceRepository _repository;

  _PlaceStore(PlaceRepository repository) {
    _repository = repository;
  }

  @observable
  bool loading = false;

  @observable
  bool success = false;

  @observable
  String input = '';

  @observable
  String lang = '';

  @observable
  List<GeocodingResult>? geocodingResultsStart;

  @observable
  List<GeocodingResult>? geocodingResultsEnd;

  @observable
  GeocodingResult? geocodingResultStart;

  @observable
  GeocodingResult? geocodingResultEnd;


  @action
  Future getSuggestionStart() async {
    if (geocodingResultStart != null &&
        geocodingResultStart!.formattedAddress == input) return;
    loading = true;
    var result = await googleGeocoding.geocoding.get(input, []);
    geocodingResultsStart = result!.results!;
  }

  @action
  Future getSuggestionEnd() async {
    if (geocodingResultEnd != null &&
        geocodingResultEnd!.formattedAddress == input) return;
    loading = true;
    var result = await googleGeocoding.geocoding.get(input, []);
    geocodingResultsEnd = result!.results!;
  }

  @action
  Future resetStart() async {
    geocodingResultsStart = [];
  }

  @action
  Future resetEnd() async {
    geocodingResultsEnd = [];
  }
}
