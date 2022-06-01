import 'package:flutter/material.dart';

abstract class PolicyContract {

  void onSuccess(String termsConditions, String privacyPolicy, String returnPolicy);
  void onFailed(BuildContext context);
}