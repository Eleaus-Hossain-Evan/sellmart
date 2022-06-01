import 'package:flutter/material.dart';
import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import '../model/product.dart';
import '../db/db_helper.dart';
import '../presenter/user_presenter.dart';
import '../route/route_manager.dart';
import '../view/bottom_nav.dart';
import '../utils/messaging.dart';
import '../utils/bounce_animation.dart';
import '../widget/custom_dialog.dart';
import '../utils/my_flush_bar.dart';

class ProductDetailsFooter extends StatefulWidget {

  final Product product;

  ProductDetailsFooter(this.product);

  @override
  _ProductDetailsFooterState createState() => _ProductDetailsFooterState();
}

class _ProductDetailsFooterState extends State<ProductDetailsFooter> with ChangeNotifier {

  DBHelper _dbHelper = DBHelper();

  final _bounceKey1 = GlobalKey<BounceState>();
  final _bounceKey2 = GlobalKey<BounceState>();

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 8 * SizeConfig.heightSizeMultiplier,
        padding: EdgeInsets.only(
          right: 2.56 * SizeConfig.widthSizeMultiplier,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: .512 * SizeConfig.widthSizeMultiplier, color: Colors.black12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {

                        Messaging.callSupport();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Icon(Icons.call,
                            size: 4.8 * SizeConfig.widthSizeMultiplier,
                            color: Theme.of(context).accentColor,
                          ),

                          SizedBox(height: .5 * SizeConfig.heightSizeMultiplier,),

                          Text(AppLocalization.of(context).getTranslatedValue("call_now"),
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 1.58 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    height: double.infinity,
                    width: .256 * SizeConfig.widthSizeMultiplier,
                    margin: EdgeInsets.only(
                      top: 1.5 * SizeConfig.heightSizeMultiplier,
                      bottom: 1.5 * SizeConfig.heightSizeMultiplier,
                    ),
                    color: Colors.black.withOpacity(.3),
                  ),

                  SizedBox(width: 2 * SizeConfig.widthSizeMultiplier,),

                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {

                        Messaging.launchMessenger();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Icon(Icons.message,
                            size: 4.8 * SizeConfig.widthSizeMultiplier,
                            color: Theme.of(context).dialogBackgroundColor,
                          ),

                          SizedBox(height: .5 * SizeConfig.heightSizeMultiplier,),

                          Text(AppLocalization.of(context).getTranslatedValue("message_now"),
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 1.58 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 2 * SizeConfig.widthSizeMultiplier,),

            Expanded(
              flex: 5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Expanded(
                    flex: 1,
                    child: BounceAnimation(
                      key: _bounceKey1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                          _buyNow(context);
                        },
                        child: Container(
                          height: 5 * SizeConfig.heightSizeMultiplier,
                          decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Text(AppLocalization.of(context).getTranslatedValue("buy_now").toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontSize: 1.55 * SizeConfig.textSizeMultiplier,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 2 * SizeConfig.widthSizeMultiplier,),

                  Expanded(
                    flex: 1,
                    child: BounceAnimation(
                      key: _bounceKey2,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                          _addToCart(context, false);
                        },
                        child: Container(
                          height: 5 * SizeConfig.heightSizeMultiplier,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Text(AppLocalization.of(context).getTranslatedValue("add_to_cart").toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontSize: 1.55 * SizeConfig.textSizeMultiplier,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _addToCart(BuildContext context, bool isBuying) async {

    if((widget.product.variationType == 0 || widget.product.variationType == 1) && widget.product.variations.length > 0) {

      if((widget.product.selectedVariation != null && widget.product.selectedVariation.stock > 0) ||
          (widget.product.currentStock != null && widget.product.currentStock > 0)) {

        _insertIntoLocalDB(context, isBuying);
      }
    }
    else if(widget.product.variationType == 2 && widget.product.sizeInfos.length > 0 && widget.product.sizeInfos[0].infos.length > 1) {

      widget.product.selectedInfoSizeStock = 0;

      for(int i=1; i<widget.product.sizeInfos[0].infos.length; i++) {

        if(widget.product.sizeInfos[0].infos[i][1] == widget.product.selectedSizeItem) {

          widget.product.selectedInfoSizeStock = int.parse(widget.product.sizeInfos[0].infos[i][0]);
          break;
        }
      }

      if(widget.product.selectedInfoSizeStock > 0) {

        _insertIntoLocalDB(context, isBuying);
      }
    }
  }


  Future<void> _buyNow(BuildContext context) async {

    if(currentUser.value != null && currentUser.value.id != null && currentUser.value.id.isNotEmpty) {

      _addToCart(context, true);
    }
    else {

      _showNotLoggedInDialog(context);
    }
  }


  Future<void> _insertIntoLocalDB(BuildContext context, bool isBuying) async {

    if(isBuying) {

      _bounceKey1.currentState.animationController.forward();
    }
    else {

      _bounceKey2.currentState.animationController.forward();
    }

    widget.product.isCampaignOffer = false;

    int value = await _dbHelper.addProduct(widget.product);

    numberOfItems.value = await _dbHelper.getProductCount();
    numberOfItems.notifyListeners();

    if(value != 0) {

      if(isBuying) {

        Navigator.of(context).pushNamed(RouteManager.CART);
      }
      else {

        MyFlushBar.show(context, AppLocalization.of(context).getTranslatedValue("product_added_to_cart"));
      }
    }
  }


  Future<Widget> _showNotLoggedInDialog(BuildContext context) async {

    return showDialog(
        context: context,
        builder: (BuildContext context) {

          return CustomDialog(
            title: AppLocalization.of(context).getTranslatedValue("alert"),
            message: AppLocalization.of(context).getTranslatedValue("you_need_to_login"),
            onPositiveButtonPress: () {

              Navigator.of(context).pushNamed(RouteManager.LOGIN);
            },
          );
        }
    );
  }
}