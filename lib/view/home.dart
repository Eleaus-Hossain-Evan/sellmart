import '../widget/category_horizontal_list_view.dart';
import '../widget/home_app_bar.dart';

import '../model/info.dart';
import '../contract/home_contract.dart';
import '../localization/app_localization.dart';
import '../model/home_data.dart';
import '../route/route_manager.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../utils/update_check.dart';
import '../utils/slug_debugger.dart';
import '../widget/error_widget.dart';
import '../widget/product_grid_view.dart';
import '../widget/silder_widget.dart';
import '../view/products.dart';

import '../presenter/data_presenter.dart';
import '../contract/connectivity_contract.dart';
import 'package:flutter/material.dart';

ValueNotifier<Info> info = ValueNotifier(Info());
ValueNotifier<bool> isHomeLoaded = ValueNotifier(false);

GlobalKey<_HomeState> homeKey = GlobalKey();

class Home extends StatefulWidget {

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> implements Connectivity, HomeContract {

  DataPresenter _presenter;

  Connectivity _connectivity;
  HomeContract _contract;

  BuildContext _context;

  HomeData _homeData;


  @override
  void initState() {

    _connectivity = this;
    _contract = this;
    _presenter = DataPresenter(_connectivity, homeContract: _contract);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _presenter.getHomeData(context);
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

                  HomeAppBar(),

                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: SingleChildScrollView(
                        child: _homeData == null ? Container() : Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[

                            _homeData != null && _homeData.info != null && _homeData.info.sliders != null ? SliderWidget(_homeData.info.sliders) : Container(),

                            _divider(),

                            _segmentHeader(context, AppLocalization.of(context).getTranslatedValue("category"), false, Constants.ALL_CATEGORY, ""),

                            _homeData != null && _homeData.categories != null ? CategoryHorizontalListView(_homeData.categories) : Container(),

                            Visibility(
                              visible: _homeData != null && _homeData.hotSelling != null && _homeData.hotSelling.products.length > 0,
                              child: Column(
                                children: [

                                  _divider(),

                                  _segmentHeader(context, AppLocalization.of(context).getTranslatedValue("top_selling"), false, 0, ""),

                                  _homeData != null && _homeData.hotSelling != null ? ProductGridView(_homeData.hotSelling.products, false) : Container(),
                                ],
                              ),
                            ),

                            Visibility(
                              visible: _homeData != null && _homeData.flashSale != null && _homeData.flashSale.products.length > 0,
                              child: Column(
                                children: [

                                  _divider(),

                                  _segmentHeader(context, AppLocalization.of(context).getTranslatedValue("flash_sale"), true, Constants.ALL_DISCOUNTED, ""),

                                  _homeData != null && _homeData.flashSale != null ? ProductGridView(_homeData.flashSale.products, false) : Container(),
                                ],
                              ),
                            ),

                            Visibility(
                              visible: _homeData != null && _homeData.sections != null && _homeData.sections.length > 0,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _homeData == null || _homeData.sections == null ? 0 : _homeData.sections.length,
                                itemBuilder: (BuildContext context, int index) {

                                  return Visibility(
                                    visible: _homeData.sections[index].products.length > 0,
                                    child: Column(
                                      children: <Widget>[

                                        _divider(),

                                        _segmentHeader(context, _homeData.sections[index].title, true, Constants.HOME_CATEGORY, _homeData.sections[index].slug ?? ""),

                                        ProductGridView(_homeData.sections[index].products, false),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
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


  Widget _divider() {

    return Container(
      color: Theme.of(context).hintColor,
      height: 1.25 * SizeConfig.heightSizeMultiplier,
      width: double.infinity,
    );
  }


  Widget _segmentHeader(BuildContext context, String title, bool showAll, int type, String slug) {

    return Padding(
      padding: EdgeInsets.only(
        top: .5 * SizeConfig.heightSizeMultiplier,
        bottom: .5 * SizeConfig.heightSizeMultiplier,
      ),
      child: Container(
        padding: EdgeInsets.all(1 * SizeConfig.heightSizeMultiplier),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Text(title,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: Colors.black.withOpacity(.85),
                fontWeight: FontWeight.w700,
              ),
            ),

            Visibility(
              visible: showAll,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  _onSeeAllPress(type, context: context, title: title, slug: slug);
                },
                child: Container(
                  padding: EdgeInsets.all(.625 * SizeConfig.heightSizeMultiplier),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(.4 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Text(AppLocalization.of(context).getTranslatedValue("see_all").toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _onSeeAllPress(int type, {BuildContext context, String title, String slug}) {

    switch(type) {

      case Constants.ALL_BRAND:
        Navigator.of(context).pushNamed(RouteManager.ALL_BRAND);
        break;

      case Constants.ALL_SHOP:
        Navigator.of(context).pushNamed(RouteManager.ALL_Shop);
        break;

      case Constants.ALL_DISCOUNTED:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Products(showDiscountedProduct: true, discountTitle: AppLocalization.of(context).getTranslatedValue("flash_sale"))));
        break;

      case Constants.HOME_CATEGORY:
        SlugDebugger.debug(context, title, slug);
        break;
    }
  }


  void reloadPage() {

    if(!isHomeLoaded.value) {

      _presenter.getHomeData(context);
    }
  }


  Future<bool> _onBackPress() {

    return Future(() => false);
  }


  @override
  void dispose() {

    _presenter.hideOverlayLoader();
    super.dispose();
  }


  @override
  void onInactive(BuildContext context) {

    isHomeLoaded.value = false;

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("inactive_connection"));
    }
  }


  @override
  void onDisconnected(BuildContext context) {

    isHomeLoaded.value = false;

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("not_connected"));
    }
  }


  @override
  void onTimeout(BuildContext context) {

    isHomeLoaded.value = false;

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("connection_time_out"));
    }
  }


  @override
  void onFailure(BuildContext context) {

    isHomeLoaded.value = false;

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("could_not_load_data"));
    }
  }


  @override
  void onSuccess(HomeData homeData) {

    info.value = homeData.info;
    UpdateCheck.checkForUpdate(_context);

    if(homeData != null && homeData.hotSelling != null && homeData.hotSelling.products != null) {

      homeData.hotSelling.products.forEach((product) {

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
    }

    if(homeData != null && homeData.flashSale != null && homeData.flashSale.products != null) {

      homeData.flashSale.products.forEach((product) {

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
    }

    if(homeData != null && homeData.sections != null && homeData.sections.length > 0) {

      homeData.sections.forEach((section) {

        section.products.forEach((product) {

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
      });
    }

    this._homeData = homeData;

    if(mounted) {
      setState(() {});
    }

    isHomeLoaded.value = true;
  }


  Future<Widget> _showErrorDialog(BuildContext mainContext, String subTitle) async {

    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {

              _presenter.getHomeData(mainContext);
            },
          );
        }
    );
  }
}