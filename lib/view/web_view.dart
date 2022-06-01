import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import '../widget/error_widget.dart';
import '../utils/constants.dart';
import '../presenter/data_presenter.dart';
import '../contract/connectivity_contract.dart';
import '../contract/policy_contract.dart';
import '../localization/app_localization.dart';
import 'package:flutter/material.dart';

class WebView extends StatefulWidget {

  final String title;
  final int type;

  WebView(this.title, this.type);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> with TickerProviderStateMixin implements Connectivity, PolicyContract {

  DataPresenter _presenter;

  Connectivity _connectivity;
  PolicyContract _policyContract;

  String _content = "";

  @override
  void initState() {

    _connectivity = this;
    _policyContract = this;
    _presenter = DataPresenter(_connectivity, policyContract: _policyContract);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _presenter.getPolicies(context);
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
                children: [

                  MyAppBar(widget.title ?? "",
                    enableButtons: false,
                    onBackPress: () {

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
                        child: Padding(
                          padding: EdgeInsets.all(1.5 * SizeConfig.heightSizeMultiplier),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Html(
                              data: _content,
                              style: {
                                "body": Style(
                                  fontSize: FontSize(2.25 * SizeConfig.textSizeMultiplier),
                                  fontWeight: FontWeight.w400,
                                ),
                              },
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
  void onInactive(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("inactive_connection"));
    }
  }


  @override
  void onDisconnected(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("not_connected"));
    }
  }


  @override
  void onTimeout(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("connection_time_out"));
    }
  }


  @override
  void onFailed(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("failed_to_get_data"));
    }
  }


  @override
  void onSuccess(String termsConditions, String privacyPolicy, String returnPolicy) {

    switch(widget.type) {

      case Constants.RETURN_POLICY:
        _content = returnPolicy;
        break;

      case Constants.PRIVACY_POLICY:
        _content = privacyPolicy;
        break;

      case Constants.TERMS_CONDITIONS:
        _content = termsConditions;
        break;
    }

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

              _presenter.getPolicies(context);
            },
          );
        }
    );
  }
}