import '../model/shop.dart';
import 'package:flutter/material.dart';

abstract class ShopContract {

  void onSuccess(List<Shop> shops);
  void onFailure(BuildContext context);
}