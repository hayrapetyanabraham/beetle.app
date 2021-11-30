import 'package:app/data/apis/user_api.dart';
import 'package:app/data/auth/auth_api.dart';
import 'package:app/data/network/dio_client.dart';
import 'package:app/data/shared/shared_preference_helper.dart';
import 'package:app/di/module/network_module.dart';
import 'package:app/repositories/auth/auth_repository.dart';
import 'package:app/repositories/language/language_repository.dart';
import 'package:app/repositories/theme/theme_repository.dart';
import 'package:app/repositories/user/user_repository.dart';
import 'package:app/stores/auth/auth_store.dart';
import 'package:app/stores/error/error_store.dart';
import 'package:app/stores/language/language_store.dart';
import 'package:app/stores/theme/theme_store.dart';
import 'package:app/stores/user/user_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  //getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  // getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  // getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreferences());
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));

  getIt.registerSingleton<Dio>(
      NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  //getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(UserApi(getIt<DioClient>()));
  getIt.registerSingleton(AuthApi(getIt<DioClient>()));

  // data sources
  //getIt.registerSingleton(PostDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(UserRepository(
    getIt<UserApi>(),
    getIt<SharedPreferenceHelper>(),
    //getIt<PostDataSource>(),*/
  ));

  getIt.registerSingleton(ThemeRepository(
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(LanguageRepository(
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(AuthRepository(
    getIt<AuthApi>(),
    getIt<SharedPreferenceHelper>(),
    //getIt<PostDataSource>(),*/
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<LanguageRepository>()));
  getIt.registerSingleton(UserStore(getIt<UserRepository>()));
  getIt.registerSingleton(ThemeStore(getIt<ThemeRepository>()));
  getIt.registerSingleton(AuthStore(getIt<AuthRepository>()));

  ///getIt.registerSingleton(UserStore(getIt<Repository>()));
}
