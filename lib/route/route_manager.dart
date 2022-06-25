import 'package:app/model/user.dart';

import '../view/select_delivery_address.dart';

import '../view/order_success.dart';

import '../view/language_page.dart';
import '../view/search.dart';

import '../model/order.dart';
import '../model/product.dart' as modelProduct;
import '../view/about_us.dart';
import '../view/cancel_order.dart';
import '../view/change_password.dart';
import '../view/my_profile.dart';
import '../view/forgot_password.dart';
import '../view/my_address.dart';
import '../view/my_orders.dart';
import '../view/order_info.dart';
import '../view/password_reset_success.dart';
import '../view/reset_password.dart';
import '../view/single_campaign.dart';
import '../view/write_review.dart';

import '../view/all_brand.dart';
import '../view/all_shop.dart';
import '../view/login.dart';
import '../view/product_details.dart';
import '../view/products.dart';
import '../view/register_one.dart';
import '../view/register_two.dart';

import '../view/bottom_nav.dart';
import '../view/splash_screen.dart';
import '../view/cart.dart';
import '../view/wish_list.dart';
import 'package:flutter/material.dart';

class RouteManager {

  static const String SPLASH_SCREEN = "splashScreen";
  static const String BOTTOM_NAV = "bottomNav";
  static const String ALL_BRAND = "allBrand";
  static const String ALL_Shop = "allShop";
  static const String PRODUCTS = "products";
  static const String PRODUCT_DETAILS = "productDetails";
  static const String ORDER_PROCEED = "orderProceed";
  static const String LOGIN = "login";
  static const String REGISTER_ONE = "registerOne";
  static const String REGISTER_TWO = "registerTwo";
  static const String FORGOT_PASSWORD = "forgotPassword";
  static const String RESET_PASSWORD = "resetPassword";
  static const String PASSWORD_RESET_SUCCESS = "passwordResetSuccess";
  static const String MY_PROFILE = "myProfile";
  static const String MY_ADDRESS = "myAddress";
  static const String SELECT_ADDRESS = "selectAddress";
  static const String CHANGE_PASSWORD = "changePassword";
  static const String SINGLE_CAMPAIGN = "singleCampaign";
  static const String ORDER_INFO = "orderInfo";
  static const String MY_ORDERS = "myOrders";
  static const String WRITE_REVIEW = "writeReview";
  static const String ABOUT_US = "aboutUs";
  static const String LANGUAGE = "language";
  static const String SEARCH = "search";
  static const String ADD_ADDRESS = "addAddress";
  static const String ORDER_SUCCESS = "orderSuccss";
  static const String CANCEL_ORDER = "cancelOrder";
  static const String CART = "cart";
  static const String WISH_LIST = "wishList";

  static Route<dynamic> generate(RouteSettings settings) {

    final args = settings.arguments;

    switch(settings.name) {

      case SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case BOTTOM_NAV:
        return MaterialPageRoute(builder: (_) => BottomNav(args as int));

      case ALL_BRAND:
        return MaterialPageRoute(builder: (_) => AllBrand());

      case ALL_Shop:
        return MaterialPageRoute(builder: (_) => AllShop());

      case PRODUCTS:
        return MaterialPageRoute(builder: (_) => Products());

      case PRODUCT_DETAILS:
        return MaterialPageRoute(builder: (_) => ProductDetails(args as String));

      case LOGIN:
        return MaterialPageRoute(builder: (_) => Login());

      case REGISTER_ONE:
        return MaterialPageRoute(builder: (_) => RegisterOne());

      case REGISTER_TWO:
        return MaterialPageRoute(builder: (_) => RegisterTwo(args as User));

      case FORGOT_PASSWORD:
        return MaterialPageRoute(builder: (_) => ForgotPassword());

      case RESET_PASSWORD:
        return MaterialPageRoute(builder: (_) => ResetPassword(args as String));

      case PASSWORD_RESET_SUCCESS:
        return MaterialPageRoute(builder: (_) => PasswordResetSuccessfulPage());

      case MY_PROFILE:
        return MaterialPageRoute(builder: (_) => MyProfile());

      case MY_ADDRESS:
        return MaterialPageRoute(builder: (_) => MyAddress());

      case CHANGE_PASSWORD:
        return MaterialPageRoute(builder: (_) => ChangePassword());

      case SINGLE_CAMPAIGN:
        return MaterialPageRoute(builder: (_) => SingleCampaign(args as String));

      case ORDER_INFO:
        return MaterialPageRoute(builder: (_) => OrderInfo(args as Order));

      case MY_ORDERS:
        return MaterialPageRoute(builder: (_) => MyOrders());

      case WRITE_REVIEW:
        return MaterialPageRoute(builder: (_) => WriteReview(args as modelProduct.Product));

      case ABOUT_US:
        return MaterialPageRoute(builder: (_) => AboutUs());

      case SEARCH:
        return MaterialPageRoute(builder: (_) => Search());

      case LANGUAGE:
        return MaterialPageRoute(builder: (_) => LanguagePage());

      case ORDER_SUCCESS:
        return MaterialPageRoute(builder: (_) => OrderSuccess());

      case SELECT_ADDRESS:
        return MaterialPageRoute(builder: (_) => SelectDeliveryAddress());

      case CANCEL_ORDER:
        return MaterialPageRoute(builder: (_) => CancelOrder(args as String));

      case CART:
        return MaterialPageRoute(builder: (_) => Cart());

      case WISH_LIST:
        return MaterialPageRoute(builder: (_) => WishList());

      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Center(child: Text("Route Error")))));
    }
  }
}