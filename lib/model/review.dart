import '../utils/api_routes.dart';

class Review {

  String id;
  String userID;
  String userName;
  String userPhone;
  int rating;
  String comment;
  String image;
  List<String> images;
  List<String> base64Images;
  String createdAt;
  String updatedAt;
  String date;
  bool approved;

  Review({this.id, this.userID, this.rating, this.comment, this.image, this.date, this.userName,
    this.images, this.createdAt, this.updatedAt, this.base64Images, this.approved, this.userPhone});

  Review.fromJson(Map<String, dynamic> json) {

    try {
      id = json['_id'];
    }
    catch(error) {}

    try {
      userID = json['userId'];
    }
    catch(error) {}

    try {
      userName = json['userName'];
    }
    catch(error) {}

    try {
      userPhone = json['userPhone'];
    }
    catch(error) {}

    try {
      approved = json['approved'];
    }
    catch(error) {}

    try {
      date = json['date'];
    }
    catch(error) {}

    try {
      rating = int.parse(json['rating'].toString());
    }
    catch(error) {}

    try {
      comment = json['comment'];
    }
    catch(error) {}

    try {
      image = APIRoute.BASE_URL + json['image'];
    }
    catch(error) {}

    try {

      images = List();

      json['image'].forEach((image) {

        images.add(APIRoute.BASE_URL + image.toString());
      });
    }
    catch(error) {

      images = List();
    }

    try {
      createdAt = json['created_at'] == null ? "" : json['created_at'].toString();
    }
    catch(error) {}

    try {
      updatedAt = json['updated_at'] == null ? "" : json['updated_at'].toString();
    }
    catch(error) {}
  }
}


class Reviews {

  List<Review> list;

  Reviews({this.list});

  Reviews.fromJson(dynamic data) {

    list = List();

    if(data != null) {

      data.forEach((review) {

        list.add(Review.fromJson(review));
      });
    }
  }
}