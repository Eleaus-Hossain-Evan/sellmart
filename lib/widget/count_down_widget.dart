import 'dart:async';

import '../model/campaign_remaining_time.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {

  final String date;

  CountDownWidget(this.date);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {

  CampaignRemainingTime _remainingTime = CampaignRemainingTime(hour: "00", minute: "00", second: "00");
  Timer _timer;


  @override
  void initState() {

    _startCountDownTimer();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Row(
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
    );
  }


  @override
  void dispose() {

    _stopTimer();
    super.dispose();
  }


  void _stopTimer() {

    if(_timer != null && _timer.isActive) {

      _timer.cancel();
    }
  }


  void _startCountDownTimer() {

    if(widget.date != null && widget.date.isNotEmpty) {

      int remainingSeconds = DateTime.parse(widget.date).difference(DateTime.now()).inSeconds;

      if(remainingSeconds > 0) {

        try {

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
        catch(error) {}
      }
    }
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