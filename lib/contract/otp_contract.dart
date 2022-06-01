import 'package:flutter/material.dart';

abstract class OTPContract {

  void onOTPSent(String phone);
  void onFailedToSendOTP(BuildContext context, String message);
}