import 'package:app/utils/my_flush_bar.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../localization/app_localization.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'my_button.dart';

class PersonalInfo extends StatefulWidget {
  final void Function(User) onSubmit;

  PersonalInfo({this.onSubmit});

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  FocusNode _lastNameNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _emailNode = FocusNode();

  bool _enabled = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 8 * SizeConfig.heightSizeMultiplier,
            bottom: 7.875 * SizeConfig.heightSizeMultiplier,
          ),
          child: ValueListenableBuilder(
            valueListenable: currentUser,
            builder: (BuildContext context, User user, _) {
              return NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                  return;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 3.84 * SizeConfig.widthSizeMultiplier,
                          right: 3.84 * SizeConfig.widthSizeMultiplier,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: .769 *
                                                SizeConfig.widthSizeMultiplier),
                                        child: Text(
                                          AppLocalization.of(context)
                                              .getTranslatedValue("first_name"),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.25 *
                                            SizeConfig.heightSizeMultiplier,
                                      ),
                                      Container(
                                        height:
                                            6 * SizeConfig.heightSizeMultiplier,
                                        child: TextField(
                                          controller: _firstNameController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          enabled: _enabled,
                                          onSubmitted: (string) {
                                            _lastNameNode.requestFocus();
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(.5 *
                                                      SizeConfig
                                                          .heightSizeMultiplier),
                                              borderSide: BorderSide(
                                                  color: Colors.black26,
                                                  width: .4 *
                                                      SizeConfig
                                                          .widthSizeMultiplier),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(.5 *
                                                      SizeConfig
                                                          .heightSizeMultiplier),
                                              borderSide: BorderSide(
                                                  color: Colors.black26,
                                                  width: .4 *
                                                      SizeConfig
                                                          .widthSizeMultiplier),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(.5 *
                                                      SizeConfig
                                                          .heightSizeMultiplier),
                                              borderSide: BorderSide(
                                                  color: Colors.black26,
                                                  width: .4 *
                                                      SizeConfig
                                                          .widthSizeMultiplier),
                                            ),
                                            contentPadding: EdgeInsets.all(1.5 *
                                                SizeConfig
                                                    .heightSizeMultiplier),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5.12 * SizeConfig.widthSizeMultiplier,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: .769 *
                                                SizeConfig.widthSizeMultiplier),
                                        child: Text(
                                          AppLocalization.of(context)
                                              .getTranslatedValue("last_name"),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.25 *
                                            SizeConfig.heightSizeMultiplier,
                                      ),
                                      Container(
                                        height:
                                            6 * SizeConfig.heightSizeMultiplier,
                                        child: TextField(
                                          controller: _lastNameController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          enabled: _enabled,
                                          focusNode: _lastNameNode,
                                          onSubmitted: (string) {
                                            _phoneNode.requestFocus();
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(.5 *
                                                      SizeConfig
                                                          .heightSizeMultiplier),
                                              borderSide: BorderSide(
                                                  color: Colors.black26,
                                                  width: .4 *
                                                      SizeConfig
                                                          .widthSizeMultiplier),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(.5 *
                                                      SizeConfig
                                                          .heightSizeMultiplier),
                                              borderSide: BorderSide(
                                                  color: Colors.black26,
                                                  width: .4 *
                                                      SizeConfig
                                                          .widthSizeMultiplier),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(.5 *
                                                      SizeConfig
                                                          .heightSizeMultiplier),
                                              borderSide: BorderSide(
                                                  color: Colors.black26,
                                                  width: .4 *
                                                      SizeConfig
                                                          .widthSizeMultiplier),
                                            ),
                                            contentPadding: EdgeInsets.all(1.5 *
                                                SizeConfig
                                                    .heightSizeMultiplier),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.75 * SizeConfig.heightSizeMultiplier,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: .769 * SizeConfig.widthSizeMultiplier),
                              child: Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("mobile"),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 1.25 * SizeConfig.heightSizeMultiplier,
                            ),
                            Container(
                              height: 6 * SizeConfig.heightSizeMultiplier,
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                enabled: _enabled,
                                focusNode: _phoneNode,
                                onSubmitted: (string) {
                                  _emailNode.requestFocus();
                                },
                                decoration: InputDecoration(
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
                              height: 3.75 * SizeConfig.heightSizeMultiplier,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: .769 * SizeConfig.widthSizeMultiplier),
                              child: Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("email"),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 1.25 * SizeConfig.heightSizeMultiplier,
                            ),
                            Container(
                              height: 6 * SizeConfig.heightSizeMultiplier,
                              child: TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                enabled: _enabled,
                                focusNode: _emailNode,
                                onSubmitted: (string) {
                                  FocusScope.of(context).unfocus();
                                },
                                decoration: InputDecoration(
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
                              height: 3.75 * SizeConfig.heightSizeMultiplier,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: .769 * SizeConfig.widthSizeMultiplier),
                              child: Text(
                                'My Referral Code',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 1.25 * SizeConfig.heightSizeMultiplier,
                            ),
                            Container(
                              height: 6 * SizeConfig.heightSizeMultiplier,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    currentUser.value.myReferCode,
                                    style: TextStyle(
                                      fontSize:
                                          2.4 * SizeConfig.textSizeMultiplier,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.copy,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    onPressed: () {
                                      final data = ClipboardData(
                                          text: currentUser.value.myReferCode);
                                      Clipboard.setData(data);
                                      MyFlushBar.show(context,
                                          "Referral code copied to Clipboard");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MyButton(
            _enabled
                ? AppLocalization.of(context)
                    .getTranslatedValue("save_information")
                : AppLocalization.of(context).getTranslatedValue("edit"),
            marginLeft: 3.84,
            marginRight: 3.84,
            onPressed: () {
              FocusScope.of(context).unfocus();
              _onButtonPress();
            },
          ),
        ),
      ],
    );
  }

  void _onButtonPress() {
    if (!_enabled) {
      setState(() {
        _enabled = true;
      });
    } else {
      _validate();
    }
  }

  void _validate() {
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
            if (_emailController.text.isNotEmpty) {
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(_emailController.text);

              if (emailValid) {
                _onValid();
              } else {
                _showToast(
                    AppLocalization.of(context)
                        .getTranslatedValue("enter_valid_email"),
                    Toast.LENGTH_SHORT);
              }
            } else {
              _onValid();
            }
          }
        }
      }
    }
  }

  void _onValid() {
    User user = User(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
        email: _emailController.text);
    widget.onSubmit(user);

    setState(() {
      _enabled = false;
    });
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

  void _init() {
    _firstNameController.text = currentUser.value.firstName;
    _lastNameController.text = currentUser.value.lastName;
    _phoneController.text = currentUser.value.phone;
    _emailController.text = currentUser.value.email;
  }
}
