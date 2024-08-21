import 'package:app/error/dio_error_util.dart';
import 'package:app/models/user/user.dart';
import 'package:app/repositories/user/user_repository.dart';
import 'package:app/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  UserRepository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _UserStore(UserRepository repository) : _repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<User> emptyUserResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<User> fetchUserFuture =
      ObservableFuture<User>(emptyUserResponse);

  @observable
  User user;

  @observable
  bool success = false;

  bool get loading => fetchUserFuture.status == FutureStatus.pending;

  @action
  Future getUser() async {
    final future = _repository.getUser();
    fetchUserFuture = ObservableFuture(future);
    future.then((user) {
      this.user = user;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
