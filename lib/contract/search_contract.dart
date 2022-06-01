import '../model/search_data.dart';
import 'package:flutter/material.dart';

abstract class SearchContract {

  void onSuccess(SearchData searchData);
  void onFailure(BuildContext context);
}