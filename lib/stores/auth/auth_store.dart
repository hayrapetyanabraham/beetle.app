import 'package:app/error/dio_error_util.dart';
import 'package:app/models/auth/authorization.dart';
import 'package:app/repositories/auth/auth_repository.dart';
import 'package:app/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  late AuthRepository _repository;

  final ErrorStore errorStore = ErrorStore();

  _AuthStore(AuthRepository repository) : _repository = repository;

  static ObservableFuture<Authorization?> authorizationResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Authorization?> fetchAuthorizationFuture =
      ObservableFuture<Authorization?>(authorizationResponse);

  @observable
  Authorization? authorization;

  @observable
  bool success = false;

  @observable
  String email='';

  @computed
  bool get loading => fetchAuthorizationFuture.status == FutureStatus.pending;

  @action
  Future postGetAuth() async {
    final future = _repository.postGetAuth();
    fetchAuthorizationFuture = ObservableFuture(future);

    future.then((authorization) {
      this.authorization = authorization;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
