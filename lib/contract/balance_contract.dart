import 'package:flutter/material.dart';

abstract class BalanceContract {
  void onSuccessBalanceReduced();
  void onFailureBalanceReduced(BuildContext context, String message);
}
