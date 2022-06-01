import '../utils/api_routes.dart';

class Slider {

  String id;
  String image;
  String redirectUrl;
  String slug;

  Slider({this.id, this.image, this.redirectUrl, this.slug});

  Slider.fromJson(Map<String, dynamic> json) {

    id = json['_id'];

    try {
      image = APIRoute.BASE_URL + json['image'];
    }
    catch(error) {}

    try {
      redirectUrl = json['redirectUrl'];
    }
    catch(error) {}

    try {
      slug = json['slug'];
    }
    catch(error) {}
  }
}