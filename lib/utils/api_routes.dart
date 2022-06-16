class APIRoute {
  static const String WEB_URL = "https://sellmart.com.bd";
  static const String BASE_URL = "https://api.sellmart.com.bd/";
  //static const String BASE_URL = "http://192.168.5.248:7011/";
  static const String API_V1 = BASE_URL + "api/v1/";

  static const String HOME = API_V1 + "home";
  static const String ALL_CATEGORY = API_V1 + "category/all";
  static const String ALL_BRAND = API_V1 + "brand/all";
  static const String ALL_SHOP = API_V1 + "home/get/shops";
  static const String PRODUCT_BY_CATEGORY = API_V1 + "product/category/";
  static const String PRODUCT_BY_SUB_CATEGORY = API_V1 + "product/subcategory/";
  static const String PRODUCT_BY_SUB_SUB_CATEGORY =
      API_V1 + "product/subsubcategory/";
  static const String PRODUCT_BY_BRAND = API_V1 + "product/brand/";
  static const String PRODUCT_BY_SHOP = API_V1 + "product/shop/";
  static const String ALL_DISCOUNTED = API_V1 + "product/all-discount";
  static const String PRODUCT_DETAILS = API_V1 + "product/view/";
  static const String SEARCH = API_V1 + "product/search/";
  static const String SEND_SIGNUP_OTP = API_V1 + "customer/sms";
  static const String SIGNUP = API_V1 + "customer/otp";
  static const String SIGNIN = API_V1 + "customer/signin";
  static const String VERIFY_COUPON = API_V1 + "promo/verify/";
  static const String BALANCE_REDUCE = API_V1 + "customer/balance/reduce/";
  static const String CREATE_ORDER = API_V1 + "order/create";
  static const String FORGOT_PASSWORD = API_V1 + "customer/forgot-password";
  static const String RESET_PASSWORD = API_V1 + "customer/forgot-password/otp";
  static const String UPDATE_PROFILE_IMAGE = API_V1 + "customer/update/image/";
  static const String CUSTOMER_UPDATE = API_V1 + "customer/update/";
  static const String ALL_LOCATION = API_V1 + "location/all";
  static const String ADDRESS_ADD = API_V1 + "customer/address/create/";
  static const String ADDRESS_UPDATE = API_V1 + "customer/address-update/";
  static const String ADDRESS_DELETE = API_V1 + "customer/address-delete/";
  static const String CHANGE_PASSWORD = API_V1 + "customer/password/update/";
  static const String ALL_CAMPAIGN = API_V1 + "campaign/all";
  static const String PRODUCTS_BY_CAMPAIGN = API_V1 + "campaign/";
  static const String MY_ORDERS = API_V1 + "order/view/customer/";
  static const String POST_REVIEW = API_V1 + "review/create";
  static const String PAYMENT_SUCCESS_ACKNOWLEDGE =
      API_V1 + "order/mobile/ssl-payment-success";
  static const String CANCEL_ORDER = API_V1 + "order/customer/order-cancel/";
  static const String WITHDRAW_REQUEST =
      API_V1 + "order/refund/money-withdrawal/customer-request/";
  static const String RETURN_REFUND =
      API_V1 + "refund/return-refund/customer-request/";
  static const String UPDATE_DEVICE_TOKEN =
      API_V1 + "customer/device-token/create/";
  static const String ADD_TO_WISH_LIST = API_V1 + "product/wish-create";
  static const String REMOVE_FROM_WISH_LIST = API_V1 + "product/wish-remove";
  static const String ALL_WISH_LIST =
      API_V1 + "product/wish-list/customer-product/";
  static const String POLICIES = API_V1 + "admin/terms/privacy/about/view";
  static const String PRODUCT_REVIEWS = API_V1 + "review/view/";
}
