import 'discount.dart';

class Coupon {

  String id;
  String code;
  Discount discount;
  String startDate;
  String endDate;
  double discountAmount;

  Coupon({this.id, this.code, this.discount, this.startDate, this.endDate, this.discountAmount});

  Coupon.fromJson(Map<String, dynamic> json) {

    try {
      id = json['_id'];
    }
    catch(error) {}

    try {
      code = json['code'];
    }
    catch(error) {}

    try {
      startDate = json['startDate'];
    }
    catch(error) {}

    try {
      endDate = json['endDate'];
    }
    catch(error) {}

    try {
      discount = Discount.fromJson(json['discount']);
    }
    catch(error) {}
  }
}