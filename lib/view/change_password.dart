import '../utils/my_overlay_loader.dart';

import '../resources/images.dart';

import '../utils/my_flush_bar.dart';
import '../widget/my_button.dart';

import '../contract/connectivity_contract.dart';
import '../contract/profile_contract.dart';
import '../localization/app_localization.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassword extends StatefulWidget {

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with ChangeNotifier implements Connectivity, ProfileContract {

  UserPresenter _userPresenter;

  Connectivity _connectivity;
  ProfileContract _profileContract;

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  FocusNode _oldPasswordNode = FocusNode();
  FocusNode _newPasswordNode = FocusNode();
  FocusNode _confirmPasswordNode = FocusNode();

  bool _oldPassToggle = true;
  bool _newPassToggle = true;
  bool _confirmPassToggle = true;


  @override
  void initState() {

    _connectivity = this;
    _profileContract = this;

    _userPresenter = UserPresenter(_connectivity, profileContract: _profileContract);

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("change_password"),
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
                          children: <Widget>[

                            SizedBox(height: 6.25 * SizeConfig.heightSizeMultiplier,),

                            Image.asset(Images.changePassword,
                              height: 15 * SizeConfig.heightSizeMultiplier,
                              width: 30 * SizeConfig.widthSizeMultiplier,
                              fit: BoxFit.fill,
                            ),

                            SizedBox(height: 5.5 * SizeConfig.heightSizeMultiplier,),

                            Padding(
                              padding: EdgeInsets.only(
                                left: 5.12 * SizeConfig.widthSizeMultiplier,
                                right: 5.12 * SizeConfig.widthSizeMultiplier,
                              ),
                              child: Text(AppLocalization.of(context).getTranslatedValue("set_new_password"),
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
                                controller: _oldPasswordController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                obscureText: _oldPassToggle,
                                focusNode: _oldPasswordNode,
                                onSubmitted: (string) {
                                  _newPasswordNode.requestFocus();
                                },
                                decoration: InputDecoration(
                                  hintText: AppLocalization.of(context).getTranslatedValue("old_password"),
                                  hintStyle: TextStyle(
                                    fontSize: 2 * SizeConfig.textSizeMultiplier,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  suffixIcon: IconButton(icon: Icon(_oldPassToggle ? Icons.visibility : Icons.visibility_off),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {

                                        setState(() {
                                          _oldPassToggle = !_oldPassToggle;
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
                                controller: _newPasswordController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                obscureText: _newPassToggle,
                                focusNode: _newPasswordNode,
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
                                  suffixIcon: IconButton(icon: Icon(_newPassToggle ? Icons.visibility : Icons.visibility_off),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {

                                        setState(() {
                                          _newPassToggle = !_newPassToggle;
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
                                keyboardType: TextInputType.text,
                                obscureText: _confirmPassToggle,
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

                            SizedBox(height: 10 * SizeConfig.heightSizeMultiplier,),

                            MyButton(AppLocalization.of(context).getTranslatedValue("submit").toUpperCase(),
                              marginLeft: 3.84,
                              marginRight: 3.84,
                              onPressed: () {

                                FocusScope.of(context).unfocus();
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

    _userPresenter.hideOverlayLoader();
    super.dispose();
  }


  void _validateForm(BuildContext context) {

    if(_oldPasswordController.text.isEmpty) {

      _showToast(AppLocalization.of(context).getTranslatedValue("enter_old_password"), Toast.LENGTH_SHORT);
    }
    else {

      if(_newPasswordController.text.isEmpty) {

        _showToast(AppLocalization.of(context).getTranslatedValue("enter_new_password"), Toast.LENGTH_SHORT);
      }
      else {

        if(_newPasswordController.text.length < 6) {

          _showToast(AppLocalization.of(context).getTranslatedValue("password_must_be_6_chars"), Toast.LENGTH_SHORT);
        }
        else {

          if(_oldPasswordController.text == _newPasswordController.text) {

            _showToast(AppLocalization.of(context).getTranslatedValue("new_password_must_be_different"), Toast.LENGTH_SHORT);
          }
          else {

            if(_confirmPasswordController.text.isEmpty) {

              _showToast(AppLocalization.of(context).getTranslatedValue("enter_confirm_password"), Toast.LENGTH_SHORT);
            }
            else {

              if(_newPasswordController.text != _confirmPasswordController.text) {

                _showToast(AppLocalization.of(context).getTranslatedValue("confirm_password_do_not_match"), Toast.LENGTH_SHORT);
              }
              else {

                User user = User(password: _oldPasswordController.text, newPassword: _newPasswordController.text, confirmPassword: _confirmPasswordController.text);
                _userPresenter.changePassword(context, user);
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
  void onFailed(BuildContext context, String message) {

    MyFlushBar.show(context, message);
  }


  @override
  void onProfileUpdated(BuildContext context, String message) {

    MyFlushBar.show(context, message);

    _oldPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }


  @override
  void onAddressAdded(BuildContext context) {}


  @override
  void onAddressDeleted(BuildContext context, int position) {}


  @override
  void onAddressUpdated(BuildContext context) {}
}