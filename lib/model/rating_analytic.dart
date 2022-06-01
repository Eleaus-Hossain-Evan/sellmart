class RatingAnalytic {

  int totalRating;
  int totalReview;
  double rating;
  int oneStars;
  int twoStars;
  int threeStars;
  int fourStars;
  int fiveStars;

  RatingAnalytic({this.totalRating, this.totalReview, this.rating, this.oneStars,
    this.twoStars, this.threeStars, this.fourStars, this.fiveStars});

  RatingAnalytic.fromJson(Map<String, dynamic> json) {

    try {
      totalRating = int.parse(json['totalRating'].toString());
    }
    catch(error) {}

    try {
      totalReview = int.parse(json['totalReview'].toString());
    }
    catch(error) {}

    try {
      rating = double.parse(json['averageRating'].toString());
    }
    catch(error) {}

    try {
      oneStars = int.parse(json['totalRatingOne'].toString());
    }
    catch(error) {}

    try {
      twoStars = int.parse(json['totalRatingTwo'].toString());
    }
    catch(error) {}

    try {
      threeStars = int.parse(json['totalRatingThree'].toString());
    }
    catch(error) {}

    try {
      fourStars = int.parse(json['totalRatingFour'].toString());
    }
    catch(error) {}

    try {
      fiveStars = int.parse(json['totalRatingFive'].toString());
    }
    catch(error) {}
  }
}