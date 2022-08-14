import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import '../route/route_manager.dart';
import '../resources/images.dart';
import '../utils/size_config.dart';
import '../presenter/user_presenter.dart';
import '../view/bottom_nav.dart';
import '../widget/custom_dialog.dart';
import '../localization/app_localization.dart';

class HomeAppBar extends StatefulWidget {
  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      child: Container(
        width: double.infinity,
        height: 6.875 * SizeConfig.heightSizeMultiplier,
        padding: EdgeInsets.only(
          left: 2.56 * SizeConfig.widthSizeMultiplier,
          right: 2.56 * SizeConfig.widthSizeMultiplier,
        ),
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              Images.landscapeLogo,
              height: 3.25 * SizeConfig.heightSizeMultiplier,
              width: 27 * SizeConfig.widthSizeMultiplier,
              fit: BoxFit.fill,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteManager.SEARCH);
                  },
                  child: Icon(
                    EvaIcons.search,
                    size: 6 * SizeConfig.imageSizeMultiplier,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: 2 * SizeConfig.widthSizeMultiplier,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (currentUser.value != null &&
                        currentUser.value.id != null &&
                        currentUser.value.id.isNotEmpty) {
                      Navigator.of(context).pushNamed(RouteManager.CART);
                    } else {
                      // _showNotLoggedInDialog(context);
                      Navigator.of(context)
                          .pushNamed(RouteManager.REGISTER_ONE);
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 6 * SizeConfig.imageSizeMultiplier,
                        color: Theme.of(context).primaryColor,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: .65 * SizeConfig.heightSizeMultiplier,
                            left: 5 * SizeConfig.widthSizeMultiplier,
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: numberOfItems,
                            builder:
                                (BuildContext context, int numberOfItem, _) {
                              return Container(
                                padding: EdgeInsets.all(
                                    .625 * SizeConfig.heightSizeMultiplier),
                                decoration: BoxDecoration(
                                  color: numberOfItem == 0
                                      ? Colors.transparent
                                      : Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  numberOfItem.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontSize: 1.375 *
                                            SizeConfig.textSizeMultiplier,
                                        fontWeight: FontWeight.w500,
                                        color: numberOfItem == 0
                                            ? Colors.transparent
                                            : Colors.black,
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
}
