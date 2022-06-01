import '../model/brand.dart';
import 'package:flutter/material.dart';

abstract class BrandContract {

  void onSuccess(List<Brand> brands);
  void onFailure(BuildContext context);
}