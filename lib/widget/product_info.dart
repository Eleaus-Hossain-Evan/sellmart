import 'package:app/model/variation.dart';
import 'package:app/view/product_details.dart';

import '../utils/api_routes.dart';
import 'package:share_plus/share_plus.dart';

import '../localization/app_localization.dart';
import '../model/product.dart';
import '../utils/size_config.dart';
import '../presenter/user_presenter.dart';
import '../route/route_manager.dart';
import '../widget/custom_dialog.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  final String strDiscount, strVat;
  final void Function() addToWishList;
  final void Function() removeFromWishList;

  ProductInfo(this.product, this.strDiscount, this.strVat,
      {this.addToWishList, this.removeFromWishList});

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 1 * SizeConfig.heightSizeMultiplier,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.product.variationType == 2
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.product != null &&
                                widget.product.currentPrice != null
                            ? ("৳ " +
                                widget.product.currentPrice.round().toString())
                            : "",
                        style: Theme.of(context).textTheme.headline3.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      SizedBox(width: 10),
                      Visibility(
                        visible: widget.product != null &&
                            (widget.product.currentPrice <
                                widget.product.sizeInfos[0].regularPrice),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 1.5 * SizeConfig.heightSizeMultiplier,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: widget.product != null &&
                                    widget.product.currentPrice != null &&
                                    widget.product.price != null &&
                                    (widget.product.currentPrice !=
                                        widget.product.price),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        2.56 * SizeConfig.widthSizeMultiplier,
                                  ),
                                  child: Text(
                                    widget.product != null &&
                                            widget.product.price != null
                                        ? ("৳ " +
                                            widget.product.sizeInfos[0]
                                                .regularPrice
                                                .round()
                                                .toString())
                                        : "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(.35),
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.strDiscount.isNotEmpty,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        2.56 * SizeConfig.widthSizeMultiplier,
                                  ),
                                  child: Text(
                                    "-" + widget.strDiscount,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          fontSize: 1.75 *
                                              SizeConfig.textSizeMultiplier,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).errorColor,
                                        ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.product != null &&
                                    widget.product.vat != null &&
                                    widget.product.vat != 0.0,
                                child: Container(
                                  color: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.only(
                                    top: .5 * SizeConfig.heightSizeMultiplier,
                                    bottom:
                                        .5 * SizeConfig.heightSizeMultiplier,
                                    left: 1.79 * SizeConfig.widthSizeMultiplier,
                                    right:
                                        1.79 * SizeConfig.widthSizeMultiplier,
                                  ),
                                  margin: EdgeInsets.only(
                                      right: 5.12 *
                                          SizeConfig.widthSizeMultiplier),
                                  child: Text(
                                    widget.product != null &&
                                            widget.product.vat != null &&
                                            widget.product.vat != 0.0
                                        ? (AppLocalization.of(context)
                                                .getTranslatedValue("vat") +
                                            " " +
                                            widget.product.vat
                                                .round()
                                                .toString() +
                                            "%")
                                        : "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 1.75 *
                                              SizeConfig.textSizeMultiplier,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : ValueListenableBuilder<Variation>(
                    valueListenable: onSelectedVariation,
                    builder: (context, variation, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (widget.product != null)
                                ? ("৳ " +
                                    variation.discountPrice.round().toString())
                                : widget.product != null &&
                                        widget.product.currentPrice != null
                                    ? ("৳ " +
                                        widget.product.currentPrice
                                            .round()
                                            .toString())
                                    : "",
                            style:
                                Theme.of(context).textTheme.headline3.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          SizedBox(width: 10),
                          Visibility(
                            visible: widget.product != null &&
                                (onSelectedVariation.value.discountPrice <
                                    onSelectedVariation.value.regularPrice),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 1.5 * SizeConfig.heightSizeMultiplier,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: widget.product != null &&
                                        widget.product.currentPrice != null &&
                                        widget.product.price != null &&
                                        (widget.product.currentPrice !=
                                            widget.product.price),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 2.56 *
                                            SizeConfig.widthSizeMultiplier,
                                      ),
                                      child: Text(
                                        widget.product != null &&
                                                widget.product.price != null
                                            ? ("৳ " +
                                                onSelectedVariation
                                                    .value.regularPrice
                                                    .round()
                                                    .toString())
                                            : "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Colors.black.withOpacity(.35),
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.strDiscount.isNotEmpty,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 2.56 *
                                            SizeConfig.widthSizeMultiplier,
                                      ),
                                      child: Text(
                                        "-" + widget.strDiscount,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              fontSize: 1.75 *
                                                  SizeConfig.textSizeMultiplier,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Theme.of(context).errorColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.product != null &&
                                        widget.product.vat != null &&
                                        widget.product.vat != 0.0,
                                    child: Container(
                                      color: Theme.of(context).primaryColor,
                                      padding: EdgeInsets.only(
                                        top: .5 *
                                            SizeConfig.heightSizeMultiplier,
                                        bottom: .5 *
                                            SizeConfig.heightSizeMultiplier,
                                        left: 1.79 *
                                            SizeConfig.widthSizeMultiplier,
                                        right: 1.79 *
                                            SizeConfig.widthSizeMultiplier,
                                      ),
                                      margin: EdgeInsets.only(
                                          right: 5.12 *
                                              SizeConfig.widthSizeMultiplier),
                                      child: Text(
                                        widget.product != null &&
                                                widget.product.vat != null &&
                                                widget.product.vat != 0.0
                                            ? (AppLocalization.of(context)
                                                    .getTranslatedValue("vat") +
                                                " " +
                                                widget.product.vat
                                                    .round()
                                                    .toString() +
                                                "%")
                                            : "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 1.75 *
                                                  SizeConfig.textSizeMultiplier,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (currentUser.value.id != null &&
                        currentUser.value.id.isNotEmpty) {
                      if (widget.product.isWishListed) {
                        widget.removeFromWishList();
                      } else {
                        widget.addToWishList();
                      }
                    } else {
                      // _showNotLoggedInDialog(context);
                      Navigator.of(context)
                          .pushNamed(RouteManager.REGISTER_ONE);
                    }
                  },
                  child: Icon(
                    widget.product.isWishListed
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 7 * SizeConfig.imageSizeMultiplier,
                    color: widget.product.isWishListed
                        ? Theme.of(context).primaryColor
                        : Colors.black38,
                  ),
                ),
                SizedBox(
                  width: 2.56 * SizeConfig.widthSizeMultiplier,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    await Share.share(
                        "Check out ${widget.product.name} | ৳${widget.product.currentPrice}! Get it on Sellmart now! \n\n${APIRoute.WEB_URL}/product/${widget.product.slug}");
                  },
                  child: Icon(
                    Icons.share,
                    size: 7 * SizeConfig.imageSizeMultiplier,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 1.5 * SizeConfig.heightSizeMultiplier,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.product != null && widget.product.name != null
                ? widget.product.name
                : "",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 1.875 * SizeConfig.heightSizeMultiplier,
        ),
        Container(
          color: Theme.of(context).hintColor,
          height: .625 * SizeConfig.heightSizeMultiplier,
          width: double.infinity,
        ),
      ],
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
