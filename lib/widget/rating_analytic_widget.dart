import 'package:percent_indicator/linear_percent_indicator.dart';

import '../localization/app_localization.dart';
import '../model/rating_analytic.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class RatingAnalyticWidget extends StatefulWidget {

  final RatingAnalytic ratingAnalytic;

  RatingAnalyticWidget(this.ratingAnalytic);

  @override
  _RatingAnalyticWidgetState createState() => _RatingAnalyticWidgetState();
}

class _RatingAnalyticWidgetState extends State<RatingAnalyticWidget> {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: widget.ratingAnalytic != null && widget.ratingAnalytic.totalRating != null && widget.ratingAnalytic.totalRating != 0,
      child: Column(
        children: <Widget>[

          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text((widget.ratingAnalytic != null && widget.ratingAnalytic.rating != null ? widget.ratingAnalytic.rating : 0.0).toString(),
                            style: Theme.of(context).textTheme.headline1.copyWith(
                              color: Colors.green,
                              height: .1225 * SizeConfig.heightSizeMultiplier,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          Icon(Icons.star, color: Colors.green, size: 4.61 * SizeConfig.imageSizeMultiplier,),
                        ],
                      ),

                      SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

                      _numberOfRating(widget.ratingAnalytic.totalRating.toString() + " " + (widget.ratingAnalytic.totalRating > 1 ?
                      AppLocalization.of(context).getTranslatedValue("ratings") : AppLocalization.of(context).getTranslatedValue("rating"))),

                      SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

                      _numberOfRating(widget.ratingAnalytic.totalReview.toString() + " " + (widget.ratingAnalytic.totalReview > 1 ?
                      AppLocalization.of(context).getTranslatedValue("reviews") : AppLocalization.of(context).getTranslatedValue("review"))),
                    ],
                  ),
                ),

                Expanded(
                  flex: 7,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            _ratingTitle(AppLocalization.of(context).getTranslatedValue("excellent")),

                            SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

                            _ratingTitle(AppLocalization.of(context).getTranslatedValue("very_good")),

                            SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

                            _ratingTitle(AppLocalization.of(context).getTranslatedValue("good")),

                            SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

                            _ratingTitle(AppLocalization.of(context).getTranslatedValue("average")),

                            SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

                            _ratingTitle(AppLocalization.of(context).getTranslatedValue("poor")),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 8,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[

                                  _ratingPercentIndicator((widget.ratingAnalytic.fiveStars ?? 1) / widget.ratingAnalytic.totalRating, Colors.green[900]),

                                  _ratingPercentIndicator((widget.ratingAnalytic.fourStars ?? 1) / widget.ratingAnalytic.totalRating, Colors.green[600]),

                                  _ratingPercentIndicator((widget.ratingAnalytic.threeStars ?? 1) / widget.ratingAnalytic.totalRating, Colors.green[300]),

                                  _ratingPercentIndicator((widget.ratingAnalytic.twoStars ?? 1) / widget.ratingAnalytic.totalRating, Colors.red[400]),

                                  _ratingPercentIndicator((widget.ratingAnalytic.oneStars ?? 1) / widget.ratingAnalytic.totalRating, Colors.red[800]),
                                ],
                              ),
                            ),

                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                _numberOfRating(widget.ratingAnalytic.fiveStars == null ? "" : widget.ratingAnalytic.fiveStars.toString()),

                                _numberOfRating(widget.ratingAnalytic.fourStars == null ? "" : widget.ratingAnalytic.fourStars.toString()),

                                _numberOfRating(widget.ratingAnalytic.threeStars == null ? "" : widget.ratingAnalytic.threeStars.toString()),

                                _numberOfRating(widget.ratingAnalytic.twoStars == null ? "" : widget.ratingAnalytic.twoStars.toString()),

                                _numberOfRating(widget.ratingAnalytic.oneStars == null ? "" : widget.ratingAnalytic.oneStars.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _ratingTitle(String title) {

    return Text(title,
      style: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 1.5 * SizeConfig.textSizeMultiplier,
        fontWeight: FontWeight.w400,
      ),
    );
  }


  Widget _ratingPercentIndicator(double percentage, Color progressColor) {

    return LinearPercentIndicator(
      lineHeight: .6 * SizeConfig.heightSizeMultiplier,
      percent: percentage,
      backgroundColor: Colors.grey[300],
      progressColor: progressColor,
      linearStrokeCap: LinearStrokeCap.roundAll,
    );
  }


  Widget _numberOfRating(String string) {

    return Text(string,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 1.375 * SizeConfig.textSizeMultiplier,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}