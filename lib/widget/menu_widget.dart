import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../localization/app_localization.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../resources/images.dart';
import '../route/route_manager.dart';
import '../utils/constants.dart';
import '../utils/shared_preference.dart';
import '../utils/size_config.dart';
import '../view/bottom_nav.dart';
import '../view/web_view.dart';

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> with ChangeNotifier {
  DBHelper _dbHelper = DBHelper();
  MySharedPreference _sharedPreference = MySharedPreference();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentUser,
      builder: (BuildContext context, User user, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 6.5 * SizeConfig.heightSizeMultiplier,
            ),

            Visibility(
              visible: user != null && user.id != null && user.id.isNotEmpty,
              child: ListTile(
                onTap: () {
                  _onItemClick(Constants.PROFILE_MENU);
                },
                dense: true,
                leading: Image.asset(
                  Images.profile,
                  height: 3.125 * SizeConfig.heightSizeMultiplier,
                  width: 6.41 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  AppLocalization.of(context).getTranslatedValue("profile"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),

            // Visibility(
            //   visible: user != null && user.id != null && user.id.isNotEmpty,
            //   child: ListTile(
            //     onTap: () {

            //       _onItemClick(Constants.MY_ORDER_MENU);
            //     },
            //     dense: true,
            //     leading: Image.asset(Images.shoppingBag,
            //       height: 3.125 * SizeConfig.heightSizeMultiplier,
            //       width: 6.41 * SizeConfig.widthSizeMultiplier,
            //       fit: BoxFit.fill,
            //     ),
            //     title: Text(AppLocalization.of(context).getTranslatedValue("my_orders"),
            //       style: Theme.of(context).textTheme.subtitle2.copyWith(
            //         fontWeight: FontWeight.w400,
            //       ),
            //     ),
            //   ),
            // ),

            Visibility(
              visible: user != null && user.id != null && user.id.isNotEmpty,
              child: ListTile(
                onTap: () {
                  _onItemClick(Constants.WISH_LIST_MENU);
                },
                dense: true,
                leading: Image.asset(
                  Images.wishList,
                  height: 3.125 * SizeConfig.heightSizeMultiplier,
                  width: 6.41 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  AppLocalization.of(context).getTranslatedValue("wish_list"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),

            Visibility(
              visible: user != null && user.id != null && user.id.isNotEmpty,
              child: ListTile(
                onTap: () {
                  _onItemClick(Constants.ADDRESS_MENU);
                },
                dense: true,
                leading: Image.asset(
                  Images.address,
                  height: 3.125 * SizeConfig.heightSizeMultiplier,
                  width: 6.41 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  AppLocalization.of(context).getTranslatedValue("address"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),

            Visibility(
              visible: user != null && user.id != null && user.id.isNotEmpty,
              child: ListTile(
                onTap: () {
                  _onItemClick(Constants.CHANGE_PASSWORD_MENU);
                },
                dense: true,
                leading: Image.asset(
                  Images.changePassword,
                  height: 3.125 * SizeConfig.heightSizeMultiplier,
                  width: 6.41 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  AppLocalization.of(context)
                      .getTranslatedValue("change_password"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),

            Visibility(
              visible: user != null && user.id != null && user.id.isNotEmpty,
              child: ListTile(
                onTap: () {
                  _onItemClick(Constants.REFUND_SETTLEMENT_MENU);
                },
                dense: true,
                leading: Image.asset(
                  Images.refund,
                  height: 3.125 * SizeConfig.heightSizeMultiplier,
                  width: 6.41 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  AppLocalization.of(context)
                      .getTranslatedValue("return_refund"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),

            ListTile(
              onTap: () {
                _onItemClick(Constants.TERMS_CONDITIONS_MENU);
              },
              dense: true,
              leading: Image.asset(
                Images.terms,
                height: 3.125 * SizeConfig.heightSizeMultiplier,
                width: 6.41 * SizeConfig.widthSizeMultiplier,
                fit: BoxFit.fill,
              ),
              title: Text(
                AppLocalization.of(context)
                    .getTranslatedValue("terms_condition"),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),

            ListTile(
              onTap: () {
                _onItemClick(Constants.PRIVACY_POLICY_MENU);
              },
              dense: true,
              leading: Image.asset(
                Images.privacy,
                height: 3.125 * SizeConfig.heightSizeMultiplier,
                width: 6.41 * SizeConfig.widthSizeMultiplier,
                fit: BoxFit.fill,
              ),
              title: Text(
                AppLocalization.of(context)
                    .getTranslatedValue("privacy_policy"),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),

            ListTile(
              onTap: () {
                _onItemClick(Constants.REPORT_ISSUE_MENU);
              },
              dense: true,
              leading: Image.asset(
                Images.report,
                height: 3.125 * SizeConfig.heightSizeMultiplier,
                width: 6.41 * SizeConfig.widthSizeMultiplier,
                fit: BoxFit.fill,
              ),
              title: Text(
                AppLocalization.of(context).getTranslatedValue("report_issue"),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),

            Visibility(
              visible: false,
              child: ListTile(
                onTap: () {
                  _onItemClick(Constants.ABOUT_US_MENU);
                },
                dense: true,
                leading: Image.asset(
                  Images.information,
                  height: 3.75 * SizeConfig.heightSizeMultiplier,
                  width: 7.69 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  AppLocalization.of(context).getTranslatedValue("about_us"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),

            Visibility(
              visible: false,
              child: ListTile(
                onTap: () {
                  _onItemClick(Constants.LANGUAGE_MENU);
                },
                dense: true,
                leading: Image.asset(
                  Images.translate,
                  height: 3.125 * SizeConfig.heightSizeMultiplier,
                  width: 6.41 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  AppLocalization.of(context).getTranslatedValue("language"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),

            Visibility(
              visible: user != null && user.id != null && user.id.isNotEmpty,
              child: ListTile(
                onTap: () {
                  _onItemClick(Constants.LOGOUT_MENU);
                },
                dense: true,
                leading: Image.asset(
                  Images.logout,
                  height: 3.125 * SizeConfig.heightSizeMultiplier,
                  width: 6.41 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  AppLocalization.of(context).getTranslatedValue("logout"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),

            Visibility(
              visible: user == null || user.id == null || user.id.isEmpty,
              child: ListTile(
                onTap: () {
                  _onItemClick(Constants.LOGIN_MENU);
                },
                dense: true,
                leading: Image.asset(
                  Images.enter,
                  height: 3.125 * SizeConfig.heightSizeMultiplier,
                  width: 6.41 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  AppLocalization.of(context).getTranslatedValue("login"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onItemClick(int value) {
    switch (value) {
      case Constants.PROFILE_MENU:
        _openMyProfilePage();
        break;

      case Constants.MY_ORDER_MENU:
        _openMyOrdersPage();
        break;

      case Constants.WISH_LIST_MENU:
        _openMyWishListPage();
        break;

      case Constants.ADDRESS_MENU:
        _openAddressPage();
        break;

      case Constants.CHANGE_PASSWORD_MENU:
        _openChangePasswordPage();
        break;

      case Constants.REFUND_SETTLEMENT_MENU:
        _openWebViewPage(
            AppLocalization.of(context).getTranslatedValue("return_refund"),
            Constants.RETURN_POLICY);
        break;

      case Constants.TERMS_CONDITIONS_MENU:
        _openWebViewPage(
            AppLocalization.of(context).getTranslatedValue("terms_condition"),
            Constants.TERMS_CONDITIONS);
        break;

      case Constants.PRIVACY_POLICY_MENU:
        _openWebViewPage(
            AppLocalization.of(context).getTranslatedValue("privacy_policy"),
            Constants.PRIVACY_POLICY);
        break;

      case Constants.REPORT_ISSUE_MENU:
        break;

      case Constants.ABOUT_US_MENU:
        _openAboutUsPage();
        break;

      case Constants.LANGUAGE_MENU:
        _openLanguagePage();
        break;

      case Constants.LOGIN_MENU:
        _login();
        break;

      case Constants.LOGOUT_MENU:
        _logOut();
        break;
    }
  }

  Future<void> _openMyProfilePage() async {
    Navigator.of(context).pushNamed(RouteManager.MY_PROFILE);
  }

  Future<void> _openMyOrdersPage() async {
    Navigator.of(context).pushNamed(RouteManager.MY_ORDERS);
  }

  Future<void> _openMyWishListPage() async {
    Navigator.of(context).pushNamed(RouteManager.WISH_LIST);
  }

  Future<void> _openWebViewPage(String title, int type) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WebView(title, type)));
  }

  Future<void> _openAddressPage() async {
    Navigator.of(context).pushNamed(RouteManager.MY_ADDRESS);
  }

  Future<void> _openChangePasswordPage() async {
    Navigator.of(context).pushNamed(RouteManager.CHANGE_PASSWORD);
  }

  Future<void> _openAboutUsPage() async {
    Navigator.of(context).pushNamed(RouteManager.ABOUT_US);
  }

  Future<void> _openLanguagePage() async {
    Navigator.of(context).pushNamed(RouteManager.LANGUAGE);
  }

  Future<void> _login() async {
    Navigator.of(context).pushNamed(RouteManager.LOGIN);
  }

  Future<void> _logOut() async {
    await _dbHelper.deleteAllProduct();

    numberOfItems.value = await _dbHelper.getProductCount();
    numberOfItems.notifyListeners();

    await _sharedPreference.remove(MySharedPreference.CURRENT_USER);

    currentUser.value = User();
    currentUser.notifyListeners();
  }
}
