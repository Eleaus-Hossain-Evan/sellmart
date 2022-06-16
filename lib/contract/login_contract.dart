import 'package:flutter/material.dart';

abstract class LoginContract {
  void onLoginSuccess();
  void onFailure(BuildContext context, String message);
}
