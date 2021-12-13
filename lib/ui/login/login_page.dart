import 'dart:ui';

import 'package:app/constants/assets.dart';
import 'package:app/constants/colors.dart';
import 'package:app/stores/auth/auth_store.dart';
import 'package:app/stores/form/form_store.dart';
import 'package:app/stores/theme/theme_store.dart';
import 'package:app/ui/home/home_page.dart';
import 'package:app/utils/device/device_utils.dart';
import 'package:app/utils/locale/app_localization.dart';
import 'package:app/utils/routes/routes.dart';
import 'package:app/widgets/app_icon_widget.dart';
import 'package:app/widgets/progress_indicator_widget.dart';
import 'package:app/widgets/rounded_button_widget.dart';
import 'package:app/widgets/textfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusNode _passwordFocusNode;
  late AuthStore _authStore;
  late ThemeStore _themeStore;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.azureRadiance;
    }
    return AppColors.azureRadiance;
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Align(
                alignment: FractionalOffset.topCenter,
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.35),
                  child: SizedBox(
                    height: 290,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset('assets/bg/img.png', fit: BoxFit.cover),
                        ClipRRect(
                          // Clip it cleanly.
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              color: Colors.white.withOpacity(0.4),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const AppIconWidget(
                                      image: 'assets/icons/ic_appicon.png'),
                                  SvgPicture.asset(Assets.appLogoText),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "We will get you anywhere you need!!!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Strait',
                                color: AppColors.pizazz,
                                decoration: TextDecoration.none,
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4,
                        left: 32,
                        right: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildUserIdField(),
                        _buildForgotPasswordButton(),
                        _buildCheck(),
                        _buildSignInButton(),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 24),
                          child: Text(
                            "OR",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Strait',
                              color: AppColors.tuna.withOpacity(0.5),
                              decoration: TextDecoration.none,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                        _buildSocial(),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Observer(builder: (context) {
      return RoundedButtonWidget(
        buttonText: AppLocalizations.of(context).translate('login_btn_sign_in'),
        buttonColor: AppColors.pizazz,
        disabledColor: AppColors.chardonnay,
        textColor: Colors.white,
        isDisabled: !_authStore.isReadyToLogin,
        onPressed: () async {
          if (_authStore.canLogin) {
            DeviceUtils.hideKeyboard(context);
            postGetAuth();
          } else {
            _showErrorMessage('Please fill in all fields');
          }
        },
      );
    });
  }

  Widget _buildCheck() {
    return Observer(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: _authStore.isAgreeConditions,
            onChanged: (bool? value) {
              _authStore.isAgreeConditions = value!;
            },
          ),
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(children: <InlineSpan>[
              TextSpan(
                  text: ' I agree with Phaeton’s',
                  style: TextStyle(color: AppColors.tuna.withOpacity(0.6))),
              TextSpan(
                text: ' Terms',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.azureRadiance),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              TextSpan(
                  text: ' and',
                  style: TextStyle(color: AppColors.tuna.withOpacity(0.6))),
              TextSpan(
                text: ' Conditions',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.azureRadiance),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ]),
          )
        ],
      );
    });
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: FlatButton(
        padding: const EdgeInsets.all(0.0),
        child: Text(
          AppLocalizations.of(context).translate('login_btn_forgot_password'),
          style:
              TextStyle(color: AppColors.tuna.withOpacity(0.6), fontSize: 13),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildSocial() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    onTap: () {
                      // navigatorHome();
                      //TODO apple
                      _authStore.signInWithGoogle();
                    },
                    child: SvgPicture.asset(
                      Assets.apple,
                      height: 48,
                      width: 48,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    onTap: () {
                      //navigatorHome();
                      //TODO google
                      _authStore.signInWithGoogle();
                    },
                    child: SvgPicture.asset(
                      Assets.google,
                      height: 48,
                      width: 48,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    onTap: () {
                      // navigatorHome();
                      //TODO fb
                      _authStore.signInWithFacebook();
                    },
                    child: SvgPicture.asset(
                      Assets.fb,
                      height: 48,
                      width: 48,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    onTap: () {
                      // navigatorHome();
                      //TODO linkedin
                      _authStore.signInWithGoogle();
                    },
                    child: SvgPicture.asset(
                      Assets.linkedin,
                      height: 48,
                      width: 48,
                    ),
                  ),
                ),
              ],
            )));
  }

  Future<void> navigatorHome() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false);
  }

  Future<void> postGetAuth() async {
    final auth = await _authStore.register();
    navigatorHome();
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('login_et_user_email'),
          inputType: TextInputType.emailAddress,
          icon: Icons.person,
          isIcon: false,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _authStore.setUserId(_userEmailController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _authStore.authErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint:
              AppLocalizations.of(context).translate('login_et_user_password'),
          isObscure: true,
          padding: const EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          errorText: _authStore.authErrorStore.password,
          onChanged: (value) {
            _authStore.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          MediaQuery.of(context).orientation == Orientation.landscape
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildLeftSide(),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildRightSide(),
                    ),
                  ],
                )
              : _buildRightSide(),
          Observer(
            builder: (context) {
              return _authStore.success
                  ? navigate(context)
                  : _showErrorMessage(_authStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _authStore.loading,
                child: const CustomProgressIndicatorWidget(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLeftSide() {
    return SizedBox.expand(
      child: Image.asset(
        Assets.carBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget navigate(BuildContext context) {
    /*  SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });*/

    return Container();
  }

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

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
