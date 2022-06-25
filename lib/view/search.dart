import 'package:app/model/category.dart';
import 'package:app/view/categories.dart';
import 'package:logger/logger.dart';

import '../utils/my_flush_bar.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';

import '../contract/connectivity_contract.dart';
import '../contract/search_contract.dart';
import '../localization/app_localization.dart';
import '../model/brand.dart';
import '../model/product.dart';
import '../model/search_data.dart';
import '../model/shop.dart';
import '../presenter/data_presenter.dart';
import '../utils/constants.dart';
import '../widget/search_data_widget.dart';
import '../widget/search_filter_option.dart';
import '../widget/search_widget.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search>
    implements SearchContract, Connectivity {
  DataPresenter _presenter;

  Connectivity _connectivity;
  SearchContract _contract;

  int _typeValue = 0, _sortValue = 0;
  double _minPrice = Constants.MIN_PRICE, _maxPrice = Constants.MAX_PRICE;

  SearchData _searchData;

  List<Product> _products = List();
  List<Category> _categories = List();
  List<Brand> _brands = List();
  List<Shop> _shops = List();

  @override
  void initState() {
    _connectivity = this;
    _contract = this;
    _presenter = DataPresenter(_connectivity, searchContract: _contract);

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
            Logger().i('build - - _categories: $_categories');
            return SafeArea(
              child: Column(
                children: <Widget>[
                  MyAppBar(
                    AppLocalization.of(context).getTranslatedValue("search"),
                    onBackPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),
                  SearchWidget(
                    onChanged: (String input) {
                      if (input.length > 0) {
                        _presenter.search(context, input);
                      }
                    },
                  ),
                  SearchFilterOption(
                    _typeValue,
                    _sortValue,
                    _minPrice,
                    _maxPrice,
                    onTypeSelected: (int value) {
                      setState(() {
                        _typeValue = value;
                      });
                    },
                    onSortSelected: (int value) {
                      setState(() {
                        _sortValue = value;
                      });

                      _applyFilter();
                    },
                    onPriceSelected: (double min, double max) {
                      setState(() {
                        _minPrice = min;
                        _maxPrice = max;
                      });

                      _applyFilter();
                    },
                  ),
                  Expanded(
                    child: SearchDataWidget(
                      typeValue: _typeValue,
                      products: _products,
                      categories: _categories,
                      brands: _brands,
                      shops: _shops,
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
    _presenter.hideOverlayLoader();
    super.dispose();
  }

  @override
  void onDisconnected(BuildContext context) {
    _showSnackMessage(context,
        AppLocalization.of(context).getTranslatedValue("not_connected"));
  }

  @override
  void onFailure(BuildContext context) {
    _showSnackMessage(context,
        AppLocalization.of(context).getTranslatedValue("failed_to_get_data"));
  }

  @override
  void onInactive(BuildContext context) {
    _showSnackMessage(context,
        AppLocalization.of(context).getTranslatedValue("inactive_connection"));
  }

  @override
  void onSuccess(SearchData searchData) {
    searchData.products.list.forEach((product) {
      if (product.variationType == 0 || product.variationType == 1) {
        if (product.variations.length > 0) {
          product.price = product.variations[0].regularPrice;
          product.currentPrice = product.variations[0].discountPrice;
        } else {
          product.price = product.price;
          product.currentPrice = product.buyingPrice;
        }
      } else {
        if (product.sizeInfos.length > 0) {
          product.price = product.sizeInfos[0].regularPrice;
          product.currentPrice = product.sizeInfos[0].discountPrice;
        } else {
          product.price = product.price;
          product.currentPrice = product.buyingPrice;
        }
      }
    });

    _searchData = searchData;
    Logger().wtf("On success-_searchData=> ${_searchData.toString()}");
    _applyFilter();
  }

  @override
  void onTimeout(BuildContext context) {
    _showSnackMessage(context,
        AppLocalization.of(context).getTranslatedValue("connection_time_out"));
  }

  void _showSnackMessage(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  void _applyFilter() {
    _products.clear();

    List<Product> filterList = List();
    filterList.addAll(_searchData.products.list);

    if (_sortValue != 0) {
      filterList.sort((a, b) => a.currentPrice.compareTo(b.currentPrice));

      if (_sortValue == 2) {
        filterList = List.from(filterList.reversed);
      }
    }

    filterList.forEach((product) {
      if (product != null &&
          product.currentPrice >= _minPrice &&
          product.currentPrice <= _maxPrice) {
        _products.add(product);
      }
    });

    _categories = _searchData.categories.list;
    Logger().i('_categories: $_categories');
    Logger().i('_searchData.categories.list;: ${_searchData.categories.list}');
    _brands = _searchData.brands.list;
    _shops = _searchData.shops.list;

    setState(() {});
  }
}
