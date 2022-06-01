import 'dart:async';

import '../localization/app_localization.dart';
import '../model/campaign.dart';
import '../model/campaign_remaining_time.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'campaign_product_widget.dart';

class CampaignWidget extends StatefulWidget {

  final Campaign campaign;

  CampaignWidget(this.campaign);

  @override
  _CampaignWidgetState createState() => _CampaignWidgetState();
}

class _CampaignWidgetState extends State<CampaignWidget> {

  CampaignRemainingTime _remainingTime = CampaignRemainingTime(hour: "00", minute: "00", second: "00");
  Timer _timer;

  @override
  void initState() {

    _startCountDownTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        Container(
          padding: EdgeInsets.all(1.25 * SizeConfig.heightSizeMultiplier),
          color: Colors.grey.withOpacity(.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(widget.campaign.name,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        padding: EdgeInsets.only(
                          top: .5 * SizeConfig.heightSizeMultiplier,
                          bottom: .5 * SizeConfig.heightSizeMultiplier,
                          left: 1.79 * SizeConfig.widthSizeMultiplier,
                          right: 1.79 * SizeConfig.widthSizeMultiplier,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(.375 * SizeConfig.heightSizeMultiplier),
                        ),
                        child: Center(
                          child: Text(_remainingTime.hour,
                            style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: .769 * SizeConfig.widthSizeMultiplier, right: .769 * SizeConfig.widthSizeMultiplier),
                        child: Text(":",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(
                          top: .5 * SizeConfig.heightSizeMultiplier,
                          bottom: .5 * SizeConfig.heightSizeMultiplier,
                          left: 1.79 * SizeConfig.widthSizeMultiplier,
                          right: 1.79 * SizeConfig.widthSizeMultiplier,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(.375 * SizeConfig.heightSizeMultiplier),
                        ),
                        child: Center(
                          child: Text(_remainingTime.minute,
                            style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: .769 * SizeConfig.widthSizeMultiplier, right: .769 * SizeConfig.widthSizeMultiplier),
                        child: Text(":",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(
                          top: .5 * SizeConfig.heightSizeMultiplier,
                          bottom: .5 * SizeConfig.heightSizeMultiplier,
                          left: 1.79 * SizeConfig.widthSizeMultiplier,
                          right: 1.79 * SizeConfig.widthSizeMultiplier,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(.375 * SizeConfig.heightSizeMultiplier),
                        ),
                        child: Center(
                          child: Text(_remainingTime.second,
                            style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                },
                child: Row(
                  children: <Widget>[

                    Text(AppLocalization.of(context).getTranslatedValue("see_all"),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black54),
                    ),

                    SizedBox(width: 1.28 * SizeConfig.widthSizeMultiplier,),

                    Icon(Icons.arrow_forward_ios, size: 2.25 * SizeConfig.heightSizeMultiplier, color: Colors.black54,),
                  ],
                ),
              ),
            ],
          ),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.all(1.25 * SizeConfig.heightSizeMultiplier),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.campaign.products == null ? 0 : widget.campaign.products.length, (index) =>

                  Padding(
                    padding: EdgeInsets.only(right: index < widget.campaign.products.length - 1 ? 4.61 * SizeConfig.widthSizeMultiplier : 0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {


                      },
                      child: CampaignProductWidget(widget.campaign.products[index]),
                    ),
                  )
              ),
            ),
          ),
        ),
      ],
    );
  }


  void _startCountDownTimer() {

    int remainingSeconds = DateTime.parse(widget.campaign.endDate).difference(DateTime.now()).inSeconds;

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) async {

      if(remainingSeconds == 0) {

        _timer.cancel();
        _setTime(Duration(seconds: remainingSeconds));
      }
      else {

        remainingSeconds = remainingSeconds - 1;
        _setTime(Duration(seconds: remainingSeconds));
      }
    });
  }

  void _setTime(Duration duration) {

    _remainingTime.hour = twoDigits(duration.inHours);
    _remainingTime.minute = twoDigits(duration.inMinutes.remainder(60));
    _remainingTime.second = twoDigits(duration.inSeconds.remainder(60));

    if(mounted) {
      setState(() {});
    }
  }

  String twoDigits(int n) => n.toString().padLeft(2, "0");
}