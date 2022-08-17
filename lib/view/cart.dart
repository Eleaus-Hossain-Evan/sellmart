import 'package:app/contract/balance_contract.dart';
import 'package:app/model/payment_option.dart';

import '../view/web_view.dart';

import '../contract/connectivity_contract.dart';
import '../contract/coupon_contract.dart';
import '../contract/order_contract.dart';
import '../model/coupon.dart';
import '../model/order.dart';
import '../presenter/data_presenter.dart';
import '../utils/constants.dart';
import '../utils/my_flush_bar.dart';
import '../utils/ssl_commerz_gateway.dart';
import '../widget/checkout_product_list.dart';
import '../widget/delivery_payment_option_widget.dart';
import '../widget/error_widget.dart';
import '../widget/order_referral_coin_widget.dart';
import '../widget/order_coupon_widget.dart';
import '../widget/order_delivery_address_widget.dart';
import '../widget/order_summary_widget.dart';
import 'package:app/view/home.dart';

import '../db/db_helper.dart';
import '../localization/app_localization.dart';
import '../model/cart_item.dart';
import '../route/route_manager.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import '../presenter/user_presenter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bottom_nav.dart';
import 'package:sslcommerz_flutter/model/SSLCTransactionInfoModel.dart';
import 'package:logger/logger.dart';

ValueNotifier<Order> order = ValueNotifier(Order());

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart>
    with ChangeNotifier
    implements Connectivity, OrderContract, CouponContract, BalanceContract {
  DataPresenter _presenter;

  Connectivity _connectivity;
  OrderContract _orderContract;
  CouponContract _couponContract;

  BuildContext _context;

  Coupon _coupon = Coupon(discountAmount: 0.0);

  bool _isChecked = true;
  bool _paymentIncomplete = false;

  SSLCommerzGateway _sslCommerzGateway = SSLCommerzGateway();

  DBHelper _dbHelper = DBHelper();

  double _subTotal = 0.0;

  List<CartItem> _items = List();

  Order _placedOrder;

  ScrollController _scrollController = ScrollController();

  ValueNotifier<double> _usedCoin = ValueNotifier(0.0);

  @override
  void initState() {
    initOrder();

    _getCartItems();

    _connectivity = this;
    _orderContract = this;
    _couponContract = this;

    _presenter = DataPresenter(_connectivity,
        orderContract: _orderContract, couponContract: _couponContract);

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
            _context = context;

            return SafeArea(
              child: Column(
                children: <Widget>[
                  MyAppBar(
                    AppLocalization.of(context).getTranslatedValue("cart"),
                    enableButtons: false,
                    onBackPress: () {
                      _onBackPress();
                    },
                  ),
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: ValueListenableBuilder(
                        valueListenable: numberOfItems,
                        builder: (BuildContext context, int numberOfItem, _) {
                          return numberOfItem > 0
                              ? SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 5.12 *
                                              SizeConfig.widthSizeMultiplier,
                                          right: 5.12 *
                                              SizeConfig.widthSizeMultiplier,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: _items.length.toString() +
                                                    " " +
                                                    (_items.length > 1
                                                        ? AppLocalization.of(
                                                                context)
                                                            .getTranslatedValue(
                                                                "items")
                                                            .toUpperCase()
                                                        : AppLocalization.of(
                                                                context)
                                                            .getTranslatedValue(
                                                                "item")
                                                            .toUpperCase()) +
                                                    " ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .copyWith(
                                                      fontSize: 1.75 *
                                                          SizeConfig
                                                              .textSizeMultiplier,
                                                      color: Colors.black
                                                          .withOpacity(.65),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: AppLocalization.of(
                                                            context)
                                                        .getTranslatedValue(
                                                            "in_the_cart")
                                                        .toUpperCase(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                          fontSize: 1.75 *
                                                              SizeConfig
                                                                  .textSizeMultiplier,
                                                          color: Colors.black
                                                              .withOpacity(.47),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 2.5 *
                                                    SizeConfig
                                                        .heightSizeMultiplier,
                                                bottom: 2.5 *
                                                    SizeConfig
                                                        .heightSizeMultiplier,
                                              ),
                                              child: Text(
                                                AppLocalization.of(context)
                                                    .getTranslatedValue(
                                                        "i_am_done"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .copyWith(
                                                      fontSize: 2.1 *
                                                          SizeConfig
                                                              .textSizeMultiplier,
                                                      color: Colors.black
                                                          .withOpacity(.47),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      CheckoutProductList(
                                        _items,
                                        deleteItem: (int index) {
                                          _removeItem(index, context);
                                        },
                                        onQuantityChange: () {
                                          _calculateSSLCharge();
                                          _calculateSummary();
                                        },
                                      ),
                                      OrderSummaryWidget(
                                          _coupon, _subTotal, _usedCoin),
                                      OrderDeliveryAddressWidget(),
                                      OrderCouponWidget(
                                        _coupon,
                                        onCouponSubmit: (String code) {
                                          _presenter.verifyCoupon(
                                              context, code);
                                        },
                                        onCouponRemoval: () {
                                          _removeCoupon();
                                        },
                                      ),
                                      OrderReferralCoinWidget(
                                        // _coupon,
                                        onCoinSubmit: (double coin) {
                                          setState(() {
                                            _usedCoin.value = coin;
                                          });
                                          _presenter.cusmoterBalancReduce(
                                              context, coin);
                                        },
                                        onCoinRemoval: () {},
                                      ),
                                      DeliveryPaymentOptionWidget(
                                        onSelected: () {
                                          _calculateSSLCharge();
                                          _calculateSummary();
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 1.25 *
                                              SizeConfig.heightSizeMultiplier,
                                          bottom: 1.25 *
                                              SizeConfig.heightSizeMultiplier,
                                          left: 2.56 *
                                              SizeConfig.widthSizeMultiplier,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Checkbox(
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              checkColor: Colors.white,
                                              value: _isChecked,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isChecked = !_isChecked;
                                                });
                                              },
                                            ),
                                            Text(
                                              AppLocalization.of(context)
                                                  .getTranslatedValue(
                                                      "i_agree_to"),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                            Flexible(
                                              child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => WebView(
                                                              AppLocalization.of(
                                                                      context)
                                                                  .getTranslatedValue(
                                                                      "terms_condition"),
                                                              Constants
                                                                  .TERMS_CONDITIONS)));
                                                },
                                                child: Text(
                                                  AppLocalization.of(context)
                                                      .getTranslatedValue(
                                                          "terms_condition"),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 2.5 *
                                            SizeConfig.heightSizeMultiplier,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          _validate();
                                        },
                                        child: Container(
                                          height: 7 *
                                              SizeConfig.heightSizeMultiplier,
                                          color: Theme.of(context).accentColor,
                                          child: Center(
                                            child: Text(
                                              AppLocalization.of(context)
                                                  .getTranslatedValue(
                                                      "confirm_order")
                                                  .toUpperCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            5 * SizeConfig.heightSizeMultiplier,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ],
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    AppLocalization.of(context)
                                        .getTranslatedValue(
                                            "no_products_in_cart"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                );
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

  @override
  void dispose() {
    _presenter.hideOverlayLoader();
    super.dispose();
  }

  Future<bool> _onBackPress() {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pop(context);

    return Future(() => false);
  }

  Future<void> _getCartItems() async {
    _items = await _dbHelper.getCartItems();

    if (mounted) {
      setState(() {});
    }

    _calculateSummary();
  }

  void _calculateSSLCharge() {
    order.value.advancePayment = 0.0;
    order.value.sslCharge = 0.0;

    if (order.value.paymentOption == null ||
        order.value.paymentOption.id == Constants.CASH_ON_DELIVERY) {
      for (int i = 0; i < _items.length; i++) {
        if (_items[i].product.advancePayment != null &&
            _items[i].product.advancePayment > 0.0) {
          order.value.advancePayment = order.value.advancePayment +
              ((_items[i].product.currentPrice *
                      _items[i].product.advancePayment) /
                  100);
        }
      }

      order.value.advancePayment =
          order.value.advancePayment.truncateToDouble();

      if (order.value.advancePayment > 0.0) {
        order.value.sslCharge =
            ((order.value.advancePayment * 3) / 100).roundToDouble();
      } else {
        order.value.sslCharge = 0.0;
      }
    } else if (order.value.paymentOption.id == Constants.ONLINE_PAYMENT) {
      order.value.sslCharge = (((_subTotal.round() +
                          order.value.vat.round() -
                          _coupon.discountAmount.round() -
                          _usedCoin.value.roundToDouble() +
                          order.value.deliveryFee.round())
                      .round() *
                  3) /
              100)
          .roundToDouble();
    }

    order.notifyListeners();
    setState(() {});
  }

  void _removeCoupon() {
    setState(() {
      _coupon = Coupon(discountAmount: 0.0);
    });
  }

  void _calculateSummary() {
    _subTotal = 0.0;
    order.value.vat = 0.0;

    _items.forEach((item) {
      if (item.isChecked) {
        _subTotal = _subTotal +
            (item.product.currentPrice.round() * item.product.quantity);
        order.value.vat = order.value.vat +
            ((item.product.currentPrice.round() * item.product.quantity)
                        .round() *
                    item.product.vat.round()) /
                100;
      }
    });

    order.notifyListeners();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _removeItem(int index, BuildContext context) async {
    int result = await _dbHelper.deleteProduct(_items[index].position);

    if (result == 0) {
      _showToast(
          AppLocalization.of(context).getTranslatedValue("failed_to_remove") +
              " " +
              AppLocalization.of(context).getTranslatedValue("item"),
          Toast.LENGTH_LONG);
    } else {
      _items.removeAt(index);
    }

    numberOfItems.value = await _dbHelper.getProductCount();
    numberOfItems.notifyListeners();

    setState(() {});

    _calculateSummary();
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

  void _validate() {
    if (_items.length > 0) {
      if (order.value.address == null) {
        _showToast(
            AppLocalization.of(context)
                .getTranslatedValue("select_delivery_address"),
            Toast.LENGTH_SHORT);
      } else {
        if (order.value.paymentOption == null) {
          _showToast(
              AppLocalization.of(context)
                  .getTranslatedValue("select_payment_option"),
              Toast.LENGTH_SHORT);
        } else {
          if (!_isChecked) {
            _showToast(
                AppLocalization.of(context)
                    .getTranslatedValue("you_must_agree"),
                Toast.LENGTH_SHORT);
          } else {
            order.value.coupon = _coupon;

            if (_paymentIncomplete) {
              onOrderPlaced(_placedOrder);
            } else {
              _presenter.placeOrder(_context, _items);
            }
          }
        }
      }
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
  void onFailedToPlaceOrder(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void onOrderPlaced(Order placedOrder) {
    _placedOrder = placedOrder;

    if (order.value.paymentOption.id == Constants.CASH_ON_DELIVERY) {
      if (order.value.advancePayment > 0.0) {
        _paymentIncomplete = true;
        _getPaymentConfirmation(
            (order.value.advancePayment.round() + order.value.sslCharge.round())
                .roundToDouble());
      } else {
        _onOrderSuccess();
      }
    } else if (order.value.paymentOption.id == Constants.ONLINE_PAYMENT) {
      _paymentIncomplete = true;
      _getPaymentConfirmation((_subTotal.round() +
              order.value.vat.round() -
              _coupon.discountAmount.round() -
              _usedCoin.value +
              order.value.deliveryFee.round() +
              order.value.sslCharge.round())
          .roundToDouble());
    }
  }

  @override
  void failedToGetAllOrders(BuildContext context) {}

  @override
  void showAllOrders(List<Order> orders) {}

  @override
  void onInvalid(BuildContext context, String message) {
    _removeCoupon();

    _calculateSSLCharge();
    _calculateSummary();

    MyFlushBar.show(context, message);
  }

  @override
  void onValid(Coupon coupon) {
    if (coupon != null &&
        coupon.discount != null &&
        coupon.discount.type != null) {
      if (coupon.discount.type == Constants.FLAT_DISCOUNT) {
        coupon.discountAmount = coupon.discount.amount;
      } else if (coupon.discount.type == Constants.PERCENTAGE_DISCOUNT) {
        coupon.discountAmount = (_subTotal * coupon.discount.amount) / 100;
      }
    }

    if (coupon.discountAmount > _subTotal) {
      onInvalid(
          _context,
          AppLocalization.of(context)
              .getTranslatedValue("discount_can_not_be_greater"));
    } else {
      setState(() {
        _coupon = coupon;
      });

      _calculateSSLCharge();
      _calculateSummary();
    }
  }

  @override
  void onPaymentStatusChangeFailed(BuildContext context, Order order,
      SSLCTransactionInfoModel transactionInfo) {
    _showErrorDialog(
        AppLocalization.of(context)
            .getTranslatedValue("failed_to_set_payment_status"),
        order,
        transactionInfo);
  }

  @override
  void onPaymentStatusSet() {
    _onOrderSuccess();
  }

  Future<void> _getPaymentConfirmation(double amount) async {
    SSLCTransactionInfoModel transactionInfo =
        await _sslCommerzGateway.pay(amount);

    if (transactionInfo != null && transactionInfo.status == "VALID") {
      _presenter.setPaymentSuccessful(_context, _placedOrder, transactionInfo);
    } else {
      _showPaymentErrorDialog(AppLocalization.of(context)
          .getTranslatedValue("failed_to_complete_payment"));
    }
  }

  Future<void> _onOrderSuccess() async {
    await _dbHelper.deleteAllProduct();

    numberOfItems.value = await _dbHelper.getProductCount();
    numberOfItems.notifyListeners();

    order.value = Order();

    Navigator.pop(context);
    Navigator.of(context).pushNamed(RouteManager.ORDER_SUCCESS);
  }

  Future<Widget> _showPaymentErrorDialog(String subTitle) async {
    return showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {
              onOrderPlaced(_placedOrder);
            },
          );
        });
  }

  Future<Widget> _showErrorDialog(String subTitle, Order placedOrder,
      SSLCTransactionInfoModel transactionInfo) async {
    return showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {
              _presenter.setPaymentSuccessful(
                  _context, placedOrder, transactionInfo);
            },
          );
        });
  }

  @override
  void onFailedCancelOrder(BuildContext context, String message) {}

  @override
  void onOrderCanceled(Order order) {}

  @override
  void onFailedToRequestRefund(BuildContext context, String message) {}

  @override
  void onRefundRequested(Order order) {}

  @override
  void onFailedToRequestReturnRefund(BuildContext context, String message) {}

  @override
  void onReturnRefundRequested(Order order) {}

  @override
  void onFailureBalanceReduced(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void onSuccessBalanceReduced() {
    MyFlushBar.show(context, "Successfully added...");
  }

  initOrder() {
    final address = currentUser.value.addresses.list[1];
    double fee = 0;
    int type = 0;

    if (address.district.toLowerCase() == "dhaka" ||
        address.district.toLowerCase() == "ঢাকা") {
      fee = info.value.deliveryChargeInsideDhaka ?? 90;
      type = Constants.INSIDE_DHAKA;
      debugPrint('order.value.deliveryType: ${order.value.deliveryType}');
    } else {
      fee = info.value.deliveryChargeOutsideDhaka ?? 150;
      type = Constants.OUTSIDE_DHAKA;
      debugPrint('order.value.deliveryType: ${order.value.deliveryType}');
    }
    order.value = Order(
        vat: 0.0,
        sslCharge: 0.0,
        advancePayment: 0.0,
        address: currentUser.value.addresses.list[1],
        deliveryType: (currentUser.value.addresses.list[1].district
                        .toLowerCase() ==
                    "dhaka" ||
                currentUser.value.addresses.list[1].district.toLowerCase() ==
                    "ঢাকা")
            ? Constants.INSIDE_DHAKA
            : Constants.OUTSIDE_DHAKA,
        deliveryFee: (currentUser.value.addresses.list[1].district
                        .toLowerCase() ==
                    "dhaka" ||
                currentUser.value.addresses.list[1].district.toLowerCase() ==
                    "ঢাকা")
            ? info.value.deliveryChargeInsideDhaka ?? 90
            : info.value.deliveryChargeOutsideDhaka ?? 150,
        paymentOption: PaymentOption.init());
  }
}
