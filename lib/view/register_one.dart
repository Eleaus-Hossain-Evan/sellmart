import 'package:flutter/services.dart';

import '../utils/my_flush_bar.dart';
import '../widget/my_button.dart';

import '../contract/connectivity_contract.dart';
import '../contract/otp_contract.dart';
import '../localization/app_localization.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../resources/images.dart';
import '../route/route_manager.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterOne extends StatefulWidget {
  @override
  _RegisterOneState createState() => _RegisterOneState();
}

class _RegisterOneState extends State<RegisterOne>
    implements Connectivity, OTPContract {
  UserPresenter _presenter;

  Connectivity _connectivity;
  OTPContract _otpContract;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _referralController = TextEditingController();

  FocusNode _firstNameNode = FocusNode();
  FocusNode _lastNameNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _referralNode = FocusNode();

  User user;

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
                              .getTranslatedValue("create_an_account"),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  controller: _firstNameController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _firstNameNode,
                                  onSubmitted: (string) {
                                    _lastNameNode.requestFocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalization.of(context)
                                        .getTranslatedValue("first_name"),
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
                                  controller: _lastNameController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _lastNameNode,
                                  onSubmitted: (string) {
                                    _phoneNode.requestFocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalization.of(context)
                                        .getTranslatedValue("last_name"),
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
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _phoneNode,
                                  onSubmitted: (string) {
                                    _referralNode.requestFocus();
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
                                  controller: _referralController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  focusNode: _referralNode,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  onSubmitted: (string) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalization.of(context)
                                        .getTranslatedValue("referral_code"),
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
                                height: 6.25 * SizeConfig.heightSizeMultiplier,
                              ),
                              MyButton(
                                AppLocalization.of(context)
                                    .getTranslatedValue("submit")
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(RouteManager.LOGIN);
                                },
                                child: Text(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("back_to_login"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
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
    Navigator.pop(context);
    return Future(() => false);
  }

  @override
  void dispose() {
    _presenter.hideOverlayLoader();
    super.dispose();
  }

  void _validateForm(BuildContext context) {
    if (_firstNameController.text.isEmpty) {
      _showToast(
          AppLocalization.of(context).getTranslatedValue("enter_first_name"),
          Toast.LENGTH_SHORT);
    } else {
      if (_lastNameController.text.isEmpty) {
        _showToast(
            AppLocalization.of(context).getTranslatedValue("enter_last_name"),
            Toast.LENGTH_SHORT);
      } else {
        if (_phoneController.text.isEmpty) {
          _showToast(
              AppLocalization.of(context).getTranslatedValue("enter_phone"),
              Toast.LENGTH_SHORT);
        } else {
          if (_phoneController.text.length != 11) {
            _showToast(
                AppLocalization.of(context)
                    .getTranslatedValue("must_be_11_digits"),
                Toast.LENGTH_SHORT);
          } else {
            if (_referralController.text.isNotEmpty &&
                _referralController.text.length != 6) {
              _showToast(
                  AppLocalization.of(context)
                      .getTranslatedValue("referral_code_must_be_6_digit"),
                  Toast.LENGTH_SHORT);
            } else {
              user = User(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  phone: _phoneController.text,
                  referralCode: _referralController.text);
              _presenter.sendSignUpOTP(context, user);
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
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("not_connected"));
  }

  @override
  void onFailedToSendOTP(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void onInactive(BuildContext context) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("inactive_connection"));
  }

  @override
  void onOTPSent(String phone) {
    Navigator.of(context).pushNamed(RouteManager.REGISTER_TWO, arguments: user);
  }

  @override
  void onTimeout(BuildContext context) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("connection_time_out"));
  }
}
