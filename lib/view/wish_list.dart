import '../localization/app_localization.dart';

import '../model/sub_sub_category.dart';

import '../contract/connectivity_contract.dart';
import '../contract/product_contract.dart';
import '../model/brand.dart';
import '../model/category.dart';
import '../model/product.dart';
import '../model/shop.dart';
import '../model/sub_category.dart';
import '../presenter/data_presenter.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../widget/error_widget.dart';
import '../widget/my_app_bar.dart';
import '../widget/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ValueNotifier<List<Product>> wishListProducts = ValueNotifier([]);

class WishList extends StatefulWidget {

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> with ChangeNotifier implements Connectivity, ProductContract {

  DataPresenter _presenter;

  ProductContract _contract;
  Connectivity _connectivity;

  int _totalPage = 0, _currentPage = 0, _totalLength = 0;

  ScrollController _scrollController = ScrollController();

  BuildContext _context;


  @override
  void initState() {

    wishListProducts.value = [];

    _connectivity = this;
    _contract = this;
    _presenter = DataPresenter(_connectivity, productContract: _contract);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _presenter.getProducts(context, Constants.BY_WISH_LIST, "", page: _currentPage + 1);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Builder(
          builder: (BuildContext context) {

            _context = context;

            return SafeArea(
              child: Column(
                children: <Widget>[

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("wish_list"),
                    onBackPress: () {

                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),

                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: SingleChildScrollView(
                        child: ValueListenableBuilder(
                          valueListenable: wishListProducts,
                          builder: (BuildContext context, List<Product> products, _) {

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                ProductGridView(products, false),

                                Visibility(
                                  visible: _currentPage != 0 && _currentPage != _totalPage && products.length < _totalLength,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 2.5 * SizeConfig.heightSizeMultiplier,
                                      bottom: 2.5 * SizeConfig.heightSizeMultiplier,
                                    ),
                                    child: CupertinoActivityIndicator(
                                      radius: 1.875 * SizeConfig.heightSizeMultiplier,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  Future<bool> _onBackPress() {

    Navigator.pop(context);
    return Future(() => false);
  }


  @override
  void dispose() {

    wishListProducts.value = [];
    _presenter.hideOverlayLoader();

    super.dispose();
  }


  @override
  void onDisconnected(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("not_connected"));
    }
  }


  @override
  void onFailure(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("failed_to_get_wish_list"));
    }
  }


  @override
  void onInactive(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("inactive_connection"));
    }
  }


  @override
  void onTimeout(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("connection_time_out"));
    }
  }


  @override
  void productsByBrand(BrandProducts brandProducts) {}


  @override
  void productsByCategory(CategoryProducts categoryProducts) {}


  @override
  void productsByShop(ShopProducts shopProducts) {}


  @override
  void productsBySubCategory(SubCategoryProducts subCategoryProducts) {}


  @override
  void productsBySubSubCategory(SubSubCategoryProducts subSubCategoryProducts) {}


  @override
  void discountedProducts(DiscountedProducts discountedProducts) {

    if(_currentPage == 0) {

      _totalLength = discountedProducts.totalProduct;
      _totalPage = (discountedProducts.totalProduct / discountedProducts.perPageProduct).ceil();
    }

    discountedProducts.products.forEach((product) {

      if(product.variationType == 0 || product.variationType == 1) {

        if(product.variations.length > 0) {

          product.price = product.variations[0].regularPrice;
          product.currentPrice = product.variations[0].discountPrice;
        }
        else {

          product.price = product.price;
          product.currentPrice = product.buyingPrice;
        }
      }
      else {

        if(product.sizeInfos.length > 0) {

          product.price = product.sizeInfos[0].regularPrice;
          product.currentPrice = product.sizeInfos[0].discountPrice;
        }
        else {

          product.price = product.price;
          product.currentPrice = product.buyingPrice;
        }
      }
    });

    wishListProducts.value = wishListProducts.value + discountedProducts.products;

    _currentPage = _currentPage + 1;

    setState(() {});

    wishListProducts.notifyListeners();

    if(_currentPage == 1) {

      _startLazyLoader();
    }
  }


  void _startLazyLoader() {

    _scrollController.addListener(() {

      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {

        if(_currentPage < _totalPage) {

          _presenter.getProducts(_context, Constants.BY_WISH_LIST, "", page: _currentPage + 1);
        }
      }
    });
  }


  Future<Widget> _showErrorDialog(BuildContext mainContext, String subTitle) async {

    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {

              _presenter.getProducts(_context, Constants.BY_WISH_LIST, "", page: _currentPage + 1);
            },
          );
        }
    );
  }
}