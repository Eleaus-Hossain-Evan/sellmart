import '../localization/app_localization.dart';

import '../model/sub_sub_category.dart';

import '../contract/connectivity_contract.dart';
import '../contract/product_contract.dart';
import '../model/brand.dart';
import '../model/category.dart';
import '../model/product.dart';
import '../model/shop.dart';
import '../model/sub_category.dart';
import '../model/filter_options.dart';
import '../presenter/data_presenter.dart';
import '../resources/images.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../widget/error_widget.dart';
import '../widget/my_app_bar.dart';
import '../widget/product_filter.dart';
import '../widget/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Products extends StatefulWidget {

  final Category category;
  final SubCategory subCategory;
  final SubSubCategory subSubCategory;
  final Brand brand;
  final Shop shop;
  final bool showDiscountedProduct;
  final String discountTitle;

  Products({this.category, this.subCategory, this.brand, this.shop, this.subSubCategory, this.showDiscountedProduct, this.discountTitle});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> implements Connectivity, ProductContract {

  DataPresenter _presenter;

  ProductContract _contract;
  Connectivity _connectivity;

  String _appBarTitle = "";

  bool _isLoaded = false;

  int _totalPage = 0, _currentPage = 0, _totalLength = 0;

  ScrollController _scrollController = ScrollController();

  BuildContext _context;

  final _key = GlobalKey<ProductFilterState>();

  List<Product> _originalList = [];
  List<Product> _products = [];

  FilterOptions _filterOptions;


  @override
  void initState() {

    _filterOptions = FilterOptions(sortValue: -1, brandID: "", shopID: "", categoryID: "", subCategoryID: "", subSubCategoryID: "", priceRangeIndex: -1);

    _setTitle();

    _connectivity = this;
    _contract = this;
    _presenter = DataPresenter(_connectivity, productContract: _contract);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _init(context);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        endDrawer: ProductFilter(
          key: _key,
          filterOptions: _filterOptions,
          onFilterApplied: () {

            _applyFilter();
          },
          onFilterCleared: () {

            setState(() {
              _filterOptions = FilterOptions(sortValue: -1, brandID: "", shopID: "", categoryID: "", subCategoryID: "", subSubCategoryID: "", priceRangeIndex: -1);
              _products.clear();
              _products.addAll(_originalList);
            });
          },
        ),
        body: Builder(
          builder: (BuildContext context) {

            _context = context;

            return SafeArea(
              child: Stack(
                children: [

                  Column(
                    children: <Widget>[

                      MyAppBar(_appBarTitle,
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                ProductGridView(_products, false),

                                Visibility(
                                  visible: _currentPage != 0 && _currentPage != _totalPage && _products.length < _totalLength,
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Visibility(
                    visible: _isLoaded,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2.5 * SizeConfig.heightSizeMultiplier),
                            bottomLeft: Radius.circular(2.5 * SizeConfig.heightSizeMultiplier),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(
                              top: .625 * SizeConfig.heightSizeMultiplier,
                              bottom: .625 * SizeConfig.heightSizeMultiplier,
                              left: 3.84 * SizeConfig.widthSizeMultiplier,
                              right: 2.05 * SizeConfig.widthSizeMultiplier,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2.5 * SizeConfig.heightSizeMultiplier),
                                bottomLeft: Radius.circular(2.5 * SizeConfig.heightSizeMultiplier),
                              ),
                            ),
                            child: Image.asset(Images.filter,
                              height: 3.5 * SizeConfig.heightSizeMultiplier,
                              width: 7.45 * SizeConfig.widthSizeMultiplier,
                              color: Theme.of(context).dialogBackgroundColor,
                              fit: BoxFit.contain,
                            ),
                          ),
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


  void _setTitle() {

    try {

      if(widget.category != null) {

        _appBarTitle = widget.category.name;
      }
      else if(widget.subCategory != null) {

        _appBarTitle = widget.subCategory.name;
      }
      else if(widget.subSubCategory != null) {

        _appBarTitle = widget.subSubCategory.name;
      }
      else if(widget.brand != null) {

        _appBarTitle = widget.brand.name;
      }
      else if(widget.shop != null) {

        _appBarTitle = widget.shop.name;
      }
      else if(widget.showDiscountedProduct) {

        _appBarTitle = widget.discountTitle ?? "";
      }
    }
    catch(error) {}
  }


  void _init(BuildContext context) {

    try {

      if(widget.category != null) {

        _presenter.getProducts(context, Constants.BY_CATEGORY, widget.category.slug, page: _currentPage + 1);
      }
      else if(widget.subCategory != null) {

        _presenter.getProducts(context, Constants.BY_SUBCATEGORY, widget.subCategory.slug, page: _currentPage + 1);
      }
      else if(widget.subSubCategory != null) {

        _presenter.getProducts(context, Constants.BY_SUB_SUBCATEGORY, widget.subSubCategory.slug, page: _currentPage + 1);
      }
      else if(widget.brand != null) {

        _presenter.getProducts(context, Constants.BY_BRAND, widget.brand.slug, page: _currentPage + 1);
      }
      else if(widget.shop != null) {

        _presenter.getProducts(context, Constants.BY_SHOP, widget.shop.slug, page: _currentPage + 1);
      }
      if(widget.showDiscountedProduct) {

        _presenter.getProducts(context, Constants.BY_DISCOUNT, "", page: _currentPage + 1);
      }
    }
    catch(error) {}
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

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("not_connected"));
    }
  }


  @override
  void onFailure(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("could_not_load_data"));
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
  void productsByBrand(BrandProducts brandProducts) {

    if(_currentPage == 0) {

      _totalLength = brandProducts.totalProduct;
      _totalPage = (brandProducts.totalProduct / brandProducts.perPageProduct).ceil();
    }

    brandProducts.products.forEach((product) {

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

    _originalList = _originalList + brandProducts.products;

    _applyFilter();

    _currentPage = _currentPage + 1;

    if(_currentPage == 1) {

      _startLazyLoader();
    }
  }


  @override
  void productsByCategory(CategoryProducts categoryProducts) {

    if(_currentPage == 0) {

      _totalLength = categoryProducts.totalProduct;
      _totalPage = (categoryProducts.totalProduct / categoryProducts.perPageProduct).ceil();
    }

    categoryProducts.products.forEach((product) {

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

    _originalList = _originalList + categoryProducts.products;

    _applyFilter();

    _currentPage = _currentPage + 1;

    if(_currentPage == 1) {

      _startLazyLoader();
    }
  }


  @override
  void productsByShop(ShopProducts shopProducts) {

    if(_currentPage == 0) {

      _totalLength = shopProducts.totalProduct;
      _totalPage = (shopProducts.totalProduct / shopProducts.perPageProduct).ceil();
    }

    shopProducts.products.forEach((product) {

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

    _originalList = _originalList + shopProducts.products;

    _applyFilter();

    _currentPage = _currentPage + 1;

    if(_currentPage == 1) {

      _startLazyLoader();
    }
  }


  @override
  void productsBySubCategory(SubCategoryProducts subCategoryProducts) {

    if(_currentPage == 0) {

      _totalLength = subCategoryProducts.totalProduct;
      _totalPage = (subCategoryProducts.totalProduct / subCategoryProducts.perPageProduct).ceil();
    }

    subCategoryProducts.products.forEach((product) {

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

    _originalList = _originalList + subCategoryProducts.products;

    _applyFilter();

    _currentPage = _currentPage + 1;

    if(_currentPage == 1) {

      _startLazyLoader();
    }
  }


  @override
  void productsBySubSubCategory(SubSubCategoryProducts subSubCategoryProducts) {

    if(_currentPage == 0) {

      _totalLength = subSubCategoryProducts.totalProduct;
      _totalPage = (subSubCategoryProducts.totalProduct / subSubCategoryProducts.perPageProduct).ceil();
    }

    subSubCategoryProducts.products.forEach((product) {

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

    _originalList = _originalList + subSubCategoryProducts.products;

    _applyFilter();

    _currentPage = _currentPage + 1;

    if(_currentPage == 1) {

      _startLazyLoader();
    }
  }


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

    _originalList = _originalList + discountedProducts.products;

    _applyFilter();

    _currentPage = _currentPage + 1;

    if(_currentPage == 1) {

      _startLazyLoader();
    }
  }


  void _startLazyLoader() {

    _scrollController.addListener(() {

      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {

        if(_currentPage < _totalPage) {

          _init(_context);
        }
      }
    });
  }


  void _applyFilter() {

    _products.clear();
    _products.addAll(_originalList);

    List<Product> mList = List();

    if(_filterOptions.sortValue != -1) {

      if(_filterOptions.sortValue != 0) {

        _products.sort((a,b) => a.currentPrice.compareTo(b.currentPrice));

        if(_filterOptions.sortValue == 2) {

          _products = List.from(_products.reversed);
        }
      }
    }

    if(_filterOptions.brandID != "") {

      _products.forEach((product) {

        if(product != null && product.brand != null && product.brand.id != null && product.brand.id == _filterOptions.brandID) {

          mList.add(product);
        }
      });

      _products.clear();
      _products.addAll(mList);
      mList.clear();
    }

    if(_filterOptions.categoryID != "") {

      _products.forEach((product) {

        if(product != null && product.category != null && product.category.id != null && product.category.id == _filterOptions.categoryID) {

          mList.add(product);
        }
      });

      _products.clear();
      _products.addAll(mList);
      mList.clear();
    }

    if(_filterOptions.subCategoryID != "") {

      _products.forEach((product) {

        if(product != null && product.subCategory != null && product.subCategory.id != null && product.subCategory.id == _filterOptions.subCategoryID) {

          mList.add(product);
        }
      });

      _products.clear();
      _products.addAll(mList);
      mList.clear();
    }

    if(_filterOptions.subSubCategoryID != "") {

      _products.forEach((product) {

        if(product.subSubCategory != null && product.subSubCategory.id != null && product.subSubCategory.id == _filterOptions.subSubCategoryID) {

          mList.add(product);
        }
      });

      _products.clear();
      _products.addAll(mList);
      mList.clear();
    }

    if(_filterOptions.priceRangeIndex != -1) {

      double minPrice = 0.0;
      double maxPrice = 0.0;

      switch(_filterOptions.priceRangeIndex) {

        case 0:
          minPrice = 0.0;
          maxPrice = 1000.0;
          break;

        case 1:
          minPrice = 1000.0;
          maxPrice = 10000.0;
          break;

        case 2:
          minPrice = 10000.0;
          maxPrice = 50000.0;
          break;

        case 3:
          minPrice = 50000.0;
          maxPrice = 250000.0;
          break;

        case 4:
          minPrice = 250000.0;
          maxPrice = 5000000.0;
          break;
      }

      _products.forEach((product) {

        if(product != null && product.currentPrice >= minPrice && product.currentPrice <= maxPrice) {

          mList.add(product);
        }
      });

      _products.clear();
      _products.addAll(mList);
    }

    _isLoaded = true;

    setState(() {});
  }


  Future<Widget> _showErrorDialog(BuildContext mainContext, String subTitle) async {

    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {

              _init(mainContext);
            },
          );
        }
    );
  }
}