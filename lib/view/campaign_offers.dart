import '../widget/my_app_bar.dart';

import '../contract/campaign_contract.dart';
import '../contract/connectivity_contract.dart';
import '../model/campaign.dart';
import '../model/campaign_remaining_time.dart';
import '../presenter/data_presenter.dart';
import '../widget/campaign_list_widget.dart';
import '../widget/error_widget.dart';
import '../utils/size_config.dart';

import '../localization/app_localization.dart';
import 'package:flutter/material.dart';

GlobalKey<_CampaignOffersState> campaignOffersKey = GlobalKey();

class CampaignOffers extends StatefulWidget {
  CampaignOffers({Key key}) : super(key: key);

  @override
  _CampaignOffersState createState() => _CampaignOffersState();
}

class _CampaignOffersState extends State<CampaignOffers>
    implements Connectivity, CampaignContract {
  DataPresenter _presenter;

  Connectivity _connectivity;
  CampaignContract _campaignContract;

  List<Campaign> _campaigns = List();

  @override
  void initState() {
    _connectivity = this;
    _campaignContract = this;
    _presenter =
        DataPresenter(_connectivity, campaignContract: _campaignContract);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Builder(
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                children: <Widget>[
                  MyAppBar(
                    AppLocalization.of(context)
                        .getTranslatedValue("campaign_offers"),
                    autoImplyLeading: false,
                    onBackPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),
                  Expanded(
                    child: _campaigns.isNotEmpty
                        ? CampaignListWidget(_campaigns)
                        : Center(
                            child: Text(
                              "No Campaign Running",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                    fontSize:
                                        2.5 * SizeConfig.textSizeMultiplier,
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

  void reloadPage() {
    _campaigns = List();

    if (mounted) {
      setState(() {});
    }

    _presenter.getAllCampaign(context);
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
  void onDisconnected(BuildContext context) {
    if (mounted) {
      _showErrorDialog(context,
          AppLocalization.of(context).getTranslatedValue("not_connected"));
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
  void onAllCampaignOfferFound(List<Campaign> campaigns) {
    this._campaigns.clear();

    for (int i = 0; i < campaigns.length; i++) {
      if (campaigns[i].active != null && campaigns[i].active) {
        if (campaigns[i].endDate != null &&
            campaigns[i].endDate.isNotEmpty &&
            DateTime.parse(campaigns[i].endDate).isAfter(DateTime.now())) {
          campaigns[i].remainingTime =
              CampaignRemainingTime(hour: "00", minute: "00", second: "00");
          this._campaigns.add(campaigns[i]);
        }
      }
    }

    setState(() {});
  }

  @override
  void onFailedToGetCampaignOffers(BuildContext context) {
    if (mounted) {
      _showErrorDialog(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("could_not_load_data"));
    }
  }

  @override
  void onCampaignDataFound(Campaign campaign) {}

  @override
  void onFailedToGetCampaignData(BuildContext context) {}

  Future<Widget> _showErrorDialog(
      BuildContext mainContext, String subTitle) async {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {
              _presenter.getAllCampaign(mainContext);
            },
          );
        });
  }
}
