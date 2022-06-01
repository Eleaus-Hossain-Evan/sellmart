import '../utils/api_routes.dart';

import 'address.dart';
import 'coupon.dart';
import 'order_state.dart';
import 'payment_option.dart';
import 'product.dart';

class Order {

  String id;
  String userID;
  String name;
  String phone;
  String alternativePhone;
  Address address;
  double deliveryFee;
  PaymentOption paymentOption;
  Coupon coupon;
  int deliveryType;
  int paymentType;
  double vat;
  double sslCharge;
  double advancePayment;
  double advancePaymentWithOutSSLCharge;
  int currentState;
  bool isOnline;
  int paymentStatus;
  int sellerConfirmation;
  bool status;
  bool cancelOrder;
  bool refundOrder;
  List<Product> products;
  double totalBill;
  String orderID;
  String invoice;
  String createdAt;
  String updatedAt;
  bool justOrdered;
  String promoCode;
  int promoType;
  double promoAmount;
  List<OrderState> states;
  int moneyWithdrawalState;
  int returnRequestState;

  Order({this.id, this.userID, this.name, this.phone, this.alternativePhone,
    this.address, this.deliveryFee, this.paymentOption, this.coupon,
    this.deliveryType, this.paymentType, this.vat, this.currentState, this.isOnline,
    this.paymentStatus, this.sellerConfirmation, this.status,
    this.cancelOrder, this.refundOrder, this.products, this.totalBill,
    this.orderID, this.invoice, this.createdAt, this.updatedAt, this.justOrdered,
    this.promoType, this.promoAmount, this.promoCode, this.sslCharge, this.states,
    this.advancePayment, this.advancePaymentWithOutSSLCharge, this.moneyWithdrawalState});

  Order.fromJson(Map<String, dynamic> json) {

    try {
      id = json['_id'];
    }
    catch(error) {}

    try {
      userID = json['customer']['_id'];
    }
    catch(error) {}

    try {
      name = json['customer']['name'];
    }
    catch(error) {}

    try {
      address = json['customer']['address'] == null ? Address() : Address.fromJson(json['customer']['address']);
    }
    catch(error) {}

    try {
      deliveryFee = double.parse(json['deliveryCharge'].toString());
    }
    catch(error) {}

    try {
      vat = double.parse(json['vat'].toString());
    }
    catch(error) {}

    try {
      currentState = int.parse(json['state'].toString());
    }
    catch(error) {}

    try {
      isOnline = json['isOnline'];
    }
    catch(error) {}

    try {
      deliveryType = int.parse(json['deliveryType'].toString());
    }
    catch(error) {}

    try {
      paymentType = int.parse(json['paymentType'].toString());
    }
    catch(error) {}

    try {
      paymentStatus = int.parse(json['paymentStatus'].toString());
    }
    catch(error) {}

    try {
      sellerConfirmation = int.parse(json['sellerConfirmation'].toString());
    }
    catch(error) {}

    try {
      status = json['status'];
    }
    catch(error) {}

    try {
      promoCode = json['promo']['code'];
    }
    catch(error) {}

    try {
      promoType = json['promo']['type'];
    }
    catch(error) {

      try {
        promoType = int.parse(json['promo']['type']);
      }
      catch(error) {}
    }

    try {
      promoAmount = double.parse(json['promo']['amount'].toString());
    }
    catch(error) {}

    try {
      cancelOrder = json['cancelOrder'];
    }
    catch(error) {}

    try {
      refundOrder = json['refundOrder'];
    }
    catch(error) {}

    try {
      totalBill = double.parse(json['totalBill'].toString());
    }
    catch(error) {}

    try {
      advancePayment = double.parse(json['advancePayment'].toString());
    }
    catch(error) {}

    try {
      advancePaymentWithOutSSLCharge = double.parse(json['advancedPaymentWithoutSslCharge'].toString());
    }
    catch(error) {}

    try {
      phone = json['phone'];
    }
    catch(error) {}

    try {
      alternativePhone = json['alterNativePhone'];
    }
    catch(error) {}

    try {
      orderID = json['orderId'];
    }
    catch(error) {}

    try {
      invoice = APIRoute.BASE_URL + json['invoice'];
    }
    catch(error) {}

    try {
      createdAt = json['createdAt'];
    }
    catch(error) {}

    try {
      updatedAt = json['updatedAt'];
    }
    catch(error) {}

    try {

      products = List();

      json['products'].forEach((product) {

        products.add(Product.fromJson(product));
      });
    }
    catch(error) {

      products = List();
    }

    try {

      states = List();

      json['allOrderStatus'].forEach((state) {

        states.add(OrderState.fromJson(state));
      });
    }
    catch(error) {

      states = List();
    }

    try {
      moneyWithdrawalState = int.parse(json['moneyWithdrawal'].toString());
    }
    catch(error) {}

    try {
      returnRequestState = int.parse(json['refundRequest'].toString());
    }
    catch(error) {}
  }
}


class Orders {

  List<Order> list;

  Orders({this.list});

  Orders.fromJson(dynamic data) {

    list = List();

    if(data != null) {

      data.forEach((order) {

        list.add(Order.fromJson(order));
      });
    }
  }
}