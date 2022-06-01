import 'package:flutter/material.dart';

abstract class ProfileContract {

  void onProfileUpdated(BuildContext context, String message);
  void onFailed(BuildContext context, String message);
  void onAddressAdded(BuildContext context);
  void onAddressUpdated(BuildContext context);
  void onAddressDeleted(BuildContext context, int position);
}