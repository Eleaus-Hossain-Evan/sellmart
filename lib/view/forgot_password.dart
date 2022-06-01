import '../utils/my_overlay_loader.dart';

import '../resources/images.dart';
import '../utils/my_flush_bar.dart';
import '../widget/my_button.dart';

import '../contract/otp_contract.dart';
import '../presenter/user_presenter.dart';
import '../route/route_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../contract/connectivity_contract.dart';
import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> implements Connectivity, OTPContract {

  UserPresenter _presenter;

  OTPContract _otpContract;
  Connectivity _connectivity;

  TextEditingController _phoneController = TextEditingController();


  @override
  void initState() {

    _connectivity = this;
    _otpContract = this;

    _presenter = UserPresenter(_connectivity, otpContract: _otpContract);

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
                children: <Widget>[

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("forgot_pass"),
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

                            Image.asset(Images.confusion,
                              height: 18.75 * SizeConfig.heightSizeMultiplier,
                              width: 38.46 * SizeConfig.widthSizeMultiplier,
                              fit: BoxFit.fill,
                            ),

                            SizedBox(height: 8 * SizeConfig.heightSizeMultiplier,),

                            Padding(
                              padding: EdgeInsets.only(
                                left: 5.12 * SizeConfig.widthSizeMultiplier,
                                right: 5.12 * SizeConfig.widthSizeMultiplier,
                              ),
                              child: Text(AppLocalization.of(context).getTranslatedValue("enter_registered_phone"),
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
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (string) {

                                  _validateForm(context);
                                },
                                decoration: InputDecoration(
                                  hintText: AppLocalization.of(context).getTranslatedValue("phone"),
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

                            SizedBox(height: 6.25 * SizeConfig.heightSizeMultiplier,),

                            MyButton(AppLocalization.of(context).getTranslatedValue("submit").toUpperCase(),
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

    FocusScope.of(context).unfocus();

    if(_phoneController.text.isEmpty) {

      _showToast(AppLocalization.of(context).getTranslatedValue("enter_phone"), Toast.LENGTH_SHORT);
    }
    else {

      if(_phoneController.text.length != 11) {

        _showToast(AppLocalization.of(context).getTranslatedValue("must_be_11_digits"), Toast.LENGTH_SHORT);
      }
      else {

        _presenter.sendPasswordResetOTP(context, _phoneController.text);
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
  void onFailedToSendOTP(BuildContext context, String message) {

    MyFlushBar.show(context, message);
  }


  @override
  void onOTPSent(String phone) {

    Navigator.of(context).pushNamed(RouteManager.RESET_PASSWORD, arguments: phone);
  }
}