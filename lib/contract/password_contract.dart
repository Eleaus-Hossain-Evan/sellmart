import 'package:flutter/material.dart';

abstract class PasswordContract {

  void onSuccess();
  void onFailure(BuildContext context, String message);
}