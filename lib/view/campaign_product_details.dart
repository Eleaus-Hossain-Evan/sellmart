import '../widget/product_rating_review.dart';

import '../widget/my_app_bar.dart';

import '../model/variation.dart';
import '../model/variation_value_1.dart';
import '../model/variation_value_2.dart';
import '../utils/size_config.dart';
import '../widget/campaign_product_variation_info.dart';
import '../widget/product_size_info.dart';

import '../contract/connectivity_contract.dart';
import '../contract/product_detail_contract.dart';
import '../localization/app_localization.dart';
import '../model/product.dart';
import '../presenter/data_presenter.dart';
import '../presenter/user_presenter.dart';
import '../utils/price_calculator.dart';
import '../widget/error_widget.dart';
import '../widget/product_description.dart';
import '../widget/product_info.dart';
import '../widget/product_sliver_app_bar.dart';
import '../widget/similar_products.dart';
import '../widget/campaign_product_details_footer.dart';
import 'package:flutter/material.dart';

class CampaignProductDetails extends StatefulWidget {
  final String productSlug;
  final String campaignSlug;
  final String campaignEndDate;

  CampaignProductDetails(
      this.productSlug, this.campaignSlug, this.campaignEndDate);

  @override
  _CampaignProductDetailsState createState() => _CampaignProductDetailsState();
}

class _CampaignProductDetailsState extends State<CampaignProductDetails>
    implements ProductDetailContract, Connectivity {
  DataPresenter _presenter;

  ProductDetailContract _contract;
  Connectivity _connectivity;

  String _strDiscount = "", _strVat = "";

  Product _product = Product(
      quantity: 1,
      images: [],
      sizes: [],
      variations: [],
      variation1Values: [],
      variation2Values: [],
      featured: false,
      newArrival: false,
      topSelling: false,
      freeDelivery: false);

  List<Product> _similarProducts = List();

  @override
  void initState() {
    _connectivity = this;
    _contract = this;

    _presenter = DataPresenter(_connectivity, productDetailContract: _contract);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _presenter.getProductDetails(context, widget.productSlug,
          campaignSlug: widget.campaignSlug);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
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
                      child: Stack(
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
                                        margin: EdgeInsets.only(
                                            top: 1 *
                                                SizeConfig
                                                    .heightSizeMultiplier),
                                        padding: EdgeInsets.only(
                                          top: 1.875 *
                                              SizeConfig.heightSizeMultiplier,
                                          bottom: .625 *
                                              SizeConfig.heightSizeMultiplier,
                                          left: 3.84 *
                                              SizeConfig.widthSizeMultiplier,
                                          right: 3.84 *
                                              SizeConfig.widthSizeMultiplier,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(3.125 *
                                                SizeConfig
                                                    .heightSizeMultiplier),
                                            topLeft: Radius.circular(3.125 *
                                                SizeConfig
                                                    .heightSizeMultiplier),
                                          ),
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
                                                _presenter.removeFromWishList(
                                                    context, _product.id);
                                              },
                                            ),
                                            CampaignProductVariationInfo(
                                                _product,
                                                widget.campaignEndDate),
                                            ProductSizeInfo(_product),
                                            ProductDescription(_product),
                                            ProductRatingReview(
                                                context, _product),
                                          ],
                                        ),
                                      ),
                                      SimilarProducts(
                                        _similarProducts,
                                        true,
                                        campaignSlug: widget.campaignSlug,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CampaignProductDetailsFooter(
                              _product, widget.campaignEndDate),
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
      product.currentPrice = product.campaignOfferPrice;
    });

    product.isWishListed = false;

    if (currentUser.value.id != null && currentUser.value.id.isNotEmpty) {
      for (int i = 0; i < currentUser.value.wishList.length; i++) {
        if (currentUser.value.wishList[i] == product.id) {
          product.isWishListed = true;
          break;
        }
      }
    }

    product.currentPrice = product.campaignOfferPrice;

    if (product.campaignDiscountType == PriceCalculator.AMOUNT) {
      _strDiscount = "৳" + product.campaignOfferDiscount.round().toString();
    } else {
      _strDiscount = product.campaignOfferDiscount.round().toString() + "%";
    }

    product.quantity = 1;
    product.images = [];
    product.images.add(product.thumbnail);

    if ((product.variationType == 0 || product.variationType == 1) &&
        product.variations.length > 0) {
      product.selectedVariation = product.variations[0];

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
            product.variation2Values
                .add(VariationValue2(id: variation.id, name: variation.value2));
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

      _onImagesSelected();
    }

    _product = product;
    _similarProducts = similarProducts;

    setState(() {});
  }

  @override
  void onAddedToWishList(BuildContext context) {
    setState(() {
      _product.isWishListed = true;
    });

    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(AppLocalization.of(context)
              .getTranslatedValue("added_to_wish_list"))));
  }

  @override
  void onRemovedFromWishList(BuildContext context) {
    setState(() {
      _product.isWishListed = false;
    });

    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(AppLocalization.of(context)
              .getTranslatedValue("removed_from_wish_list"))));
  }

  @override
  void onFailedToAddOrRemovedWishList(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
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
              _presenter.getProductDetails(mainContext, widget.productSlug,
                  campaignSlug: widget.campaignSlug);
            },
          );
        });
  }
}
