import '../utils/my_flush_bar.dart';
import '../widget/my_button.dart';

import '../contract/connectivity_contract.dart';
import '../contract/login_contract.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../localization/app_localization.dart';
import '../resources/images.dart';
import '../route/route_manager.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements Connectivity, LoginContract {
  UserPresenter _presenter;

  Connectivity _connectivity;
  LoginContract _loginContract;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _phoneNode = FocusNode();
  FocusNode _passwordNode = FocusNode();

  bool _toggle = true;

  @override
  void initState() {
    _connectivity = this;
    _loginContract = this;

    _presenter = UserPresenter(_connectivity, loginContract: _loginContract);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Builder(
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 22 * SizeConfig.heightSizeMultiplier,
                          padding: EdgeInsets.only(
                            left: 20 * SizeConfig.widthSizeMultiplier,
                            right: 20 * SizeConfig.widthSizeMultiplier,
                          ),
                          child: Image.asset(
                            Images.appIcon,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          AppLocalization.of(context)
                              .getTranslatedValue("login_to_your_account"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(
                          height: 3 * SizeConfig.heightSizeMultiplier,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 3.25 * SizeConfig.heightSizeMultiplier,
                              ),
                              Container(
                                height: 6 * SizeConfig.heightSizeMultiplier,
                                margin: EdgeInsets.only(
                                  left: 3.84 * SizeConfig.widthSizeMultiplier,
                                  right: 3.84 * SizeConfig.widthSizeMultiplier,
                                ),
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _phoneNode,
                                  onSubmitted: (string) {
                                    _passwordNode.requestFocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalization.of(context)
                                        .getTranslatedValue("phone"),
                                    hintStyle: TextStyle(
                                      fontSize:
                                          2 * SizeConfig.textSizeMultiplier,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .5 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                          color: Colors.black26,
                                          width: .4 *
                                              SizeConfig.widthSizeMultiplier),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .5 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                          color: Colors.black26,
                                          width: .4 *
                                              SizeConfig.widthSizeMultiplier),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .5 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                          color: Colors.black26,
                                          width: .4 *
                                              SizeConfig.widthSizeMultiplier),
                                    ),
                                    contentPadding: EdgeInsets.all(
                                        1.5 * SizeConfig.heightSizeMultiplier),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.5 * SizeConfig.heightSizeMultiplier,
                              ),
                              Container(
                                height: 6 * SizeConfig.heightSizeMultiplier,
                                margin: EdgeInsets.only(
                                  left: 3.84 * SizeConfig.widthSizeMultiplier,
                                  right: 3.84 * SizeConfig.widthSizeMultiplier,
                                ),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: _toggle,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  focusNode: _passwordNode,
                                  onSubmitted: (string) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalization.of(context)
                                        .getTranslatedValue("password"),
                                    hintStyle: TextStyle(
                                      fontSize:
                                          2 * SizeConfig.textSizeMultiplier,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(_toggle
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          setState(() {
                                            _toggle = !_toggle;
                                          });
                                        }),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .5 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                          color: Colors.black26,
                                          width: .4 *
                                              SizeConfig.widthSizeMultiplier),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .5 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                          color: Colors.black26,
                                          width: .4 *
                                              SizeConfig.widthSizeMultiplier),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .5 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                          color: Colors.black26,
                                          width: .4 *
                                              SizeConfig.widthSizeMultiplier),
                                    ),
                                    contentPadding: EdgeInsets.all(
                                        1.5 * SizeConfig.heightSizeMultiplier),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 1.875 * SizeConfig.heightSizeMultiplier,
                                  right: 3.84 * SizeConfig.widthSizeMultiplier,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        RouteManager.FORGOT_PASSWORD);
                                  },
                                  child: Text(
                                    AppLocalization.of(context)
                                        .getTranslatedValue("forgot_password"),
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 6.25 * SizeConfig.heightSizeMultiplier,
                              ),
                              MyButton(
                                AppLocalization.of(context)
                                    .getTranslatedValue("login")
                                    .toUpperCase(),
                                marginLeft: 3.84,
                                marginRight: 3.84,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  _validateForm(context);
                                },
                              ),
                              SizedBox(
                                height: 3.75 * SizeConfig.heightSizeMultiplier,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    AppLocalization.of(context)
                                        .getTranslatedValue(
                                            "dont_have_account"),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  SizedBox(
                                    width:
                                        2.05 * SizeConfig.widthSizeMultiplier,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(RouteManager.REGISTER_ONE);
                                    },
                                    child: Text(
                                      AppLocalization.of(context)
                                          .getTranslatedValue("sign_up")
                                          .toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.75 * SizeConfig.heightSizeMultiplier,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPress() {
    onLoginSuccess();
    return Future(() => false);
  }

  void _validateForm(BuildContext context) {
    if (_phoneController.text.isEmpty) {
      _showToast(AppLocalization.of(context).getTranslatedValue("enter_phone"),
          Toast.LENGTH_SHORT);
    } else {
      if (_phoneController.text.length != 11) {
        _showToast(
            AppLocalization.of(context).getTranslatedValue("must_be_11_digits"),
            Toast.LENGTH_SHORT);
      } else {
        if (_passwordController.text.isEmpty) {
          _showToast(
              AppLocalization.of(context).getTranslatedValue("enter_password"),
              Toast.LENGTH_SHORT);
        } else {
          User user = User(
              phone: _phoneController.text, password: _passwordController.text);
          _presenter.login(context, user);
        }
      }
    }
  }

  void _showToast(String message, Toast length) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(.8),
      textColor: Colors.white,
      fontSize: 2 * SizeConfig.textSizeMultiplier,
    );
  }

  @override
  void onDisconnected(BuildContext context) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("not_connected"));
  }

  @override
  void onInactive(BuildContext context) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("inactive_connection"));
  }

  @override
  void onTimeout(BuildContext context) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("connection_time_out"));
  }

  @override
  void onFailure(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void dispose() {
    _presenter.hideOverlayLoader();
    super.dispose();
  }

  @override
  void onLoginSuccess() {
    Navigator.pop(context);
  }
}
