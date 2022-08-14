import 'package:logger/logger.dart';

import '../widget/product_details_footer.dart';
import '../widget/product_rating_review.dart';

import '../utils/price_calculator.dart';

import '../widget/my_app_bar.dart';

import '../model/variation.dart';
import '../model/variation_value_1.dart';
import '../model/variation_value_2.dart';
import '../utils/size_config.dart';
import '../view/wish_list.dart';

import '../contract/connectivity_contract.dart';
import '../contract/product_detail_contract.dart';
import '../localization/app_localization.dart';
import '../model/product.dart';
import '../presenter/data_presenter.dart';
import '../presenter/user_presenter.dart';
import '../widget/error_widget.dart';
import '../widget/product_description.dart';
import '../widget/product_info.dart';
import '../widget/product_variation_info.dart';
import '../widget/product_size_info.dart';
import '../widget/product_sliver_app_bar.dart';
import '../widget/similar_products.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String productSlug;

  ProductDetails(this.productSlug);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with ChangeNotifier
    implements ProductDetailContract, Connectivity {
  DataPresenter _presenter;

  ProductDetailContract _contract;
  Connectivity _connectivity;

  String _strDiscount = "", _strVat = "";

  Product _product;

  List<Product> _similarProducts = List();

  @override
  void initState() {
    _connectivity = this;
    _contract = this;

    _presenter = DataPresenter(_connectivity, productDetailContract: _contract);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _presenter.getProductDetails(context, widget.productSlug);
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
            return SafeArea(
              child: Column(
                children: <Widget>[
                  MyAppBar(
                    AppLocalization.of(context)
                        .getTranslatedValue("product_details"),
                    onBackPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: _product == null
                          ? Container()
                          : Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 8 * SizeConfig.heightSizeMultiplier,
                                  ),
                                  child: CustomScrollView(
                                    slivers: <Widget>[
                                      ProductSliverAppBar(_product),
                                      SliverToBoxAdapter(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              color: Colors.white,
                                              margin: EdgeInsets.only(
                                                  top: 1 *
                                                      SizeConfig
                                                          .heightSizeMultiplier),
                                              padding: EdgeInsets.only(
                                                top: 1.875 *
                                                    SizeConfig
                                                        .heightSizeMultiplier,
                                                bottom: .625 *
                                                    SizeConfig
                                                        .heightSizeMultiplier,
                                                left: 3.84 *
                                                    SizeConfig
                                                        .widthSizeMultiplier,
                                                right: 3.84 *
                                                    SizeConfig
                                                        .widthSizeMultiplier,
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  ProductInfo(
                                                    _product,
                                                    _strDiscount,
                                                    _strVat,
                                                    addToWishList: () {
                                                      _presenter.addToWishList(
                                                          context, _product.id);
                                                    },
                                                    removeFromWishList: () {
                                                      _presenter
                                                          .removeFromWishList(
                                                              context,
                                                              _product.id);
                                                    },
                                                  ),

                                                  // ProductVariationInfo(_product,
                                                  //   onVariationSelected: (Variation variation) {

                                                  //     _onVariationChanged(variation);
                                                  //   },
                                                  // ),

                                                  ProductSizeInfo(_product),

                                                  ProductDescription(_product),

                                                  ProductRatingReview(
                                                      context, _product),
                                                ],
                                              ),
                                            ),
                                            SimilarProducts(
                                                _similarProducts, false),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ProductDetailsFooter(_product),
                              ],
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
    _presenter.hideOverlayLoader();
    super.dispose();
  }

  @override
  void onDisconnected(BuildContext context) {
    if (mounted) {
      _showErrorDialog(context,
          AppLocalization.of(context).getTranslatedValue("not_connected"));
    }
  }

  @override
  void onFailure(BuildContext context) {
    if (mounted) {
      _showErrorDialog(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("could_not_load_data"));
    }
  }

  @override
  void onInactive(BuildContext context) {
    if (mounted) {
      _showErrorDialog(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("inactive_connection"));
    }
  }

  @override
  void onTimeout(BuildContext context) {
    if (mounted) {
      _showErrorDialog(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("connection_time_out"));
    }
  }

  @override
  void onSuccess(Product product, List<Product> similarProducts) {
    similarProducts.forEach((product) {
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

    product.quantity = 1;
    product.isWishListed = false;

    if (currentUser.value.id != null && currentUser.value.id.isNotEmpty) {
      for (int i = 0; i < currentUser.value.wishList.length; i++) {
        if (currentUser.value.wishList[i] == product.id) {
          product.isWishListed = true;
          break;
        }
      }
    }

    if ((product.variationType == 0 || product.variationType == 1) &&
        product.variations.length > 0) {
      product.selectedVariation = product.variations[0];
      product.images = product.variations[0].images;

      if (product.selectedVariation != null) {
        if (product.selectedVariation.regularPrice ==
            product.selectedVariation.discountPrice) {
          setState(() {
            _strDiscount = "";
          });

          product.price = product.selectedVariation.regularPrice;
          product.currentPrice = product.selectedVariation.regularPrice;
        } else {
          if (product.selectedVariation.discountType ==
              PriceCalculator.AMOUNT) {
            _strDiscount = "৳" +
                product.selectedVariation.discountAmount.round().toString();
          } else {
            _strDiscount =
                product.selectedVariation.discountAmount.round().toString() +
                    "%";
          }

          setState(() {});

          product.price = product.selectedVariation.regularPrice;
          product.currentPrice = product.selectedVariation.discountPrice;
        }
      }

      for (int i = 0; i < product.variations.length; i++) {
        if (product.variations[i] != null && product.variations[i].stock > 0) {
          Variation variation = product.variations[i];
          bool variationFound = false;

          for (int j = 0; j < product.variation1Values.length; j++) {
            if (product.variation1Values[j].name == variation.value1) {
              product.variation2Values.insert(
                  (j + 1),
                  VariationValue2(
                      id: variation.id,
                      name: variation.value2,
                      variation1Name: variation.value1));
              variationFound = true;
              break;
            }
          }

          if (!variationFound) {
            product.variation1Values
                .add(VariationValue1(id: variation.id, name: variation.value1));
            product.variation2Values.add(VariationValue2(
                id: variation.id,
                name: variation.value2,
                variation1Name: variation.value1));
          }
        }
      }
    } else if (product.variationType == 2 &&
        product.sizeInfos.length > 0 &&
        product.sizeInfos[0].infos.length > 1) {
      product.price = product.sizeInfos[0].regularPrice;
      product.currentPrice = product.sizeInfos[0].discountPrice;

      product.images = product.sizeInfos[0].images;
      product.selectedSizeItem = product.sizeInfos[0].infos[1][1];

      if (product.sizeInfos[0].regularPrice ==
          product.sizeInfos[0].discountPrice) {
        setState(() {
          _strDiscount = "";
        });
      } else {
        if (product.sizeInfos[0].discountType == PriceCalculator.AMOUNT) {
          _strDiscount =
              "৳" + product.sizeInfos[0].discountAmount.round().toString();
        } else {
          _strDiscount =
              product.sizeInfos[0].discountAmount.round().toString() + "%";
        }

        setState(() {});
      }
    }

    setState(() {
      _product = product;
      _similarProducts = similarProducts;
    });

    // Logger().wtf(
    //     "${_product.id}-${_product.name}-${_product.slug}-${_product.youtubeVideo}");

    _onImagesSelected();
  }

  @override
  void onAddedToWishList(BuildContext context) {
    setState(() {
      _product.isWishListed = true;
    });

    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text(AppLocalization.of(context)
              .getTranslatedValue("added_to_wish_list"))));
  }

  @override
  void onRemovedFromWishList(BuildContext context) {
    for (int i = 0; i < wishListProducts.value.length; i++) {
      if (wishListProducts.value[i].id == _product.id) {
        wishListProducts.value.removeAt(i);
        wishListProducts.notifyListeners();
        break;
      }
    }

    setState(() {
      _product.isWishListed = false;
    });

    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text(AppLocalization.of(context)
              .getTranslatedValue("removed_from_wish_list"))));
  }

  @override
  void onFailedToAddOrRemovedWishList(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _onVariationChanged(Variation variation) {
    if (_product.selectedVariation != null) {
      _product.images = variation.images;
      _onImagesSelected();

      if (_product.selectedVariation.regularPrice ==
          _product.selectedVariation.discountPrice) {
        setState(() {
          _strDiscount = "";
          _product.price = _product.selectedVariation.regularPrice;
          _product.currentPrice = _product.selectedVariation.regularPrice;
        });
      } else {
        if (_product.selectedVariation.discountType == PriceCalculator.AMOUNT) {
          _strDiscount = "৳" +
              _product.selectedVariation.discountAmount.round().toString();
        } else {
          _strDiscount =
              _product.selectedVariation.discountAmount.round().toString() +
                  "%";
        }

        _product.price = _product.selectedVariation.regularPrice;
        _product.currentPrice = _product.selectedVariation.discountPrice;

        setState(() {});
      }
    }
  }

  void _onImagesSelected() {
    List<String> mImage = List();

    int length = _product.images.length > 10 ? 10 : _product.images.length;

    if (length > 0) {
      for (int i = 0; i < length; i++) {
        mImage.add(_product.images[i]);
      }
    } else {
      mImage.add(_product.thumbnail);
    }

    _product.images.clear();
    _product.images.addAll(mImage);

    setState(() {});
  }

  Future<Widget> _showErrorDialog(
      BuildContext mainContext, String subTitle) async {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {
              _presenter.getProductDetails(mainContext, widget.productSlug);
            },
          );
        });
  }
}
