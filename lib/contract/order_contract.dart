import '../model/order.dart';
import 'package:flutter/material.dart';
import 'package:sslcommerz_flutter/model/SSLCTransactionInfoModel.dart';

abstract class OrderContract {

  void onOrderPlaced(Order order);
  void onFailedToPlaceOrder(BuildContext context, String message);
  void showAllOrders(List<Order> orders);
  void failedToGetAllOrders(BuildContext context);
  void onPaymentStatusSet();
  void onPaymentStatusChangeFailed(BuildContext context, Order order, SSLCTransactionInfoModel transactionInfo);
  void onOrderCanceled(Order order);
  void onFailedCancelOrder(BuildContext context, String message);
  void onRefundRequested(Order order);
  void onFailedToRequestRefund(BuildContext context, String message);
  void onReturnRefundRequested(Order order);
  void onFailedToRequestReturnRefund(BuildContext context, String message);
}