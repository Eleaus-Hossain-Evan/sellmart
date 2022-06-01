import '../model/review.dart';
import 'package:flutter/material.dart';

abstract class ReviewContract {

  void showAllReview(List<Review> reviews);
  void failedToGetReviews(BuildContext context);
  void onReviewSubmitted(BuildContext context);
  void onFailedToSubmitReview(BuildContext context, String message);
}