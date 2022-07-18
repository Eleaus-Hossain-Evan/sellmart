import 'dart:convert';
import 'dart:io';
import 'package:sslcommerz_flutter/model/SSLCTransactionInfoModel.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import '../view/cart.dart';
import '../contract/campaign_contract.dart';
import '../contract/coupon_contract.dart';
import '../contract/location_contract.dart';
import '../contract/order_contract.dart';
import '../contract/review_contract.dart';
import '../localization/app_localization.dart';
import '../model/campaign.dart';
import '../model/cart_item.dart';
import '../model/coupon.dart';
import '../model/district.dart';
import '../model/division.dart';
import '../model/order.dart';
import '../model/review.dart';
import '../model/upazilla.dart';
import '../model/address.dart';
import '../model/user.dart';
import '../utils/shared_preference.dart';
import '../contract/brand_contract.dart';
import '../contract/category_contract.dart';
import '../contract/home_contract.dart';
import '../contract/product_contract.dart';
import '../contract/product_detail_contract.dart';
import '../contract/search_contract.dart';
import '../contract/shop_contract.dart';
import '../contract/policy_contract.dart';
import '../contract/balance_contract.dart';
import '../model/brand.dart';
import '../model/category.dart';
import '../model/home_data.dart';
import '../model/product.dart';
import '../model/search_data.dart';
import '../model/shop.dart';
import '../model/sub_category.dart';
import '../model/sub_sub_category.dart';
import '../utils/constants.dart';

import '../utils/my_overlay_loader.dart';
import '../utils/api_routes.dart';
import '../utils/custom_log.dart';
import '../utils/custom_trace.dart';
import '../contract/connectivity_contract.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart' as con;

import 'user_presenter.dart';

class DataPresenter with ChangeNotifier {
  Connectivity _connectivity;
  HomeContract _homeContract;
  CategoryContract _categoryContract;
  BrandContract _brandContract;
  ShopContract _shopContract;
  ProductContract _productContract;
  ProductDetailContract _productDetailContract;
  SearchContract _searchContract;
  CouponContract _couponContract;
  OrderContract _orderContract;
  LocationContract _locationContract;
  CampaignContract _campaignContract;
  ReviewContract _reviewContract;
  PolicyContract _policyContract;
  BalanceContract _balanceContract;

  MySharedPreference _sharedPreference = MySharedPreference();

  AddressCheckOptions _options = AddressCheckOptions(InternetAddress("8.8.8.8"),
      port: 53, timeout: Duration(seconds: 2));

  MyOverlayLoader _myOverlayLoader = MyOverlayLoader();

  DataPresenter(Connectivity connectivity,
      {HomeContract homeContract,
      CategoryContract categoryContract,
      BrandContract brandContract,
      ShopContract shopContract,
      ProductContract productContract,
      ProductDetailContract productDetailContract,
      SearchContract searchContract,
      CouponContract couponContract,
      OrderContract orderContract,
      LocationContract locationContract,
      CampaignContract campaignContract,
      ReviewContract reviewContract,
      PolicyContract policyContract,
      BalanceContract balanceContract}) {
    this._connectivity = connectivity;

    if (homeContract != null) {
      this._homeContract = homeContract;
    }

    if (categoryContract != null) {
      this._categoryContract = categoryContract;
    }

    if (brandContract != null) {
      this._brandContract = brandContract;
    }

    if (shopContract != null) {
      this._shopContract = shopContract;
    }

    if (productContract != null) {
      this._productContract = productContract;
    }

    if (productDetailContract != null) {
      this._productDetailContract = productDetailContract;
    }

    if (searchContract != null) {
      this._searchContract = searchContract;
    }

    if (couponContract != null) {
      this._couponContract = couponContract;
    }

    if (orderContract != null) {
      this._orderContract = orderContract;
    }

    if (locationContract != null) {
      this._locationContract = locationContract;
    }

    if (campaignContract != null) {
      this._campaignContract = campaignContract;
    }

    if (reviewContract != null) {
      this._reviewContract = reviewContract;
    }

    if (policyContract != null) {
      this._policyContract = policyContract;
    }
    if (balanceContract != null) {
      this._balanceContract = balanceContract;
    }
  }

  Future<void> hideOverlayLoader() async {
    try {
      if (_myOverlayLoader != null && _myOverlayLoader.loader != null) {
        _myOverlayLoader.loader.remove();
      }
    } catch (error) {}
  }

  void getHomeData(BuildContext context) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoader(context);

            var client = http.Client();

            client.get(Uri.encodeFull(APIRoute.HOME),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Home",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  HomeData homeData = HomeData.fromJson(jsonData['data']);
                  _homeContract.onSuccess(homeData);
                } else {
                  _homeContract.onFailure(context);
                }
              } else {
                _homeContract.onFailure(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _homeContract.onFailure(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getAllCategory(BuildContext context) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoader(context);

            var client = http.Client();

            client.get(Uri.encodeFull(APIRoute.ALL_CATEGORY),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "All Category",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Categories categories = Categories.fromJson(jsonData['data']);
                  _categoryContract.onSuccess(categories.list);
                } else {
                  _categoryContract.onFailure(context);
                }
              } else {
                _categoryContract.onFailure(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _categoryContract.onFailure(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getAllBrand(BuildContext context) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoader(context);

            var client = http.Client();

            client.get(Uri.encodeFull(APIRoute.ALL_BRAND),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "All Brand",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Brands brands = Brands.fromJson(jsonData['data']);
                  _brandContract.onSuccess(brands.list);
                } else {
                  _brandContract.onFailure(context);
                }
              } else {
                _brandContract.onFailure(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _brandContract.onFailure(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getAllShop(BuildContext context) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoader(context);

            var client = http.Client();

            client.get(Uri.encodeFull(APIRoute.ALL_SHOP),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "All Shop",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Shops shops = Shops.fromJson(jsonData['data']);
                  _shopContract.onSuccess(shops.list);
                } else {
                  _shopContract.onFailure(context);
                }
              } else {
                _shopContract.onFailure(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _shopContract.onFailure(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getProducts(BuildContext context, int typeBy, String slug,
      {int page = 1}) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            if (page == 1) {
              _myOverlayLoader.customLoader(context);
            }

            var client = http.Client();
            String url = "";

            switch (typeBy) {
              case Constants.BY_CATEGORY:
                url = APIRoute.PRODUCT_BY_CATEGORY +
                    slug +
                    "?page=" +
                    page.toString() +
                    "&resultsPerPage=30";
                break;

              case Constants.BY_SUBCATEGORY:
                url = APIRoute.PRODUCT_BY_SUB_CATEGORY +
                    slug +
                    "?page=" +
                    page.toString() +
                    "&resultsPerPage=30";
                break;

              case Constants.BY_SUB_SUBCATEGORY:
                url = APIRoute.PRODUCT_BY_SUB_SUB_CATEGORY +
                    slug +
                    "?page=" +
                    page.toString() +
                    "&resultsPerPage=30";
                break;

              case Constants.BY_BRAND:
                url = APIRoute.PRODUCT_BY_BRAND +
                    slug +
                    "?page=" +
                    page.toString() +
                    "&resultsPerPage=30";
                break;

              case Constants.BY_SHOP:
                url = APIRoute.PRODUCT_BY_SHOP +
                    slug +
                    "?page=" +
                    page.toString() +
                    "&resultsPerPage=30";
                break;

              case Constants.BY_DISCOUNT:
                url = APIRoute.ALL_DISCOUNTED +
                    "?page=" +
                    page.toString() +
                    "&resultsPerPage=30";
                break;

              case Constants.BY_WISH_LIST:
                url = APIRoute.ALL_WISH_LIST +
                    currentUser.value.id +
                    "?page=" +
                    page.toString();
                break;
            }

            client.get(Uri.encodeFull(url),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Products",
                  message: response.body);

              var jsonData = json.decode(response.body);

              if (page == 1) {
                _myOverlayLoader.dismissDialog(context);
              }

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  switch (typeBy) {
                    case Constants.BY_CATEGORY:
                      CategoryProducts categoryProducts =
                          CategoryProducts.fromJson(jsonData['data']);
                      _productContract.productsByCategory(categoryProducts);
                      break;

                    case Constants.BY_SUBCATEGORY:
                      SubCategoryProducts subCategoryProducts =
                          SubCategoryProducts.fromJson(jsonData['data']);
                      _productContract
                          .productsBySubCategory(subCategoryProducts);
                      break;

                    case Constants.BY_SUB_SUBCATEGORY:
                      SubSubCategoryProducts subSubCategoryProducts =
                          SubSubCategoryProducts.fromJson(jsonData['data']);
                      _productContract
                          .productsBySubSubCategory(subSubCategoryProducts);
                      break;

                    case Constants.BY_BRAND:
                      BrandProducts brandProducts =
                          BrandProducts.fromJson(jsonData['data']);
                      _productContract.productsByBrand(brandProducts);
                      break;

                    case Constants.BY_SHOP:
                      ShopProducts shopProducts =
                          ShopProducts.fromJson(jsonData['data']);
                      _productContract.productsByShop(shopProducts);
                      break;

                    case Constants.BY_DISCOUNT:
                      DiscountedProducts discountedProducts =
                          DiscountedProducts.fromJson(jsonData['data']);
                      _productContract.discountedProducts(discountedProducts);
                      break;

                    case Constants.BY_WISH_LIST:
                      DiscountedProducts discountedProducts =
                          DiscountedProducts.fromJson(jsonData['data']);
                      _productContract.discountedProducts(discountedProducts);
                      break;
                  }
                } else {
                  _productContract.onFailure(context);
                }
              } else {
                _productContract.onFailure(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              if (page == 1) {
                _myOverlayLoader.dismissDialog(context);
              }

              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              if (page == 1) {
                _myOverlayLoader.dismissDialog(context);
              }

              _productContract.onFailure(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getProductDetails(BuildContext context, String productSlug,
      {String campaignSlug}) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoader(context);

            var client = http.Client();

            String url;

            if (campaignSlug != null && campaignSlug.isNotEmpty) {
              url = APIRoute.PRODUCT_DETAILS + productSlug + "/" + campaignSlug;
            } else {
              url = APIRoute.PRODUCT_DETAILS + productSlug;
            }

            client.get(Uri.encodeFull(url),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Product Details",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Product product = Product.fromJson(jsonData['data']);
                  Products similarProducts =
                      Products.fromJson(jsonData['similerProducts']);

                  _productDetailContract.onSuccess(
                      product, similarProducts.list);
                } else {
                  _productDetailContract.onFailure(context);
                }
              } else {
                _productDetailContract.onFailure(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _productDetailContract.onFailure(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void addToWishList(BuildContext context, String productID) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            var client = http.Client();

            Map<String, dynamic> data = {
              'cusId': currentUser.value.id,
              'prodId': productID
            };

            client
                .post(
              Uri.encodeFull(APIRoute.ADD_TO_WISH_LIST),
              headers: {"Accept": "application/json"},
              body: data,
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Add To Wishlist",
                  message: response.body);

              var jsonData = json.decode(response.body);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  List<String> wishList = [];

                  jsonData['data']['wishList'].forEach((productID) {
                    wishList.add(productID);
                  });

                  _setWishList(wishList);
                  _productDetailContract.onAddedToWishList(context);
                } else {
                  _productDetailContract.onFailedToAddOrRemovedWishList(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("failed_to_add_in_wishlist"));
                }
              } else {
                _productDetailContract.onFailedToAddOrRemovedWishList(
                    context,
                    AppLocalization.of(context)
                        .getTranslatedValue("failed_to_add_in_wishlist"));
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);
              _productDetailContract.onFailedToAddOrRemovedWishList(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_add_in_wishlist"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void removeFromWishList(BuildContext context, String productID) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            var client = http.Client();

            Map<String, dynamic> data = {
              'cusId': currentUser.value.id,
              'prodId': productID
            };

            client
                .post(
              Uri.encodeFull(APIRoute.REMOVE_FROM_WISH_LIST),
              headers: {"Accept": "application/json"},
              body: data,
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Remove From Wishlist",
                  message: response.body);

              var jsonData = json.decode(response.body);

              if (response.statusCode == 200 ||
                  response.statusCode == 201 ||
                  response.statusCode == 202) {
                if (jsonData['success']) {
                  List<String> wishList = [];

                  jsonData['data']['wishList'].forEach((productID) {
                    wishList.add(productID);
                  });

                  _setWishList(wishList);
                  _productDetailContract.onRemovedFromWishList(context);
                } else {
                  _productDetailContract.onFailedToAddOrRemovedWishList(
                      context,
                      AppLocalization.of(context).getTranslatedValue(
                          "failed_to_remove_from_wishlist"));
                }
              } else {
                _productDetailContract.onFailedToAddOrRemovedWishList(
                    context,
                    AppLocalization.of(context)
                        .getTranslatedValue("failed_to_remove_from_wishlist"));
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);
              _productDetailContract.onFailedToAddOrRemovedWishList(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_remove_from_wishlist"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void search(BuildContext context, String pattern) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            var client = http.Client();

            client.get(Uri.encodeFull(APIRoute.SEARCH + pattern),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Search",
                  message: response.body);

              var jsonData = json.decode(response.body);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  SearchData searchData = SearchData.fromJson(jsonData['data']);
                  debugPrint(
                      'searchData: ${searchData.toString()} - ${searchData.products.list.length},${searchData.categories.list.length},${searchData.shops.list.length},${searchData.brands.list.length}');

                  _searchContract.onSuccess(searchData);
                } else {
                  _searchContract.onFailure(context);
                }
              } else {
                _searchContract.onFailure(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);
              _searchContract.onFailure(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void verifyCoupon(BuildContext context, String couponCode) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            client.get(Uri.encodeFull(APIRoute.VERIFY_COUPON + couponCode),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Coupon Code",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Coupon coupon = Coupon.fromJson(jsonData['data']);

                  if (DateTime.parse(coupon.startDate)
                          .isBefore(DateTime.now()) &&
                      DateTime.parse(coupon.endDate).isAfter(DateTime.now())) {
                    _couponContract.onValid(coupon);
                  } else {
                    _couponContract.onInvalid(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("invalid_coupon"));
                  }
                } else {
                  _couponContract.onInvalid(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("invalid_coupon"));
                }
              } else {
                if (jsonData['message'] == Constants.INVALID_COUPON) {
                  _couponContract.onInvalid(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("invalid_coupon"));
                } else {
                  _couponContract.onInvalid(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("invalid_coupon"));
                }
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _couponContract.onInvalid(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("invalid_coupon"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void cusmoterBalancReduce(BuildContext context, double balance) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);
            Map<String, dynamic> data = {"balance": "$balance"};

            var client = http.Client();

            client
                .post(
              Uri.encodeFull(
                  APIRoute.BALANCE_REDUCE + "${currentUser.value.id}"),
              headers: {"Accept": "application/json"},
              body: data,
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Balance Reduce",
                  message:
                      response.body + " " + response.statusCode.toString());

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _balanceContract.onSuccessBalanceReduced();
                } else {
                  _balanceContract.onFailureBalanceReduced(
                      context, jsonData['message']);
                }
              } else if (response.statusCode == 400) {
                _balanceContract.onFailureBalanceReduced(
                    context, jsonData['message']);
              } else {
                _balanceContract.onFailureBalanceReduced(
                    context, jsonData['message']);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              debugPrint(error.toString());

              _myOverlayLoader.dismissDialog(context);
              _balanceContract.onFailureBalanceReduced(
                  context, "Something went wrong");
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  Future<void> placeOrder(BuildContext context, List<CartItem> items) async {
    User user = await _sharedPreference.getCurrentUser();

    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            List<Map<String, dynamic>> products = [];

            double totalGetTk = 0;

            items.forEach((item) {
              if (item != null && item.isChecked) {
                Map<String, dynamic> map = Map();

                map['_id'] = item.product.id;
                map['name'] = item.product.name;
                map['image'] =
                    item.product.thumbnail.split(APIRoute.BASE_URL)[1];
                map['price'] = item.product.price.round();
                map['buyingPrice'] = item.product.currentPrice.round();
                map['variationType'] = item.product.variationType;

                if (item.product.variationType == 0 ||
                    item.product.variationType == 1) {
                  map['variationOne'] =
                      item.product.selectedVariation.value1 ?? "";
                  map['variationTwo'] =
                      item.product.selectedVariation.value2 ?? "";
                } else if (item.product.variationType == 2) {
                  map['variationOne'] = item.product.selectedSizeItem ?? "";
                  map['variationTwo'] = "";
                }

                map['quantity'] = item.product.quantity;
                map['advancePayment'] = item.product.advancePayment;

                totalGetTk = totalGetTk + item.product.advancePayment;

                products.add(map);
              }
            });

            List<Map<String, dynamic>> addresses = [
              {
                'division': order.value.address.division,
                'district': order.value.address.district,
                'upazila': order.value.address.upazila,
                'details': order.value.address.details,
              }
            ];

            Map<String, dynamic> customerData = {
              '_id': user.id,
              'name': order.value.address.name,
              'address': addresses,
            };

            Map<String, dynamic> orderData = {
              'products': products,
              'customer': customerData,
              'totalGetTk': totalGetTk,
              'phone': order.value.address.phone,
              'alternativePhone': order.value.alternativePhone ?? "",
              'paymentType': order.value.paymentOption.id,
              'deliveryType': order.value.deliveryType,
            };

            if (order.value.coupon != null &&
                order.value.coupon.code != null &&
                order.value.coupon.code.isNotEmpty) {
              orderData['promo'] = order.value.coupon.code;
            }

            print(jsonEncode(orderData));

            client
                .post(
              Uri.encodeFull(APIRoute.CREATE_ORDER),
              headers: {
                "Authorization": currentUser.value.token,
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
              body: json.encode(orderData),
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Order Create",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Order order = Order.fromJson(jsonData['data']);
                  _orderContract.onOrderPlaced(order);
                } else {
                  _orderContract.onFailedToPlaceOrder(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("failed_to_place_order"));
                }
              } else {
                _orderContract.onFailedToPlaceOrder(
                    context,
                    AppLocalization.of(context)
                        .getTranslatedValue("failed_to_place_order"));
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _orderContract.onFailedToPlaceOrder(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_place_order"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  Future<void> setPaymentSuccessful(BuildContext context, Order order,
      SSLCTransactionInfoModel transactionInfo) async {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            print(transactionInfo.toJson());

            Map<String, dynamic> data = {
              'orderId': order.orderID,
              'transaction': transactionInfo.toJson()
            };

            var client = http.Client();

            client
                .post(
              Uri.encodeFull(APIRoute.PAYMENT_SUCCESS_ACKNOWLEDGE),
              headers: {
                "Authorization": "Bearer " + currentUser.value.token,
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
              body: json.encode(data),
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Payment Success Acknowledge",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _orderContract.onPaymentStatusSet();
                } else {
                  _orderContract.onPaymentStatusChangeFailed(
                      context, order, transactionInfo);
                }
              } else {
                _orderContract.onPaymentStatusChangeFailed(
                    context, order, transactionInfo);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _orderContract.onPaymentStatusChangeFailed(
                  context, order, transactionInfo);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getLocations(BuildContext context) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoader(context);

            var client = http.Client();

            client.get(Uri.encodeFull(APIRoute.ALL_LOCATION),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "All Location",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Divisions divisions =
                      Divisions.fromJson(jsonData['data']['divisions']);
                  Districts districts =
                      Districts.fromJson(jsonData['data']['districts']);
                  Upazilas upazilas =
                      Upazilas.fromJson(jsonData['data']['upazilas']);

                  _locationContract.onLocationsFetched(
                      divisions.list, districts.list, upazilas.list);
                } else {
                  _locationContract.onFailedToGetLocations(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("failed_to_get_data"),
                      Constants.FAILURE);
                }
              } else {
                _locationContract.onFailedToGetLocations(
                    context,
                    AppLocalization.of(context)
                        .getTranslatedValue("failed_to_get_data"),
                    Constants.FAILURE);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _locationContract.onFailedToGetLocations(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_get_data"),
                  Constants.TIMEOUT);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _locationContract.onFailedToGetLocations(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_get_data"),
                  Constants.FAILURE);
            });
          } else {
            _locationContract.onFailedToGetLocations(
                context,
                AppLocalization.of(context)
                    .getTranslatedValue("failed_to_get_data"),
                Constants.INACTIVE);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getAllCampaign(BuildContext context) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoader(context);

            var client = http.Client();

            client.get(Uri.encodeFull(APIRoute.ALL_CAMPAIGN),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "All Campaign",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Campaigns campaigns = Campaigns.fromJson(jsonData['data']);
                  _campaignContract.onAllCampaignOfferFound(campaigns.list);
                } else {
                  _campaignContract.onFailedToGetCampaignOffers(context);
                }
              } else {
                _campaignContract.onFailedToGetCampaignOffers(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _campaignContract.onFailedToGetCampaignOffers(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getCampaignProducts(BuildContext context, String campaignSlug) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoader(context);

            var client = http.Client();

            client.get(
                Uri.encodeFull(APIRoute.PRODUCTS_BY_CAMPAIGN + campaignSlug),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Campaign Products",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Campaign campaign = Campaign.fromJson(jsonData['data']);
                  _campaignContract.onCampaignDataFound(campaign);
                } else {
                  _campaignContract.onFailedToGetCampaignData(context);
                }
              } else {
                _campaignContract.onFailedToGetCampaignData(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _campaignContract.onFailedToGetCampaignData(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getMyOrders(BuildContext context) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoader(context);

            var client = http.Client();

            client.get(
                Uri.encodeFull(APIRoute.MY_ORDERS + currentUser.value.id),
                headers: {
                  "Authorization": currentUser.value.token,
                  "Accept": "application/json"
                }).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "My Orders",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Orders orders = Orders.fromJson(jsonData['data']);
                  _orderContract.showAllOrders(orders.list);
                } else {
                  _orderContract.failedToGetAllOrders(context);
                }
              } else {
                _orderContract.failedToGetAllOrders(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _orderContract.failedToGetAllOrders(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void submitReview(BuildContext context, String productID, Review review) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            List<Map<String, dynamic>> productReview = [];

            Map<String, dynamic> reviewData = {
              'userId': currentUser.value.id,
              'rating': review.rating,
              'comment': review.comment
            };

            if (review.base64Images.length > 0) {
              reviewData['image'] = review.base64Images;
            }

            productReview.add(reviewData);

            Map<String, dynamic> data = {
              'productId': productID,
              'productReview': productReview
            };

            print(jsonEncode(data));

            client
                .post(
              Uri.encodeFull(APIRoute.POST_REVIEW),
              headers: {
                "Authorization": currentUser.value.token,
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
              body: jsonEncode(data),
            )
                .then((response) async {
              print(response.statusCode);

              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Submit Review",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _reviewContract.onReviewSubmitted(context);
                }
              } else {
                if (jsonData['message'] == Constants.ALREADY_REVIEWED) {
                  _reviewContract.onFailedToSubmitReview(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("already_reviewed"));
                } else {
                  _reviewContract.onFailedToSubmitReview(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("failed_to_submit_review"));
                }
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _reviewContract.onFailedToSubmitReview(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_submit_review"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void cancelOrder(BuildContext context, String orderID, String message) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            Map<String, dynamic> data = {'cancelOrderReason': message};

            client
                .post(
              Uri.encodeFull(
                  APIRoute.CANCEL_ORDER + currentUser.value.id + "/" + orderID),
              headers: {
                "Authorization": currentUser.value.token,
                "Accept": "application/json"
              },
              body: data,
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Order Cancel",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Order order = Order.fromJson(jsonData['data']);
                  _orderContract.onOrderCanceled(order);
                }
              } else {
                _orderContract.onFailedCancelOrder(
                    context,
                    AppLocalization.of(context)
                        .getTranslatedValue("failed_to_cancel_order"));
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _orderContract.onFailedCancelOrder(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_cancel_order"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getProductReviews(BuildContext context, String productID) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            var client = http.Client();

            client.get(Uri.encodeFull(APIRoute.PRODUCT_REVIEWS + productID),
                headers: {"Accept": "application/json"}).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Product Reviews",
                  message: response.body);

              var jsonData = json.decode(response.body);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Reviews reviews = Reviews.fromJson(jsonData['data']);
                  _reviewContract.showAllReview(reviews.list);
                } else {
                  _reviewContract.failedToGetReviews(context);
                }
              } else {
                _reviewContract.failedToGetReviews(context);
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);
              _reviewContract.failedToGetReviews(context);
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void withdrawRequest(BuildContext context, String orderID) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            client.get(
              Uri.encodeFull(APIRoute.WITHDRAW_REQUEST + orderID),
              headers: {"Accept": "application/json"},
            ).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Withdraw Request",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Order order = Order.fromJson(jsonData['data']);
                  _orderContract.onRefundRequested(order);
                }
              } else {
                _orderContract.onFailedToRequestRefund(
                    context,
                    AppLocalization.of(context)
                        .getTranslatedValue("failed_to_refund_requested"));
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _orderContract.onFailedToRequestRefund(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_refund_requested"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void requestReturnRefund(BuildContext context, String orderID) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            client.get(
              Uri.encodeFull(APIRoute.RETURN_REFUND + orderID),
              headers: {
                "Authorization": currentUser.value.token,
                "Accept": "application/json"
              },
            ).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Return-Refund Request",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  Order order = Order.fromJson(jsonData['data']);
                  _orderContract.onReturnRefundRequested(order);
                }
              } else {
                _orderContract.onFailedToRequestReturnRefund(
                    context,
                    AppLocalization.of(context).getTranslatedValue(
                        "failed_to_return_refund_requested"));
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _orderContract.onFailedToRequestReturnRefund(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_return_refund_requested"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void getPolicies(BuildContext context) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        _myOverlayLoader.customLoader(context);

        var client = http.Client();

        client.get(Uri.encodeFull(APIRoute.POLICIES),
            headers: {"Accept": "application/json"}).then((response) async {
          CustomLogger.debug(
              trace: CustomTrace(StackTrace.current),
              tag: "Policies",
              message: response.body);

          var jsonData = json.decode(response.body);

          _myOverlayLoader.dismissDialog(context);

          if (response.statusCode == 200 || response.statusCode == 201) {
            if (jsonData['success']) {
              _policyContract.onSuccess(
                  jsonData['data']['termsAndCondition'],
                  jsonData['data']['privacyPolicy'],
                  jsonData['data']['refundPolicy']);
            } else {
              _policyContract.onFailed(context);
            }
          } else {
            _policyContract.onFailed(context);
          }
        }).timeout(Duration(seconds: Constants.timeoutSeconds), onTimeout: () {
          client.close();

          _myOverlayLoader.dismissDialog(context);
          _connectivity.onTimeout(context);
        }).catchError((error) {
          print(error);

          _myOverlayLoader.dismissDialog(context);
          _policyContract.onFailed(context);
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void _setWishList(List<String> wishList) {
    currentUser.value.addresses.list.insert(0, Address());

    currentUser.value.wishList = wishList;
    currentUser.notifyListeners();

    _sharedPreference.setCurrentUser(currentUser.value);
  }
}
