import '../utils/size_config.dart';
import '../route/route_manager.dart';
import '../presenter/user_presenter.dart';
import '../view/bottom_nav.dart';
import '../widget/custom_dialog.dart';
import '../localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class MyAppBar extends StatefulWidget {
  final String title, subTitle;
  final Widget trailing;
  final bool autoImplyLeading;
  final bool enableButtons;
  final void Function() onBackPress, onTrailPress;

  MyAppBar(this.title,
      {this.autoImplyLeading = true,
      this.enableButtons = true,
      this.subTitle,
      this.trailing,
      this.onBackPress,
      this.onTrailPress});

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      child: Container(
        height: 6.875 * SizeConfig.heightSizeMultiplier,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: widget.autoImplyLeading,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        widget.onBackPress();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 3.84 * SizeConfig.widthSizeMultiplier,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          size: 6.41 * SizeConfig.imageSizeMultiplier,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 3.84 * SizeConfig.widthSizeMultiplier,
                        right: 3.84 * SizeConfig.widthSizeMultiplier,
                      ),
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              fontSize: 2.1 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Visibility(
                visible: widget.enableButtons,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 2.56 * SizeConfig.widthSizeMultiplier,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
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
                            Navigator.of(context).pushNamed(RouteManager.LOGIN);
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
                                  builder: (BuildContext context,
                                      int numberOfItem, _) {
                                    return Container(
                                      padding: EdgeInsets.all(.625 *
                                          SizeConfig.heightSizeMultiplier),
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
                ),
              ),
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
