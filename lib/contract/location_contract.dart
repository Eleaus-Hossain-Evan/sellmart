import '../model/district.dart';
import '../model/division.dart';
import '../model/upazilla.dart';
import 'package:flutter/material.dart';

abstract class LocationContract {

  void onLocationsFetched(List<Division> divisions, List<District> districts, List<Upazila> upazilas);
  void onFailedToGetLocations(BuildContext context, String message, int errorType);
}