import 'package:app/constants/app_theme.dart';
import 'package:app/constants/strings.dart';
import 'package:app/di/components/service_locator.dart';
import 'package:app/repositories/auth/auth_repository.dart';
import 'package:app/repositories/language/language_repository.dart';
import 'package:app/repositories/theme/theme_repository.dart';
import 'package:app/repositories/user/user_repository.dart';
import 'package:app/stores/auth/auth_store.dart';
import 'package:app/stores/language/language_store.dart';
import 'package:app/stores/theme/theme_store.dart';
import 'package:app/stores/user/user_store.dart';
import 'package:app/ui/home/home_page.dart';
import 'package:app/ui/login/login_page.dart';
import 'package:app/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<ThemeRepository>());
  final AuthStore _authStore = AuthStore(getIt<AuthRepository>());

  //final PostStore _postStore = PostStore(getIt<Repository>());
  final LanguageStore _languageStore =
      LanguageStore(getIt<LanguageRepository>());
  final UserStore _userStore = UserStore(getIt<UserRepository>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<UserStore>(create: (_) => _userStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<AuthStore>(create: (_) => _authStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            //routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale!, language.code))
                .toList(),
            localizationsDelegates: const [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            // home: _userStore.isLoggedIn ? HomeScreen() : LoginScreen(),
           // home: const HomePage(),
            home: const LoginPage(),
          );
        },
      ),
    );
  }
}
