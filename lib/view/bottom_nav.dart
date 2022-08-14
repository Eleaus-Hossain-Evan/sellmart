import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ionicons/ionicons.dart';
import '../db/db_helper.dart';
import '../model/user.dart';
import '../route/route_manager.dart';
import '../utils/shared_preference.dart';
import '../widget/custom_dialog.dart';
import '../utils/constants.dart';
import '../resources/images.dart';

import '../utils/size_config.dart';

import '../localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'campaign_offers.dart';
import 'categories.dart';
import 'home.dart';
import 'account.dart';
import 'my_orders.dart';

import 'dart:async';

ValueNotifier<int> numberOfItems = ValueNotifier(0);

class BottomNav extends StatefulWidget {
  final int index;

  BottomNav(this.index);

  @override
  _BottomNavState createState() => _BottomNavState();

  static void changeNavigationTab(BuildContext context, int position) {
    _BottomNavState state = context.findAncestorStateOfType<_BottomNavState>();
    state.changeTab(position);
  }
}

class _BottomNavState extends State<BottomNav> with ChangeNotifier {
  int _currentIndex = 0;

  MySharedPreference _sharedPreference = MySharedPreference();
  DBHelper _dbHelper = DBHelper();

  Timer _timer;

  @override
  void initState() {
    _getCount();
    _currentIndex = widget.index;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return IndexedStack(
              index: _currentIndex,
              children: [
                Home(
                  key: homeKey,
                ),
                Categories(
                  key: categoriesKey,
                ),
                MyOrders(
                  key: myOrderKey,
                ),
                CampaignOffers(
                  key: campaignOffersKey,
                ),
                Account(),
              ],
            );
          },
        ),
        bottomNavigationBar: Container(
          height: 7.25 * SizeConfig.heightSizeMultiplier,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(2.5 * SizeConfig.heightSizeMultiplier),
              topLeft: Radius.circular(2.5 * SizeConfig.heightSizeMultiplier),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: .5 * SizeConfig.heightSizeMultiplier,
                spreadRadius: .375 * SizeConfig.heightSizeMultiplier,
                offset: Offset(1.0, 0.0),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _setView(Constants.HOME);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Ionicons.home,
                          size: 5.38 * SizeConfig.imageSizeMultiplier,
                          color: _currentIndex == Constants.HOME
                              ? Theme.of(context).primaryColor
                              : Colors.black38,
                        ),
                        Text(
                          AppLocalization.of(context)
                              .getTranslatedValue("home"),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                                color: _currentIndex == Constants.HOME
                                    ? Theme.of(context).primaryColor
                                    : Colors.black38,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: .25 * SizeConfig.heightSizeMultiplier,
                      width: 10.25 * SizeConfig.widthSizeMultiplier,
                      color: _currentIndex == Constants.HOME
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _setView(Constants.CATEGORIES);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Images.category,
                          color: _currentIndex == Constants.CATEGORIES
                              ? Theme.of(context).primaryColor
                              : Colors.black38,
                          height: 2.5 * SizeConfig.heightSizeMultiplier,
                          width: 5.12 * SizeConfig.widthSizeMultiplier,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          AppLocalization.of(context)
                              .getTranslatedValue("categories"),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                                color: _currentIndex == Constants.CATEGORIES
                                    ? Theme.of(context).primaryColor
                                    : Colors.black38,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: .25 * SizeConfig.heightSizeMultiplier,
                      width: 10.25 * SizeConfig.widthSizeMultiplier,
                      color: _currentIndex == Constants.CATEGORIES
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _setView(Constants.ORDERS);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          EvaIcons.archive,
                          size: 5.38 * SizeConfig.imageSizeMultiplier,
                          color: _currentIndex == Constants.ORDERS
                              ? Theme.of(context).primaryColor
                              : Colors.black38,
                        ),
                        Text(
                          AppLocalization.of(context)
                              .getTranslatedValue("my_orders"),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                                color: _currentIndex == Constants.ORDERS
                                    ? Theme.of(context).primaryColor
                                    : Colors.black38,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: .25 * SizeConfig.heightSizeMultiplier,
                      width: 10.25 * SizeConfig.widthSizeMultiplier,
                      color: _currentIndex == Constants.ORDERS
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _setView(Constants.CAMPAIGN);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_offer,
                          size: 5.38 * SizeConfig.imageSizeMultiplier,
                          color: _currentIndex == Constants.CAMPAIGN
                              ? Theme.of(context).primaryColor
                              : Colors.black38,
                        ),
                        Text(
                          AppLocalization.of(context)
                              .getTranslatedValue("campaign"),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                                color: _currentIndex == Constants.CAMPAIGN
                                    ? Theme.of(context).primaryColor
                                    : Colors.black38,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: .25 * SizeConfig.heightSizeMultiplier,
                      width: 10.25 * SizeConfig.widthSizeMultiplier,
                      color: _currentIndex == Constants.CAMPAIGN
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _setView(Constants.ACCOUNT);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person,
                          size: 5.38 * SizeConfig.imageSizeMultiplier,
                          color: _currentIndex == Constants.ACCOUNT
                              ? Theme.of(context).primaryColor
                              : Colors.black38,
                        ),
                        Text(
                          AppLocalization.of(context)
                              .getTranslatedValue("account"),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                                color: _currentIndex == Constants.ACCOUNT
                                    ? Theme.of(context).primaryColor
                                    : Colors.black38,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: .25 * SizeConfig.heightSizeMultiplier,
                      width: 10.25 * SizeConfig.widthSizeMultiplier,
                      color: _currentIndex == Constants.ACCOUNT
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeTab(int position) {
    _setView(position);
  }

  void _setView(int index) {
    if (_currentIndex != index) {
      switch (index) {
        case Constants.HOME:
          _currentIndex = index;
          homeKey.currentState.reloadPage();
          break;

        case Constants.CATEGORIES:
          _currentIndex = index;
          categoriesKey.currentState.reloadPage();
          break;

        case Constants.ORDERS:
          _isLoggedIn(index);
          break;

        case Constants.CAMPAIGN:
          _currentIndex = index;
          campaignOffersKey.currentState.reloadPage();
          break;

        case Constants.ACCOUNT:
          _currentIndex = index;
          break;
      }

      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _isLoggedIn(int index) async {
    User user = await _sharedPreference.getCurrentUser();

    if (user == null || user.token == null || user.token.isEmpty) {
      // _showNotLoggedInDialog(context);
      Navigator.of(context).pushNamed(RouteManager.LOGIN);
    } else {
      _currentIndex = index;
      myOrderKey.currentState.reloadPage();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<Widget> _showNotLoggedInDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: AppLocalization.of(context).getTranslatedValue("alert"),
            message: AppLocalization.of(context)
                .getTranslatedValue("you_need_to_login"),
            onPositiveButtonPress: () {
              Navigator.of(context).pushNamed(RouteManager.LOGIN);
            },
          );
        });
  }

  Future<void> _getCount() async {
    numberOfItems.value = await _dbHelper.getProductCount();
    numberOfItems.notifyListeners();

    if (mounted) {
      setState(() {});
    }

    _startCartCountListener();
  }

  Future<void> _startCartCountListener() async {
    _stopTimer();

    _timer = Timer.periodic(Duration(minutes: 5), (timer) async {
      numberOfItems.value = await _dbHelper.getProductCount();
      numberOfItems.notifyListeners();

      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<bool> _onBackPress() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_currentIndex == 0) {
      _stopTimer();
      SystemNavigator.pop();
    } else {
      _setView(0);
    }

    return Future(() => false);
  }

  void _stopTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
