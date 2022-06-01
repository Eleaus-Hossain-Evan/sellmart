import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

ValueNotifier<bool> isConnected = ValueNotifier(true);
ValueNotifier<bool> isActive = ValueNotifier(true);

class MyConnectivityChecker with ChangeNotifier {

  DataConnectionChecker _connectionChecker = DataConnectionChecker();

  StreamSubscription<DataConnectionStatus> _connectionStatus;

  MyConnectivityChecker() {

    _connectionChecker.checkInterval = const Duration(milliseconds: 500);

    _connectionStatus = _connectionChecker.onStatusChange.listen((status) {

      switch(status) {

        case DataConnectionStatus.connected:
          isConnected.value = true;
          isConnected.notifyListeners();
          checkInternetConnection();
          break;

        case DataConnectionStatus.disconnected:
          isConnected.value = false;
          isConnected.notifyListeners();
          break;
      }
    });
  }

  void removeStatusListener() {

    _connectionStatus.cancel();
  }

  Future<void> checkInternetConnection() async {

    String address = "google.com";

    assert(address != null || address != '');

    try {

      final result = await InternetAddress.lookup(address);

      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        isActive.value = true;
        isActive.notifyListeners();
      }
      else {

        isActive.value = false;
        isActive.notifyListeners();
      }
    }
    on SocketException catch (_) {

      isActive.value = false;
      isActive.notifyListeners();
    }
  }
}