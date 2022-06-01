import '../model/product.dart';
import '../model/review.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import '../presenter/data_presenter.dart';

import '../contract/connectivity_contract.dart';
import '../contract/review_contract.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'review_list_view.dart';
import 'rating_analytic_widget.dart';

class AllReviewBottomSheet extends StatefulWidget {

  final BuildContext parentContext;
  final Product product;

  AllReviewBottomSheet(this.parentContext, this.product);

  @override
  _AllReviewBottomSheetState createState() => _AllReviewBottomSheetState();
}

class _AllReviewBottomSheetState extends State<AllReviewBottomSheet> with TickerProviderStateMixin implements Connectivity, ReviewContract {

  DataPresenter _presenter;

  ReviewContract _contract;
  Connectivity _connectivity;

  int _currentIndex = 0;

  List<Review> _reviews = [];

  @override
  void initState() {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(.6),
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    _connectivity = this;
    _contract = this;

    _presenter = DataPresenter(_connectivity, reviewContract: _contract);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _presenter.getProductReviews(context, widget.product.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPress,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(widget.parentContext).padding.top,
        ),
        child: DraggableScrollableSheet(
            expand: false,
            maxChildSize: 1,
            minChildSize: 0,
            initialChildSize: 1,
            builder: (context, controller) {

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(1.5 * SizeConfig.heightSizeMultiplier),
                    topLeft: Radius.circular(1.5 * SizeConfig.heightSizeMultiplier),
                  ),
                ),
                child: Column(
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.all(1.875 * SizeConfig.heightSizeMultiplier),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Text(AppLocalization.of(context).getTranslatedValue("latest_reviews").toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {

                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.close,
                              size: 6.41 * SizeConfig.imageSizeMultiplier,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: .125 * SizeConfig.heightSizeMultiplier,
                      color: Colors.grey[400],
                    ),

                    SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollBehavior(),
                        child: GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.down,
                          color: Colors.grey[300],
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(1.5 * SizeConfig.heightSizeMultiplier),
                              child: IndexedStack(
                                index: _currentIndex,
                                children: [

                                  Container(),

                                  Column(
                                    children: [

                                      RatingAnalyticWidget(widget.product.ratingAnalytic),

                                      SizedBox(height: 8 * SizeConfig.heightSizeMultiplier,),

                                      ReviewListView(_reviews, widget.parentContext, limit: _reviews.length,),
                                    ],
                                  ),
                                ],
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


  @override
  void dispose() {

    _onBackPress();
    super.dispose();
  }


  Future<bool> _onBackPress() {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    Navigator.of(context).pop();
    return Future(() => false);
  }


  @override
  void failedToGetReviews(BuildContext context) {}


  @override
  void onDisconnected(BuildContext context) {}


  @override
  void onInactive(BuildContext context) {}


  @override
  void onTimeout(BuildContext context) {}


  @override
  void onFailedToSubmitReview(BuildContext context, String message) {}


  @override
  void onReviewSubmitted(BuildContext context) {}


  @override
  void showAllReview(List<Review> reviews) {

    _reviews = reviews;
    _currentIndex = 1;

    if(mounted) {
      setState(() {});
    }
  }
}