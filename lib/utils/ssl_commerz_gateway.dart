import 'package:flutter/services.dart';
import 'package:sslcommerz_flutter/model/SSLCSdkType.dart';
import 'package:sslcommerz_flutter/model/SSLCTransactionInfoModel.dart';
import 'package:sslcommerz_flutter/model/SSLCommerzInitialization.dart';
import 'package:sslcommerz_flutter/model/SSLCurrencyType.dart';
import 'package:sslcommerz_flutter/sslcommerz.dart';

import '../utils/constants.dart';
import '../model/ssl_credential.dart';

import 'dart:convert';
import 'dart:math';

class SSLCommerzGateway {

  SSLCredential credential;

  Future<SSLCTransactionInfoModel> pay(double amount) async {

    SSLCTransactionInfoModel transactionInfo;

    await _getCredentials();

    String transactionID = await _getTransactionID();
    transactionID = "LBD-" + transactionID;

    Sslcommerz sslCommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
            currency: SSLCurrencyType.BDT,
            product_category: Constants.PRODUCT,
            sdkType: SSLCSdkType.LIVE,
            store_id: credential.storeID,
            store_passwd: credential.storePassword,
            //store_id: "imsaj5fe2c15455841",
            //store_passwd: "imsaj5fe2c15455841@ssl",
            //store_id: "loves61a369f507328",
            //store_passwd: "loves61a369f507328@ssl",
            total_amount: amount,
            tran_id: transactionID));

    var result = await sslCommerz.payNow();

    if(result is PlatformException) {

      print("The response is: " + result.message + " code: " + result.code);
      return transactionInfo;
    }
    else {

      transactionInfo = result;

      print("Response is ----------------------------------- " + transactionInfo.toJson().toString());

      return transactionInfo;
    }
  }


  Future<void> _getCredentials() async {

    String jsonStringValues = await rootBundle.loadString("assets/json/credentials.json");

    var jsonData = json.decode(jsonStringValues);

    credential = SSLCredential.fromJson(jsonData);
  }


  Future<String> _getTransactionID() async {

    var rng = Random();
    String value = "";

    for(int i=0; i<12; i++) {

      value = value + rng.nextInt(10).toString();
    }

    return value;
  }
}