import '../utils/my_overlay_loader.dart';

import '../resources/images.dart';
import '../utils/my_flush_bar.dart';
import '../widget/my_button.dart';

import '../contract/password_contract.dart';
import '../localization/localization_constrants.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../route/route_manager.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../contract/connectivity_contract.dart';
import '../localization/app_localization.dart';
import '../main.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {

  final String phone;

  ResetPassword(this.phone);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> implements Connectivity, PasswordContract {

  UserPresenter _presenter;

  PasswordContract _passwordContract;
  Connectivity _connectivity;

  TextEditingController _otpController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  FocusNode _otpNode = FocusNode();
  FocusNode _passwordNode = FocusNode();
  FocusNode _confirmPasswordNode = FocusNode();

  bool _passToggle = true;
  bool _confirmPassToggle = true;


  @override
  void initState() {

    _connectivity = this;
    _passwordContract = this;

    _presenter = UserPresenter(_connectivity, passwordContract: _passwordContract);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (BuildContext context) {

            return SafeArea(
              child: Column(
                children: <Widget>[

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("reset_password"),
                    onBackPress: () {

                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),

                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            SizedBox(height: 6.25 * SizeConfig.heightSizeMultiplier,),

                            Image.asset(Images.password,
                              height: 18.75 * SizeConfig.heightSizeMultiplier,
                              width: 38.46 * SizeConfig.widthSizeMultiplier,
                              fit: BoxFit.fill,
                            ),

                            SizedBox(height: 5.5 * SizeConfig.heightSizeMultiplier,),

                            Padding(
                              padding: EdgeInsets.only(
                                left: 5.12 * SizeConfig.widthSizeMultiplier,
                                right: 5.12 * SizeConfig.widthSizeMultiplier,
                              ),
                              child: Text(MyApp.appLocale.languageCode == ENGLISH ? (AppLocalization.of(context).getTranslatedValue("otp_title") + " " + widget.phone) :
                              widget.phone + " " + AppLocalization.of(context).getTranslatedValue("otp_title"),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            SizedBox(height: 8.75 * SizeConfig.heightSizeMultiplier,),

                            Container(
                              height: 6 * SizeConfig.heightSizeMultiplier,
                              margin: EdgeInsets.only(
                                left: 3.84 * SizeConfig.widthSizeMultiplier,
                                right: 3.84 * SizeConfig.widthSizeMultiplier,
                              ),
                              child: TextField(
                                controller: _otpController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                focusNode: _otpNode,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4),
                                ],
                                onSubmitted: (string) {
                                  _passwordNode.requestFocus();
                                },
                                decoration: InputDecoration(
                                  hintText: AppLocalization.of(context).getTranslatedValue("otp"),
                                  hintStyle: TextStyle(
                                    fontSize: 2 * SizeConfig.textSizeMultiplier,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  contentPadding: EdgeInsets.all(1.5 * SizeConfig.heightSizeMultiplier),
                                ),
                              ),
                            ),

                            SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

                            Container(
                              height: 6 * SizeConfig.heightSizeMultiplier,
                              margin: EdgeInsets.only(
                                left: 3.84 * SizeConfig.widthSizeMultiplier,
                                right: 3.84 * SizeConfig.widthSizeMultiplier,
                              ),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _passToggle,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                focusNode: _passwordNode,
                                onSubmitted: (string) {
                                  _confirmPasswordNode.requestFocus();
                                },
                                decoration: InputDecoration(
                                  hintText: AppLocalization.of(context).getTranslatedValue("new_password"),
                                  hintStyle: TextStyle(
                                    fontSize: 2 * SizeConfig.textSizeMultiplier,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  suffixIcon: IconButton(icon: Icon(_passToggle ? Icons.visibility : Icons.visibility_off),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {

                                        setState(() {
                                          _passToggle = !_passToggle;
                                        });
                                      }),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  contentPadding: EdgeInsets.all(1.5 * SizeConfig.heightSizeMultiplier),
                                ),
                              ),
                            ),

                            SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

                            Container(
                              height: 6 * SizeConfig.heightSizeMultiplier,
                              margin: EdgeInsets.only(
                                left: 3.84 * SizeConfig.widthSizeMultiplier,
                                right: 3.84 * SizeConfig.widthSizeMultiplier,
                              ),
                              child: TextField(
                                controller: _confirmPasswordController,
                                obscureText: _confirmPassToggle,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                focusNode: _confirmPasswordNode,
                                onSubmitted: (string) {

                                  FocusScope.of(context).unfocus();
                                },
                                decoration: InputDecoration(
                                  hintText: AppLocalization.of(context).getTranslatedValue("confirm_password"),
                                  hintStyle: TextStyle(
                                    fontSize: 2 * SizeConfig.textSizeMultiplier,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  suffixIcon: IconButton(icon: Icon(_confirmPassToggle ? Icons.visibility : Icons.visibility_off),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {

                                        setState(() {
                                          _confirmPassToggle = !_confirmPassToggle;
                                        });
                                      }),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  contentPadding: EdgeInsets.all(1.5 * SizeConfig.heightSizeMultiplier),
                                ),
                              ),
                            ),

                            SizedBox(height: 6.25 * SizeConfig.heightSizeMultiplier,),

                            MyButton(AppLocalization.of(context).getTranslatedValue("reset_password").toUpperCase(),
                              marginLeft: 3.84,
                              marginRight: 3.84,
                              onPressed: () {

                                _validateForm(context);
                              },
                            ),
                          ],
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

    Navigator.pop(context);
    return Future(() => false);
  }


  @override
  void dispose() {

    _presenter.hideOverlayLoader();
    super.dispose();
  }


  void _validateForm(BuildContext context) {

    if(_otpController.text.isEmpty) {

      _showToast(AppLocalization.of(context).getTranslatedValue("enter_otp"), Toast.LENGTH_SHORT);
    }
    else {

      if(_otpController.text.length != 4) {

        _showToast(AppLocalization.of(context).getTranslatedValue("otp_must_be_4_digits"), Toast.LENGTH_SHORT);
      }
      else {

        if(_passwordController.text.isEmpty) {

          _showToast(AppLocalization.of(context).getTranslatedValue("enter_new_password"), Toast.LENGTH_SHORT);
        }
        else {

          if(_passwordController.text.length < 6) {

            _showToast(AppLocalization.of(context).getTranslatedValue("password_must_be_6_chars"), Toast.LENGTH_SHORT);
          }
          else {

            if(_confirmPasswordController.text.isEmpty) {

              _showToast(AppLocalization.of(context).getTranslatedValue("enter_confirm_password"), Toast.LENGTH_SHORT);
            }
            else {

              if(_passwordController.text != _confirmPasswordController.text) {

                _showToast(AppLocalization.of(context).getTranslatedValue("password_do_not_match"), Toast.LENGTH_SHORT);
              }
              else {

                User user = User(otp: _otpController.text, password: _passwordController.text, confirmPassword: _confirmPasswordController.text);
                _presenter.resetPassword(context, user);
              }
            }
          }
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

    MyFlushBar.show(context, AppLocalization.of(context).getTranslatedValue("not_connected"));
  }


  @override
  void onInactive(BuildContext context) {

    MyFlushBar.show(context, AppLocalization.of(context).getTranslatedValue("inactive_connection"));
  }


  @override
  void onTimeout(BuildContext context) {

    MyFlushBar.show(context, AppLocalization.of(context).getTranslatedValue("connection_time_out"));
  }


  @override
  void onFailure(BuildContext context, String message) {

    MyFlushBar.show(context, message);
  }


  @override
  void onSuccess() {

    Navigator.of(context).pushNamed(RouteManager.PASSWORD_RESET_SUCCESS);
  }
}