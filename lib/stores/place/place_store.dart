import 'package:app/error/dio_error_util.dart';
import 'package:app/repositories/place/place_repository.dart';
import 'package:app/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'place_store.g.dart';

class PlaceStore = _PlaceStore with _$PlaceStore;

abstract class _PlaceStore with Store {
  final ErrorStore errorStore = ErrorStore();

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

  @action
  Future getSuggestion() async {
    loading = true;
    final future = _repository.getSuggestion(input: input, lang: lang);
    // fetchAuthorizationFuture = ObservableFuture(future);
    future.then((authorization) {
      //  this.authorization = authorization;
      loading = false;
      success = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      loading = false;
      success = false;
    });
  }
}
