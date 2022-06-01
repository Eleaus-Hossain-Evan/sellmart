import 'package:flutter/material.dart';

abstract class LoginContract {

  void onSuccess();
  void onFailure(BuildContext context, String message);
}