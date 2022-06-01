import '../localization/app_localization.dart';
import '../model/product.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'review_list_view.dart';
import 'all_review_bottom_sheet.dart';
import 'rating_analytic_widget.dart';

class ProductRatingReview extends StatefulWidget {

  final BuildContext parentContext;
  final Product product;

  ProductRatingReview(this.parentContext, this.product);

  @override
  _ProductRatingReviewState createState() => _ProductRatingReviewState();
}

class _ProductRatingReviewState extends State<ProductRatingReview> {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: widget.product != null && widget.product.ratingAnalytic != null,
      child: Column(
        children: <Widget>[

          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Text(AppLocalization.of(context).getTranslatedValue("product_rating_review"),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              Visibility(
                visible: widget.product != null && widget.product.ratingAnalytic != null &&
                    widget.product.ratingAnalytic.totalRating != null && widget.product.ratingAnalytic.totalRating != 0,
                child: Column(
                  children: <Widget>[

                    SizedBox(height: 3 * SizeConfig.heightSizeMultiplier,),

                    RatingAnalyticWidget(widget.product.ratingAnalytic),

                    SizedBox(height: 3 * SizeConfig.heightSizeMultiplier,),

                    ReviewListView(widget.product.latestReviews, widget.parentContext, limit: widget.product.latestReviews.length,),

                    Visibility(
                      visible: widget.product != null && widget.product.ratingAnalytic != null &&
                          widget.product.ratingAnalytic.totalReview != null && widget.product.ratingAnalytic.totalReview > 2,
                      child: Column(
                        children: <Widget>[

                          SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {

                              _showAllReviewBottomSheet(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 1.25 * SizeConfig.heightSizeMultiplier,
                                bottom: .625 * SizeConfig.heightSizeMultiplier,
                              ),
                              child: Row(
                                children: <Widget>[

                                  Text(AppLocalization.of(context).getTranslatedValue("view_all_review").toUpperCase(),
                                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontSize: 1.75 * SizeConfig.textSizeMultiplier,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),

                                  SizedBox(width: 2.05 * SizeConfig.widthSizeMultiplier,),

                                  Icon(Icons.arrow_forward_ios, size: 4 * SizeConfig.imageSizeMultiplier, color: Theme.of(context).primaryColor),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Visibility(
                visible: widget.product != null && widget.product.ratingAnalytic != null &&
                    (widget.product.ratingAnalytic.totalRating == null || widget.product.ratingAnalytic.totalRating == 0) &&
                    widget.product.ratingAnalytic.totalReview == null || widget.product.ratingAnalytic.totalReview == 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(height: 1.5 * SizeConfig.heightSizeMultiplier,),

                    Text(AppLocalization.of(context).getTranslatedValue("no_rating_review_added"),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 1.65 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                    SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 1.5 * SizeConfig.heightSizeMultiplier,),
        ],
      ),
    );
  }


  void _showAllReviewBottomSheet(BuildContext context) {

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(.6),
      elevation: 10,
      enableDrag: false,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(1.5 * SizeConfig.heightSizeMultiplier),
          topLeft: Radius.circular(1.5 * SizeConfig.heightSizeMultiplier),
        ),
      ),
      builder: (BuildContext context) {

        return AllReviewBottomSheet(widget.parentContext, widget.product);
      },
    );
  }
}