import 'package:sslcommerz_flutter/model/SSLCTransactionInfoModel.dart';

import '../utils/my_flush_bar.dart';
import '../widget/my_button.dart';

import '../localization/app_localization.dart';
import '../model/order.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import '../presenter/data_presenter.dart';
import '../contract/connectivity_contract.dart';
import '../contract/order_contract.dart';
import 'package:flutter/material.dart';

class CancelOrder extends StatefulWidget {

  final String orderID;

  CancelOrder(this.orderID);

  @override
  _CancelOrderState createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> implements Connectivity, OrderContract {

  DataPresenter _presenter;

  Connectivity _connectivity;
  OrderContract _orderContract;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {

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
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("cancel_order"),
                    onBackPress: () {

                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),

                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
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

                            SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),

                            Padding(
                              padding: EdgeInsets.only(
                                left: 3.84 * SizeConfig.widthSizeMultiplier,
                                right: 3.84 * SizeConfig.widthSizeMultiplier,
                              ),
                              child: Text(AppLocalization.of(context).getTranslatedValue("why_cancel_order"),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),

                            SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),

                            Padding(
                              padding: EdgeInsets.only(
                                left: 3.84 * SizeConfig.widthSizeMultiplier,
                                right: 3.84 * SizeConfig.widthSizeMultiplier,
                              ),
                              child: TextField(
                                controller: _controller,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.done,
                                maxLines: null,
                                minLines: 10,
                                style: TextStyle(
                                  fontSize: 2.1 * SizeConfig.textSizeMultiplier,
                                  fontWeight: FontWeight.w400,
                                ),
                                onSubmitted: (string) {

                                  FocusScope.of(context).unfocus();
                                },
                                decoration: InputDecoration(
                                  hintText: AppLocalization.of(context).getTranslatedValue("cancel_reason"),
                                  hintStyle: TextStyle(
                                    fontSize: 2.1 * SizeConfig.textSizeMultiplier,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(.35),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(color: Colors.black26, width: .4 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  contentPadding: EdgeInsets.all(1.5 * SizeConfig.heightSizeMultiplier),
                                ),
                              ),
                            ),

                            SizedBox(height: 6.25 * SizeConfig.heightSizeMultiplier,),

                            MyButton(AppLocalization.of(context).getTranslatedValue("submit").toUpperCase(),
                              marginLeft: 3.84,
                              marginRight: 3.84,
                              onPressed: () {

                                FocusScope.of(context).unfocus();
                                _validate(context);
                              },
                            ),
                          ],
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

    Navigator.pop(context);
    return Future(() => false);
  }


  void _validate(BuildContext context) {

    if(_controller.text.isEmpty) {

      MyFlushBar.show(context, AppLocalization.of(context).getTranslatedValue("enter_cancel_reason"));
    }
    else {

      _presenter.cancelOrder(context, widget.orderID, _controller.text);
    }
  }


  @override
  void onDisconnected(BuildContext context) {

    MyFlushBar.show(context, AppLocalization.of(context).getTranslatedValue("not_connected"));
  }


  @override
  void onInactive(BuildContext context) {

    MyFlushBar.show(context, AppLocalization.of(context).getTranslatedValue("inactive_connection"));
  }


  @override
  void onTimeout(BuildContext context) {

    MyFlushBar.show(context, AppLocalization.of(context).getTranslatedValue("connection_time_out"));
  }


  @override
  void failedToGetAllOrders(BuildContext context) {}


  @override
  void onFailedToPlaceOrder(BuildContext context, String message) {}


  @override
  void onOrderPlaced(Order order) {}


  @override
  void onPaymentStatusChangeFailed(BuildContext context, Order order, SSLCTransactionInfoModel transactionInfo) {}


  @override
  void onPaymentStatusSet() {}


  @override
  void showAllOrders(List<Order> orders) {}


  @override
  void onFailedCancelOrder(BuildContext context, String message) {

    MyFlushBar.show(context, message);
  }


  @override
  void onOrderCanceled(Order order) {

    Navigator.pop(context, order);
  }


  @override
  void onFailedToRequestRefund(BuildContext context, String message) {}


  @override
  void onRefundRequested(Order order) {}


  @override
  void onFailedToRequestReturnRefund(BuildContext context, String message) {}


  @override
  void onReturnRefundRequested(Order order) {}
}