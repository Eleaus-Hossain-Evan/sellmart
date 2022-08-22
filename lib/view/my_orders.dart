import '../contract/order_contract.dart';
import '../model/order.dart';
import '../route/route_manager.dart';
import '../widget/order_widget.dart';

import '../contract/connectivity_contract.dart';
import '../localization/app_localization.dart';
import '../presenter/data_presenter.dart';
import '../presenter/user_presenter.dart';
import '../utils/size_config.dart';
import '../widget/error_widget.dart';
import '../widget/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sslcommerz_flutter/model/SSLCTransactionInfoModel.dart';

GlobalKey<_MyOrdersState> myOrderKey = GlobalKey();

class MyOrders extends StatefulWidget {
  MyOrders({Key key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    implements Connectivity, OrderContract {
  DataPresenter _presenter;

  OrderContract _contract;
  Connectivity _connectivity;

  List<Order> _orders = List();

  @override
  void initState() {
    _connectivity = this;
    _contract = this;
    _presenter = DataPresenter(_connectivity, orderContract: _contract);

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
                    AppLocalization.of(context).getTranslatedValue("my_orders"),
                    autoImplyLeading: false,
                    onBackPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
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
                      child: ListView.separated(
                        itemCount: _orders.length,
                        padding: EdgeInsets.all(
                            1.875 * SizeConfig.heightSizeMultiplier),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 2.5 * SizeConfig.heightSizeMultiplier,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _orders[index].justOrdered = false;
                              Navigator.of(context).pushNamed(
                                  RouteManager.ORDER_INFO,
                                  arguments: _orders[index]);
                            },
                            child: OrderWidget(_orders[index]),
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

  void reloadPage() {
    if (currentUser.value.id != null && currentUser.value.id.isNotEmpty) {
      _orders = List();

      if (mounted) {
        setState(() {});
      }

      _presenter.getMyOrders(context);
    }
  }

  Future<bool> _onBackPress() {
    Navigator.pop(context);
    return Future(() => false);
  }

  @override
  void dispose() {
    _presenter.hideOverlayLoader();
    super.dispose();
  }

  @override
  void onDisconnected(BuildContext context) {
    if (mounted) {
      _showErrorDialog(context,
          AppLocalization.of(context).getTranslatedValue("not_connected"));
    }
  }

  @override
  void onInactive(BuildContext context) {
    if (mounted) {
      _showErrorDialog(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("inactive_connection"));
    }
  }

  @override
  void onTimeout(BuildContext context) {
    if (mounted) {
      _showErrorDialog(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("connection_time_out"));
    }
  }

  @override
  void failedToGetAllOrders(BuildContext context) {
    if (mounted) {
      _showErrorDialog(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("could_not_load_data"));
    }
  }

  @override
  void onFailedToPlaceOrder(BuildContext context, String message) {}

  @override
  void onOrderPlaced(Order order) {}

  @override
  void showAllOrders(List<Order> orders) {
    orders.sort((a, b) =>
        DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));

    setState(() {
      _orders = orders;
    });
  }

  @override
  void onPaymentStatusChangeFailed(BuildContext context, Order order,
      SSLCTransactionInfoModel transactionInfo) {}

  @override
  void onPaymentStatusSet() {}

  Future<Widget> _showErrorDialog(
      BuildContext mainContext, String subTitle) async {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {
              _presenter.getMyOrders(mainContext);
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
}
