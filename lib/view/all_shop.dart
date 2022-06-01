import '../utils/my_overlay_loader.dart';

import '../contract/connectivity_contract.dart';
import '../contract/shop_contract.dart';
import '../localization/app_localization.dart';
import '../model/shop.dart';
import '../presenter/data_presenter.dart';
import '../utils/size_config.dart';
import '../widget/error_widget.dart';
import '../widget/my_app_bar.dart';
import '../widget/search_box.dart';
import '../widget/shop_grid_view.dart';
import 'package:flutter/material.dart';

class AllShop extends StatefulWidget {

  @override
  _AllShopState createState() => _AllShopState();
}

class _AllShopState extends State<AllShop> implements Connectivity, ShopContract {

  DataPresenter _presenter;

  ShopContract _contract;
  Connectivity _connectivity;

  List<Shop> _shops = List();
  List<Shop> _filterList = List();

  @override
  void initState() {

    _connectivity = this;
    _contract = this;
    _presenter = DataPresenter(_connectivity, shopContract: _contract);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _presenter.getAllShop(context);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {

            return SafeArea(
              child: Column(
                children: <Widget>[

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("shops"),
                    onBackPress: () {

                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),

                  Visibility(
                    visible: _shops.length > 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 1.875 * SizeConfig.heightSizeMultiplier,
                        left: 2.56 * SizeConfig.widthSizeMultiplier,
                        right: 2.56 * SizeConfig.widthSizeMultiplier,
                        bottom: 1.875 * SizeConfig.heightSizeMultiplier,
                      ),
                      child: SearchBox(
                        onTextChanged: (String value) {

                          _searchBrand(value);
                        },
                      ),
                    ),
                  ),

                  Expanded(
                    child: ShopGridView(_filterList),
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
  void onSuccess(List<Shop> shops) {

    shops.sort((a,b) => a.name.compareTo(b.name));

    _shops.addAll(shops);
    _filterList.addAll(_shops);

    setState(() {});
  }


  void _searchBrand(String value) {

    _filterList.clear();

    _shops.forEach((shop) {

      if(shop.name.toLowerCase().startsWith(value.toLowerCase())) {

        _filterList.add(shop);
      }
    });

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

              _presenter.getAllShop(mainContext);
            },
          );
        }
    );
  }
}