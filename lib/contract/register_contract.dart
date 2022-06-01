import 'package:flutter/material.dart';

abstract class RegisterContract {

  void onSuccess();
  void onFailure(BuildContext context, String message);
}