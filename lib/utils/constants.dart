class Constants {

  static const int timeoutSeconds = 20;

  static const String ALL_CUSTOMER = "all-customer";

  static const int FLAT_DISCOUNT = 1;
  static const int PERCENTAGE_DISCOUNT = 2;

  static const String PAYMENT_SUCCESS = "payment_success";
  static const String PAYMENT_CANCELLED = "payment_cancelled";
  static const String PAYMENT_FAILED = "payment_failed";

  static const int HOME = 0;
  static const int CATEGORIES = 1;
  static const int ORDERS = 2;
  static const int CAMPAIGN = 3;
  static const int ACCOUNT = 4;

  static const int ALL_CATEGORY = 1;
  static const int ALL_BRAND = 2;
  static const int ALL_SHOP = 3;
  static const int HOME_CATEGORY = 4;
  static const int ALL_DISCOUNTED = 5;

  static const int TERMS_CONDITIONS = 1;
  static const int PRIVACY_POLICY = 2;
  static const int RETURN_POLICY = 3;

  static const int CASH_ON_DELIVERY = 0;
  static const int ONLINE_PAYMENT = 1;

  static const int INSIDE_DHAKA = 0;
  static const double FEE_INSIDE_DHAKA = 55;
  static const int OUTSIDE_DHAKA = 1;
  static const double FEE_OUTSIDE_DHAKA = 100;

  static const int DISCONNECTED = 1;
  static const int INACTIVE = 2;
  static const int TIMEOUT = 3;
  static const int FAILURE = 4;

  static const int WITHDRAW_NOT_REQUESTED = 0;
  static const int WITHDRAW_REQUESTED = 1;
  static const int WITHDRAW_REQUEST_APPROVED = 2;
  static const int WITHDRAW_REQUEST_CANCELLED = 3;

  static const int RETURN_NOT_REQUESTED = 0;
  static const int RETURN_REQUESTED = 1;
  static const int RETURN_REQUEST_APPROVED = 2;
  static const int RETURN_REQUEST_CANCELLED = 3;

  static const int PENDING = 0;
  static const int CONFIRMED = 1;
  static const int PROCESSING = 2;
  static const int PICKED = 3;
  static const int SHIPPED = 4;
  static const int DELIVERED = 5;
  static const int CANCELLED = 6;
  static const int RETURNED = 7;
  static const int REFUNDED = 8;

  static const int BY_BRAND = 1;
  static const int BY_SHOP = 2;
  static const int BY_CATEGORY = 3;
  static const int BY_SUBCATEGORY = 4;
  static const int BY_SUB_SUBCATEGORY = 5;
  static const int BY_DISCOUNT = 6;
  static const int BY_WISH_LIST = 7;

  static const double MIN_PRICE = 1.0;
  static const double MAX_PRICE = 5000000.0;

  static const String Phone_Already_Used = "Phone number is already use.";
  static const String INVALID_OTP = "Wrong OTP!";
  static const String INCORRECT_PHONE = "Phone number Incorrect";
  static const String INCORRECT_PHONE_OR_PASSWORD = "Incorrect PhoneNumber Or Password!";
  static const String WRONG_PASSWORD = "Password didn't match!";
  static const String INVALID_COUPON = "Promo code is not valid!";
  static const String NUMBER_NOT_FOUND = "Phone number not found!.";
  static const String OLD_PASSWORD_WRONG = "Old password didn't match!.";
  static const String ALREADY_REVIEWED = "You have already reviewed this product!";
  static const String INVALID_REFERRAL_CODE = "Invalid Refer Code!";

  static const int MY_ORDER_MENU = 1;
  static const int ADDRESS_MENU = 2;
  static const int CHANGE_PASSWORD_MENU = 3;
  static const int REFUND_SETTLEMENT_MENU = 4;
  static const int PAYMENT_HISTORY_MENU = 5;
  static const int ABOUT_US_MENU = 6;
  static const int TERMS_CONDITIONS_MENU = 7;
  static const int HELP_SUPPORT_MENU = 8;
  static const int REPORT_ISSUE_MENU = 9;
  static const int LANGUAGE_MENU = 10;
  static const int LOGOUT_MENU = 11;
  static const int LOGIN_MENU = 12;
  static const int PROFILE_MENU = 13;
  static const int WISH_LIST_MENU = 14;
  static const int PRIVACY_POLICY_MENU = 15;

  static const String PRODUCT = "product";
  static const String FOOD = "food";

  static const List<String> ORDER_STATES = ["Pending", "Confirmed", "Processing", "Picked", "Shipped", "Delivered", "Cancelled", "Returned", "Refunded"];
}