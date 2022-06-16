import '../utils/my_overlay_loader.dart';

import '../utils/size_config.dart';

import '../utils/my_flush_bar.dart';

import '../contract/connectivity_contract.dart';
import '../contract/profile_contract.dart';
import '../localization/app_localization.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../widget/my_app_bar.dart';
import '../widget/personal_info.dart';
import '../widget/profile_image.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile>
    implements Connectivity, ProfileContract {
  UserPresenter _presenter;

  Connectivity _connectivity;
  ProfileContract _profileContract;

  @override
  void initState() {
    _connectivity = this;
    _profileContract = this;

    _presenter =
        UserPresenter(_connectivity, profileContract: _profileContract);

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
                  MyAppBar(
                    AppLocalization.of(context).getTranslatedValue("profile"),
                    onBackPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),
                  ProfileImage(
                    onSubmit: (String imgBase64) {
                      _presenter.updateProfileImage(context, imgBase64);
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 2.5 * SizeConfig.heightSizeMultiplier,
                      ),
                      child: PersonalInfo(
                        onSubmit: (User user) {
                          _presenter.updatePersonalInfo(context, user);
                        },
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
  void onFailed(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void onProfileUpdated(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void onAddressAdded(BuildContext context) {}

  @override
  void onAddressDeleted(BuildContext context, int position) {}

  @override
  void onAddressUpdated(BuildContext context) {}
}
