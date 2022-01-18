import 'package:app/constants/colors.dart';
import 'package:app/models/navigation/navigation_titles.dart';
import 'package:app/stores/language/language_store.dart';
import 'package:app/stores/theme/theme_store.dart';
import 'package:app/stores/user/user_store.dart';
import 'package:app/ui/navigation/bottom_navigation.dart';
import 'package:app/ui/pages/help/help_page.dart';
import 'package:app/ui/pages/history/history_page.dart';
import 'package:app/ui/pages/map/map_page.dart';
import 'package:app/ui/pages/map/map_view.dart';
import 'package:app/ui/pages/routes/routes_page.dart';
import 'package:app/utils/locale/app_localization.dart';
import 'package:app/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:another_flushbar/flushbar_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _position = 0;
  final PageController _controller =
      PageController(viewportFraction: 1, keepPage: true);

  void _onItemTapped(int index) {
    setState(() {
      _position = index;
    });
    if (_controller.hasClients) {
      _controller.jumpToPage(index);
    }
  }

  List<NavigationTitles> getNavigationTitles() {
    List<NavigationTitles> bottomNavigationTitles = [
      NavigationTitles(
        label: AppLocalizations.of(context).translate('map'),
        icon: SvgPicture.asset(
          'assets/menu/ic_map.svg',
          color: AppColors.pizazz,
        ),
        activeIcon: SvgPicture.asset(
          'assets/menu/ic_map.svg',
          color: AppColors.waterloo,
        ),
      ),
      NavigationTitles(
        label: AppLocalizations.of(context).translate('routes'),
        icon: SvgPicture.asset(
          'assets/menu/ic_route.svg',
          color: AppColors.pizazz,
        ),
        activeIcon: SvgPicture.asset(
          'assets/menu/ic_route.svg',
          color: AppColors.waterloo,
        ),
      ),
      NavigationTitles(
        label: 'History',
        icon: SvgPicture.asset(
          'assets/menu/ic_history.svg',
          color: AppColors.pizazz,
        ),
        activeIcon: SvgPicture.asset(
          'assets/menu/ic_history.svg',
          color: AppColors.waterloo,
        ),
      ),
      NavigationTitles(
        label: 'Help',
        icon: SvgPicture.asset(
          'assets/menu/ic_help.svg',
          color: AppColors.pizazz,
        ),
        activeIcon: SvgPicture.asset(
          'assets/menu/ic_help.svg',
          color: AppColors.waterloo,
        ),
      ),
    ];

    return bottomNavigationTitles;
  }

  //stores:---------------------------------------------------------------------
  UserStore _postStore;
  ThemeStore _themeStore;
  LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _postStore = Provider.of<UserStore>(context);

    // check to see if already called api
    if (!_postStore.loading) {
      _postStore.getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: BottomNavigatorProvider())
        ],
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ));
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(_getTitle()),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildLanguageButton(),
      _buildThemeButton(),
    ];
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.waterloo,
      unselectedItemColor: AppColors.pizazz,
      unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Calibri',
          color: AppColors.pizazz,
          fontSize: 10),
      selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Calibri',
          color: AppColors.waterloo,
          fontSize: 11),
      type: BottomNavigationBarType.fixed,
      items: [
        for (final tab in getNavigationTitles())
          BottomNavigationBarItem(
            icon: tab.icon,
            activeIcon: tab.activeIcon,
            label: tab.label,
          )
      ],
      currentIndex: _position,
      onTap: _onItemTapped,
    );
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () {
        /*   SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });*/
      },
      icon: const Icon(
        Icons.power_settings_new,
      ),
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: const Icon(
        Icons.language,
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _postStore.loading
            ? const CustomProgressIndicatorWidget()
            : Material(child: _buildPageView());
      },
    );
  }

/*

  Widget _buildListView() {
    return _postStore.user != null
        ? PageView(
            physics: const AlwaysScrollableScrollPhysics(),
            allowImplicitScrolling: true,
            controller: _controller,
            children: <Widget>[

            ],
            onPageChanged: (int page) {
              setState(() {
                _position = page;
              });
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }
*/

  Widget _buildPageView() {
    return Observer(builder: (context) {
      return PageView(
        // physics: const AlwaysScrollableScrollPhysics(),
        physics: const NeverScrollableScrollPhysics(),
        allowImplicitScrolling: true,
        controller: _controller,
        children: <Widget>[
          const MapPage(),
          const MapView(),
          const HistoryPage(),
          HelpPage(user: _postStore.user),
        ],
        onPageChanged: (int page) {
          setState(() {
            _position = page;
          });
        },
      );
    });
  }

/*

  Widget _buildPageView() {
    return _postStore.user != null
        ? PageView(
            physics: const AlwaysScrollableScrollPhysics(),
            allowImplicitScrolling: true,
            controller: _controller,
            children: const <Widget>[
              MapPage(),
              RoutesPage(),
              HistoryPage(),
              HelpPage(),
            ],
            onPageChanged: (int page) {
              setState(() {
                _position = page;
              });
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }
*/

/*
  Widget _buildListItem(int position) {
    return const ListTile(
      dense: true,
      leading: Icon(Icons.cloud_circle),
      */
/*    title: Text(
        '${_postStore.user?.posts?[position].title}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        '${_postStore.user?.posts?[position].body}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),*/ /*

    );
  }
*/

  String _getTitle() {
    switch (_position) {
      case 0:
        return AppLocalizations.of(context).translate('map');
      case 1:
        return AppLocalizations.of(context).translate('routes');
      case 2:
        return AppLocalizations.of(context).translate('history');
      case 3:
        return AppLocalizations.of(context).translate('help');
      default:
        return AppLocalizations.of(context).translate('map');
    }
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_postStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_postStore.errorStore.errorMessage);
        }

        return const SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(const Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    });

    return const SizedBox.shrink();
  }

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _showDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
