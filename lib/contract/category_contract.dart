import '../model/category.dart';
import 'package:flutter/material.dart';

abstract class CategoryContract {

  void onSuccess(List<Category> categories);
  void onFailure(BuildContext context);
}