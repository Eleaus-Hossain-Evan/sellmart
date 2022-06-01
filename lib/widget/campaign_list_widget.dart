import 'dart:async';

import 'package:extended_image/extended_image.dart';

import '../localization/app_localization.dart';
import '../model/campaign.dart';
import '../utils/size_config.dart';
import '../utils/api_routes.dart';
import '../view/single_campaign.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'count_down_widget.dart';

class CampaignListWidget extends StatefulWidget {

  final List<Campaign> campaigns;

  CampaignListWidget(this.campaigns);

  @override
  _CampaignListWidgetState createState() => _CampaignListWidgetState();
}

class _CampaignListWidgetState extends State<CampaignListWidget> {

  Timer _colorTimer;
  Color _color = Colors.white;

  @override
  void initState() {

    _alterColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: ListView.separated(
        itemCount: widget.campaigns == null ? 0 : widget.campaigns.length,
        padding: EdgeInsets.all(1.5 * SizeConfig.heightSizeMultiplier),
        separatorBuilder: (BuildContext context, int index) {

          return SizedBox(height: 1.5 * SizeConfig.heightSizeMultiplier,);
        },
        itemBuilder: (BuildContext context, int index) {

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {

              if((DateTime.parse(widget.campaigns[index].startDate).compareTo(DateTime.now()) == 0 ||
                  DateTime.parse(widget.campaigns[index].startDate).isBefore(DateTime.now())) && DateTime.parse(widget.campaigns[index].endDate).isAfter(DateTime.now())) {

                Navigator.push(context, MaterialPageRoute(builder: (context) => SingleCampaign(widget.campaigns[index].slug)));
              }
              else if(DateTime.parse(widget.campaigns[index].startDate).isAfter(DateTime.now())) {

                _showToast(AppLocalization.of(context).getTranslatedValue("campaign_not_started_yet"), Toast.LENGTH_SHORT);
              }
            },
            child: Stack(
              children: <Widget>[

                Container(
                  width: double.infinity,
                  height: 22.5 * SizeConfig.heightSizeMultiplier,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(.3 * SizeConfig.heightSizeMultiplier),
                    image: DecorationImage(
                      image: ExtendedNetworkImageProvider(widget.campaigns[index].image ?? (APIRoute.BASE_URL + ""),
                        cache: true,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Visibility(
                  visible: DateTime.parse(widget.campaigns[index].startDate).isAfter(DateTime.now()),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 1.25 * SizeConfig.heightSizeMultiplier,
                      left: 2.56 * SizeConfig.widthSizeMultiplier,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                        top: .5 * SizeConfig.heightSizeMultiplier,
                        bottom: .5 * SizeConfig.heightSizeMultiplier,
                        left: 1.28 * SizeConfig.widthSizeMultiplier,
                        right: 2.56 * SizeConfig.widthSizeMultiplier,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          Text(AppLocalization.of(context).getTranslatedValue("starts_in").toUpperCase(),
                            style: Theme.of(context).textTheme.subtitle2,
                          ),

                          SizedBox(width: 1.28 * SizeConfig.widthSizeMultiplier,),

                          CountDownWidget(widget.campaigns[index].startDate),
                        ],
                      ),
                    ),
                  ),
                ),

                Visibility(
                  visible: (DateTime.parse(widget.campaigns[index].startDate).compareTo(DateTime.now()) == 0 ||
                      DateTime.parse(widget.campaigns[index].startDate).isBefore(DateTime.now())) && DateTime.parse(widget.campaigns[index].endDate).isAfter(DateTime.now()),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 1.25 * SizeConfig.heightSizeMultiplier,
                      left: 2.56 * SizeConfig.widthSizeMultiplier,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                        top: .5 * SizeConfig.heightSizeMultiplier,
                        bottom: .5 * SizeConfig.heightSizeMultiplier,
                        left: 2.56 * SizeConfig.widthSizeMultiplier,
                        right: 2.56 * SizeConfig.widthSizeMultiplier,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                      ),
                      child: Text(AppLocalization.of(context).getTranslatedValue("live"),
                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: _color),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  @override
  void dispose() {

    _stopTimer();
    super.dispose();
  }


  void _alterColor() {

    _colorTimer = Timer.periodic(Duration(milliseconds: 800), (Timer timer) async {

      if(_color == Colors.white) {

        _color = Colors.red[700];
      }
      else {

        _color = Colors.white;
      }

      if(mounted) {

        setState(() {});
      }
    });
  }


  void _stopTimer() {

    if(_colorTimer != null && _colorTimer.isActive) {

      _colorTimer.cancel();
    }
  }


  void _showToast(String message, Toast length) {

    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(.8),
      textColor: Colors.white,
      fontSize: 2 * SizeConfig.textSizeMultiplier,
    );
  }
}