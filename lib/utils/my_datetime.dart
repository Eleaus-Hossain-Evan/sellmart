import 'package:intl/intl.dart';
import '../main.dart';

class MyDateTime {

  static final DateFormat _formatter = DateFormat('dd-MM-yyyy hh:mm:ss a');
  static final DateFormat _yearMonthDay = DateFormat('yyyy-MM-dd');
  static final DateFormat _transactionIdFormatter = DateFormat('yyyyMMdd');
  static final DateFormat _dateTimeFormatter = DateFormat('d MMMM, y  hh:mm a');
  static final DateFormat _dateFormatter = DateFormat('MMMM d, y');
  static final DateFormat _localeFormatter = DateFormat('dd-MM-yyyy', MyApp.appLocale.languageCode);
  static final DateFormat _timeFormatter = DateFormat('hh:mm a');

  static String getDate(DateTime dateTime) {

    return _formatter.format(dateTime);
  }

  static String getDatabaseFormat(DateTime dateTime) {

    return _yearMonthDay.format(dateTime);
  }

  static String getDateTime(DateTime dateTime) {

    return _dateTimeFormatter.format(dateTime);
  }

  static String getLocaleDate(DateTime dateTime) {

    return _localeFormatter.format(dateTime);
  }

  static String getMonthData(DateTime dateTime) {

    return _dateFormatter.format(dateTime);
  }

  static String getTransactionFormat() {

    return _transactionIdFormatter.format(DateTime.now());
  }

  static String getOrderTime(DateTime dateTime) {

    return _timeFormatter.format(dateTime);
  }

  static String getReviewDate(DateTime dateTime) {

    var suffix = "th";
    var digit = dateTime.day % 10;

    if((digit > 0 && digit < 4) && (dateTime.day < 11 || dateTime.day > 13)) {

      suffix = ["st", "nd", "rd"][digit - 1];
    }

    DateFormat _estimateFormatter = DateFormat("dd'$suffix' LLL, yyyy");

    return _estimateFormatter.format(dateTime);
  }
}