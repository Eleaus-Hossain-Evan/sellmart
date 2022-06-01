import 'package:extended_image/extended_image.dart';
import '../model/product.dart';

import '../contract/campaign_contract.dart';
import '../contract/connectivity_contract.dart';
import '../localization/app_localization.dart';
import '../model/campaign.dart';
import '../presenter/data_presenter.dart';
import '../utils/size_config.dart';
import '../utils/api_routes.dart';
import '../widget/count_down_widget.dart';
import '../widget/error_widget.dart';
import '../widget/my_app_bar.dart';
import '../widget/product_grid_view.dart';
import 'package:flutter/material.dart';

class SingleCampaign extends StatefulWidget {

  final String slug;

  SingleCampaign(this.slug);

  @override
  _SingleCampaignState createState() => _SingleCampaignState();
}

class _SingleCampaignState extends State<SingleCampaign> implements Connectivity, CampaignContract {

  DataPresenter _presenter;

  Connectivity _connectivity;
  CampaignContract _campaignContract;

  Widget _countDownWidget = Container();

  int _currentIndex = 0;

  Campaign _campaign = Campaign(name: "", products: []);


  @override
  void initState() {

    _connectivity = this;
    _campaignContract = this;
    _presenter = DataPresenter(_connectivity, campaignContract: _campaignContract);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _presenter.getCampaignProducts(context, widget.slug);
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
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  MyAppBar(_campaign.name ?? "",
                    onBackPress: () {

                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),

                  Expanded(
                    child: IndexedStack(
                      index: _currentIndex,
                      children: [

                        Container(),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            Padding(
                              padding: EdgeInsets.all(1.25 * SizeConfig.heightSizeMultiplier),
                              child: Container(
                                width: double.infinity,
                                height: 18 * SizeConfig.heightSizeMultiplier,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                                  image: DecorationImage(
                                    image: ExtendedNetworkImageProvider(_campaign.image ?? (APIRoute.BASE_URL + ""),
                                      cache: true,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

                            _countDownWidget,

                            SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

                            NotificationListener<OverscrollIndicatorNotification>(
                              onNotification: (overScroll) {
                                overScroll.disallowGlow();
                                return;
                              },
                              child: SingleChildScrollView(
                                child: ProductGridView(_campaign.products, true, campaignSlug: widget.slug ?? "", campaignEndDate: _campaign.endDate ?? "",),
                              ),
                            ),
                          ],
                        ),

                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10.25 * SizeConfig.widthSizeMultiplier,
                              right: 10.25 * SizeConfig.widthSizeMultiplier,
                            ),
                            child: Text(AppLocalization.of(context).getTranslatedValue("campaign_expired"),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline5.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
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

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("not_connected"));
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
  void onFailedToGetCampaignData(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("could_not_load_data"));
    }
  }


  @override
  void onAllCampaignOfferFound(List<Campaign> campaigns) {}


  @override
  void onFailedToGetCampaignOffers(BuildContext context) {}


  @override
  void onCampaignDataFound(Campaign campaign) {

    if(campaign.endDate != null && campaign.endDate.isNotEmpty && DateTime.parse(campaign.endDate).isBefore(DateTime.now())) {

      setState(() {
        _currentIndex = 2;
      });
    }
    else {

      this._campaign = campaign;

      List<Product> products = List();

      campaign.products.forEach((product) {

        if(product.active != null && product.active) {

          product.currentPrice = product.campaignOfferPrice;
          products.add(product);
        }
      });

      _currentIndex = 1;
      _campaign.products = products;
      _countDownWidget = CountDownWidget(_campaign.endDate ?? "");

      setState(() {});
    }
  }


  Future<Widget> _showErrorDialog(BuildContext mainContext, String subTitle) async {

    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {

              setState(() {
                _currentIndex = 0;
              });

              _presenter.getCampaignProducts(mainContext, widget.slug);
            },
          );
        }
    );
  }
}