import '../utils/my_overlay_loader.dart';

import '../contract/brand_contract.dart';
import '../contract/connectivity_contract.dart';
import '../localization/app_localization.dart';
import '../model/brand.dart';
import '../presenter/data_presenter.dart';
import '../utils/size_config.dart';
import '../widget/brand_grid_view.dart';
import '../widget/error_widget.dart';
import '../widget/my_app_bar.dart';
import '../widget/search_box.dart';
import 'package:flutter/material.dart';

class AllBrand extends StatefulWidget {

  @override
  _AllBrandState createState() => _AllBrandState();
}

class _AllBrandState extends State<AllBrand> implements Connectivity, BrandContract {

  DataPresenter _presenter;

  BrandContract _contract;
  Connectivity _connectivity;

  List<Brand> _brands = List();
  List<Brand> _filterList = List();

  @override
  void initState() {

    _connectivity = this;
    _contract = this;
    _presenter = DataPresenter(_connectivity, brandContract: _contract);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _presenter.getAllBrand(context);
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

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("brands"),
                    onBackPress: () {

                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),

                  Visibility(
                    visible: _brands.length > 0,
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
                    child: BrandGridView(_filterList),
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
  void onSuccess(List<Brand> brands) {

    brands.sort((a,b) => a.name.compareTo(b.name));

    brands.forEach((brand) {

      if(brand.active != null && brand.active) {

        this._brands.add(brand);
      }
    });

    _filterList.addAll(_brands);

    setState(() {});
  }


  void _searchBrand(String value) {

    _filterList.clear();

    _brands.forEach((brand) {

      if(brand.name.toLowerCase().startsWith(value.toLowerCase())) {

        _filterList.add(brand);
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

              _presenter.getAllBrand(mainContext);
            },
          );
        }
    );
  }
}