import '../utils/constants.dart';

import '../view/cart.dart';

import '../model/coupon.dart';
import '../model/order.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatefulWidget {
  final Coupon coupon;
  final double subTotal;
  final ValueNotifier<double> coin;

  OrderSummaryWidget(this.coupon, this.subTotal, this.coin);

  @override
  _OrderSummaryWidgetState createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget>
    with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: order,
          builder: (BuildContext context, Order orderData, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 1.875 * SizeConfig.heightSizeMultiplier,
                    right: 1.875 * SizeConfig.heightSizeMultiplier,
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.all(1 * SizeConfig.heightSizeMultiplier),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 2.5 * SizeConfig.heightSizeMultiplier,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: .3 * SizeConfig.heightSizeMultiplier,
                            bottom: .3 * SizeConfig.heightSizeMultiplier,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("product_total"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              Text(
                                "৳" + widget.subTotal.round().toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: .3 * SizeConfig.heightSizeMultiplier,
                            bottom: .3 * SizeConfig.heightSizeMultiplier,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("total_vat"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              Text(
                                "৳" + orderData.vat.round().toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: .3 * SizeConfig.heightSizeMultiplier,
                            bottom: .3 * SizeConfig.heightSizeMultiplier,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("coupon_discount"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              Text(
                                "- ৳" +
                                    widget.coupon.discountAmount
                                        .round()
                                        .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        widget.coin.value > 0
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: .3 * SizeConfig.heightSizeMultiplier,
                                  bottom: .3 * SizeConfig.heightSizeMultiplier,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Coin using',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    Text(
                                      "- ৳" +
                                          widget.coin.value.round().toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                        Padding(
                          padding: EdgeInsets.only(
                            top: .3 * SizeConfig.heightSizeMultiplier,
                            bottom: .3 * SizeConfig.heightSizeMultiplier,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("sub_total"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              Text(
                                "৳" +
                                    (widget.subTotal.round() +
                                            orderData.vat.round() -
                                            widget.coupon.discountAmount
                                                .round())
                                        .round()
                                        .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: .3 * SizeConfig.heightSizeMultiplier,
                            bottom: .3 * SizeConfig.heightSizeMultiplier,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("delivery_charge"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              Text(
                                "৳" + orderData.deliveryFee.round().toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: orderData.paymentOption != null &&
                              orderData.paymentOption.id != null &&
                              orderData.paymentOption.id ==
                                  Constants.ONLINE_PAYMENT &&
                              orderData.sslCharge != null &&
                              orderData.sslCharge.toString().isNotEmpty &&
                              orderData.sslCharge != 0.0,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: .3 * SizeConfig.heightSizeMultiplier,
                              bottom: .3 * SizeConfig.heightSizeMultiplier,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("ssl_service_charge"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Text(
                                  "৳" + orderData.sslCharge.round().toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: .8 * SizeConfig.heightSizeMultiplier,
                            bottom: .8 * SizeConfig.heightSizeMultiplier,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("total"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                "৳" +
                                    (widget.subTotal.round() +
                                            orderData.vat.round() -
                                            widget.coupon.discountAmount
                                                .round() -
                                            widget.coin.value +
                                            orderData.deliveryFee.round() +
                                            (orderData.paymentOption != null &&
                                                    orderData
                                                            .paymentOption.id !=
                                                        null &&
                                                    orderData
                                                            .paymentOption.id ==
                                                        Constants.ONLINE_PAYMENT
                                                ? orderData.sslCharge.round()
                                                : 0.0))
                                        .round()
                                        .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: orderData.advancePayment > 0.0,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: .3 * SizeConfig.heightSizeMultiplier,
                              bottom: .3 * SizeConfig.heightSizeMultiplier,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("advance_payment"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Text(
                                  "৳" +
                                      orderData.advancePayment
                                          .round()
                                          .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: orderData.paymentOption != null &&
                              orderData.paymentOption.id != null &&
                              orderData.paymentOption.id !=
                                  Constants.ONLINE_PAYMENT &&
                              orderData.sslCharge != null &&
                              orderData.sslCharge.toString().isNotEmpty &&
                              orderData.sslCharge != 0.0,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: .3 * SizeConfig.heightSizeMultiplier,
                              bottom: .3 * SizeConfig.heightSizeMultiplier,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("ssl_service_charge"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Text(
                                  "৳" + orderData.sslCharge.round().toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: orderData.advancePayment > 0.0,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: .8 * SizeConfig.heightSizeMultiplier,
                              bottom: .3 * SizeConfig.heightSizeMultiplier,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("checkout_payment"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  "৳" +
                                      (orderData.sslCharge.round() +
                                              orderData.advancePayment.round())
                                          .round()
                                          .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.grey[900],
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: orderData.advancePayment > 0.0,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: .8 * SizeConfig.heightSizeMultiplier,
                              bottom: .3 * SizeConfig.heightSizeMultiplier,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("due"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  "৳" +
                                      ((widget.subTotal.round() +
                                                      orderData.vat.round() -
                                                      widget
                                                          .coupon.discountAmount
                                                          .round() +
                                                      orderData.deliveryFee
                                                          .round())
                                                  .round() -
                                              orderData.advancePayment.round())
                                          .round()
                                          .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.grey[900],
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: .5 * SizeConfig.heightSizeMultiplier,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightSizeMultiplier,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
