import '../model/coupon.dart';
import 'package:flutter/material.dart';

abstract class CouponContract {

  void onValid(Coupon coupon);
  void onInvalid(BuildContext context, String message);
}