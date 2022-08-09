import '../widget/order_issues.dart';
import 'package:sslcommerz_flutter/model/SSLCTransactionInfoModel.dart';

import '../contract/connectivity_contract.dart';
import '../contract/order_contract.dart';
import '../presenter/data_presenter.dart';

import '../model/product.dart';
import '../utils/constants.dart';
import '../utils/api_routes.dart';
import '../utils/my_flush_bar.dart';
import '../widget/current_order_status.dart';
import '../widget/order_state_history.dart';

import '../localization/app_localization.dart';
import '../model/order.dart';
import '../route/route_manager.dart';
import '../utils/my_datetime.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import 'package:flutter/material.dart';

import 'cart.dart';

class OrderInfo extends StatefulWidget {
  final Order order;

  OrderInfo(this.order);

  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo>
    implements Connectivity, OrderContract {
  DataPresenter _presenter;

  Connectivity _connectivity;
  OrderContract _orderContract;

  double _couponDiscount = 0.0;
  double _subTotal = 0.0;

  @override
  void initState() {
    order.value = Order();
    _calculateCouponDiscount();

    _connectivity = this;
    _orderContract = this;

    _presenter = DataPresenter(_connectivity, orderContract: _orderContract);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Builder(
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                  MyAppBar(
                    AppLocalization.of(context)
                        .getTranslatedValue("order_info"),
                    onBackPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(
                          1.25 * SizeConfig.heightSizeMultiplier),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll) {
                          overScroll.disallowGlow();
                          return;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 1.5 * SizeConfig.heightSizeMultiplier,
                              ),

                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        AppLocalization.of(context)
                                            .getTranslatedValue("order_id"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      SizedBox(
                                        width:
                                            2 * SizeConfig.widthSizeMultiplier,
                                      ),
                                      Text(
                                        "#" + widget.order.orderID,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(color: Colors.blue[800]),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    MyDateTime.getDatabaseFormat(
                                        DateTime.parse(widget.order.createdAt)
                                            .add(Duration(hours: 6))),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),

                              Visibility(
                                visible: widget.order.currentState !=
                                    Constants.CANCELLED,
                                child: SizedBox(
                                  height: 3.5 * SizeConfig.heightSizeMultiplier,
                                ),
                              ),

                              Visibility(
                                visible: widget.order.currentState !=
                                    Constants.CANCELLED,
                                child: CurrentOrderStatus(
                                    widget.order.currentState),
                              ),

                              SizedBox(
                                height: 3.5 * SizeConfig.heightSizeMultiplier,
                              ),

                              Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("order_timeline")
                                    .toUpperCase(),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),

                              SizedBox(
                                height: 3.5 * SizeConfig.heightSizeMultiplier,
                              ),

                              OrderStateHistory(widget.order.states),

                              SizedBox(
                                height: 3.5 * SizeConfig.heightSizeMultiplier,
                              ),

                              Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("products"),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),

                              SizedBox(
                                height: 2.5 * SizeConfig.heightSizeMultiplier,
                              ),

                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                primary: false,
                                itemCount: widget.order.products.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 3 * SizeConfig.heightSizeMultiplier,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return _productWidget(
                                      context, widget.order.products[index]);
                                },
                              ),

                              SizedBox(
                                height: 6 * SizeConfig.heightSizeMultiplier,
                              ),

                              OrderIssues(
                                widget.order,
                                onCancelOrder: () async {
                                  Order order = await Navigator.of(context)
                                          .pushNamed(RouteManager.CANCEL_ORDER,
                                              arguments: widget.order.orderID)
                                      as Order;

                                  if (order != null &&
                                      order.currentState ==
                                          Constants.CANCELLED) {
                                    setState(() {
                                      widget.order.currentState =
                                          order.currentState;
                                      widget.order.states = order.states;
                                    });

                                    MyFlushBar.show(
                                        context,
                                        AppLocalization.of(context)
                                            .getTranslatedValue(
                                                "order_is_cancelled"));
                                  }
                                },
                                onRequestRefund: () {
                                  _presenter.withdrawRequest(
                                      context, widget.order.orderID);
                                },
                                requestReturnRefund: () async {
                                  _presenter.requestReturnRefund(
                                      context, widget.order.orderID);
                                },
                              ),

                              Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("order_summary"),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),

                              SizedBox(
                                height: 1.875 * SizeConfig.heightSizeMultiplier,
                              ),

                              _summaryTestWidget(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("product_total"),
                                  _subTotal.truncate()),

                              _summaryTestWidget(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("total_vat"),
                                  widget.order.vat.round()),

                              _summaryTestWidget(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("coupon_discount"),
                                  _couponDiscount.round()),

                              _summaryTestWidget(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("sub_total"),
                                  (_subTotal - _couponDiscount).round()),

                              _summaryTestWidget(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("delivery_charge"),
                                  widget.order.deliveryFee.round()),

                              _summaryTestWidget(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("total"),
                                  widget.order.totalBill.round()),

                              Visibility(
                                visible: widget.order.paymentType ==
                                        Constants.CASH_ON_DELIVERY &&
                                    widget.order.advancePayment == 0.0,
                                child: Column(
                                  children: [
                                    _summaryTestWidget(
                                        AppLocalization.of(context)
                                            .getTranslatedValue("paid_amount"),
                                        widget.order.currentState ==
                                                Constants.DELIVERED
                                            ? widget.order.totalBill.round()
                                            : 0),
                                    _summaryTestWidget(
                                        AppLocalization.of(context)
                                            .getTranslatedValue("due_amount"),
                                        widget.order.currentState ==
                                                Constants.DELIVERED
                                            ? 0
                                            : widget.order.totalBill.round()),
                                  ],
                                ),
                              ),

                              Visibility(
                                visible: widget.order.paymentType ==
                                        Constants.CASH_ON_DELIVERY &&
                                    widget.order.advancePayment > 0.0,
                                child: Column(
                                  children: [
                                    _summaryTestWidget(
                                        AppLocalization.of(context)
                                            .getTranslatedValue("paid_amount"),
                                        widget.order.currentState ==
                                                Constants.DELIVERED
                                            ? widget.order.totalBill.round()
                                            : widget.order
                                                .advancePaymentWithOutSSLCharge
                                                .round()),
                                    _summaryTestWidget(
                                        AppLocalization.of(context)
                                            .getTranslatedValue("due_amount"),
                                        widget.order.currentState ==
                                                Constants.DELIVERED
                                            ? 0
                                            : (widget.order.totalBill.round() -
                                                    widget.order
                                                        .advancePaymentWithOutSSLCharge
                                                        .round())
                                                .round()),
                                  ],
                                ),
                              ),

                              Visibility(
                                visible: widget.order.paymentType ==
                                        Constants.ONLINE_PAYMENT &&
                                    widget.order.advancePayment > 0.0,
                                child: Column(
                                  children: [
                                    _summaryTestWidget(
                                        AppLocalization.of(context)
                                            .getTranslatedValue("paid_amount"),
                                        widget.order.totalBill.round()),
                                    _summaryTestWidget(
                                        AppLocalization.of(context)
                                            .getTranslatedValue("due_amount"),
                                        0),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 5 * SizeConfig.heightSizeMultiplier,
                              ),

                              Text(
                                AppLocalization.of(context)
                                    .getTranslatedValue("billing_address"),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),

                              SizedBox(
                                height: 2.5 * SizeConfig.heightSizeMultiplier,
                              ),

                              _textWidget(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("name"),
                                  widget.order.name),

                              SizedBox(
                                height: 1 * SizeConfig.heightSizeMultiplier,
                              ),

                              _textWidget(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("phone"),
                                  widget.order.phone),

                              SizedBox(
                                height: 1 * SizeConfig.heightSizeMultiplier,
                              ),

                              //_textWidget(AppLocalization.of(context).getTranslatedValue("alt_mobile"), widget.order.alternativePhone),

                              //SizedBox(height: 1 * SizeConfig.heightSizeMultiplier,),

                              _textWidget(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("address"),
                                  widget.order.address.details +
                                      ", " +
                                      widget.order.address.upazila +
                                      ", " +
                                      widget.order.address.district +
                                      ", " +
                                      widget.order.address.division),

                              SizedBox(
                                height: 3.5 * SizeConfig.heightSizeMultiplier,
                              ),
                            ],
                          ),
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
    if (widget.order.justOrdered) {
      Navigator.of(context).pushNamed(RouteManager.BOTTOM_NAV, arguments: 0);
    } else {
      Navigator.pop(context);
    }

    return Future(() => false);
  }

  Widget _productWidget(BuildContext context, Product product) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  height: 8.5 * SizeConfig.heightSizeMultiplier,
                  color: Colors.white,
                  child: Image.network(
                    product.thumbnail ?? (APIRoute.BASE_URL + ""),
                    fit: BoxFit.fill,
                    errorBuilder: (context, url, error) => Icon(
                      Icons.image,
                      size: 9.5 * SizeConfig.heightSizeMultiplier,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 2.56 * SizeConfig.widthSizeMultiplier,
                    right: 2.56 * SizeConfig.widthSizeMultiplier,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 2 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(.75),
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "৳" +
                                product.buyingPrice.truncate().toString() +
                                " x " +
                                product.quantity.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                  fontSize: 2 * SizeConfig.textSizeMultiplier,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(.7),
                                ),
                          ),
                          Text(
                            "৳" +
                                (product.buyingPrice.truncate() *
                                        product.quantity)
                                    .round()
                                    .toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                  fontSize: 2 * SizeConfig.textSizeMultiplier,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(.7),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          //visible: false,
          visible: widget.order.currentState == Constants.DELIVERED,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 1.875 * SizeConfig.heightSizeMultiplier,
              ),
              Row(
                children: List.generate(
                    1000 ~/ 10,
                    (index) => Expanded(
                          child: Container(
                            color: index % 2 == 0
                                ? Colors.transparent
                                : Colors.grey[200],
                            height: .3125 * SizeConfig.heightSizeMultiplier,
                          ),
                        )),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  var result = await Navigator.of(context).pushNamed(
                      RouteManager.WRITE_REVIEW,
                      arguments: product) as String;

                  if (result != null && result.isNotEmpty) {
                    MyFlushBar.show(context, result);
                  }
                },
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.only(
                    top: 1 * SizeConfig.heightSizeMultiplier,
                    bottom: 1 * SizeConfig.heightSizeMultiplier,
                  ),
                  child: Text(
                    AppLocalization.of(context)
                        .getTranslatedValue("write_review"),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _summaryTestWidget(String title, int value) {
    return Padding(
      padding: EdgeInsets.only(
        top: .3 * SizeConfig.heightSizeMultiplier,
        bottom: .5 * SizeConfig.heightSizeMultiplier,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontSize: 2 * SizeConfig.textSizeMultiplier,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w400,
                ),
          ),
          Text(
            "৳" + value.toString(),
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontSize: 2 * SizeConfig.textSizeMultiplier,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _textWidget(String firstText, String secondText) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
          text: firstText + ":  ",
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 1.875 * SizeConfig.textSizeMultiplier,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
          children: <TextSpan>[
            TextSpan(
              text: secondText,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 1.875 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ]),
    );
  }

  void _calculateCouponDiscount() {
    widget.order.products.forEach((product) {
      _subTotal = _subTotal + (product.buyingPrice.round() * product.quantity);
    });

    if (widget.order.promoCode != null && widget.order.promoCode.isNotEmpty) {
      if (widget.order.promoType == Constants.FLAT_DISCOUNT) {
        _couponDiscount = widget.order.promoAmount;
      } else if (widget.order.promoType == Constants.PERCENTAGE_DISCOUNT) {
        _couponDiscount = (_subTotal * widget.order.promoAmount) / 100;
      }
    }

    if (mounted) {
      setState(() {});
    }
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
  void failedToGetAllOrders(BuildContext context) {}

  @override
  void onFailedCancelOrder(BuildContext context, String message) {}

  @override
  void onFailedToPlaceOrder(BuildContext context, String message) {}

  @override
  void onFailedToRequestRefund(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void onOrderCanceled(Order order) {}

  @override
  void onOrderPlaced(Order order) {}

  @override
  void onPaymentStatusChangeFailed(BuildContext context, Order order,
      SSLCTransactionInfoModel transactionInfo) {}

  @override
  void onPaymentStatusSet() {}

  @override
  void onRefundRequested(Order order) {
    setState(() {
      widget.order.moneyWithdrawalState = order.moneyWithdrawalState;
    });
  }

  @override
  void showAllOrders(List<Order> orders) {}

  @override
  void onFailedToRequestReturnRefund(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void onReturnRefundRequested(Order order) {
    if (order != null &&
        order.returnRequestState == Constants.RETURN_REQUESTED) {
      setState(() {
        widget.order.currentState = order.currentState;
        widget.order.states = order.states;
        widget.order.returnRequestState = order.returnRequestState;
      });

      MyFlushBar.show(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("return_refund_requested"));
    }
  }
}
