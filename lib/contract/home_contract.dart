import '../model/home_data.dart';
import 'package:flutter/material.dart';

abstract class HomeContract {

  void onSuccess(HomeData homeData);
  void onFailure(BuildContext context);
}