import '../utils/api_routes.dart';

class AppService {

  String id;
  String name;
  String image;
  String imageLarge;
  String description;
  String slug;
  bool active;

  AppService({this.id, this.name, this.image, this.imageLarge, this.description,
    this.slug, this.active});

  AppService.fromJson(Map<String, dynamic> json) {

    id = json['_id'];

    try {
      name = json['name'];
    }
    catch(error) {}

    try {
      image = APIRoute.BASE_URL + json['image'];
    }
    catch(error) {}

    try {
      imageLarge = APIRoute.BASE_URL + json['image_large'];
    }
    catch(error) {}

    try {
      description = json['description'];
    }
    catch(error) {}

    try {
      slug = json['slug'];
    }
    catch(error) {}

    try {
      active = json['active'];
    }
    catch(error) {

      try {
        active = (json['active'] == "1");
      }
      catch(error) {}
    }
  }


  toJson() {

    return {
      "_id" : id ?? "",
      "name" : name ?? "",
      "image" : image == null ? "" : image.split(APIRoute.BASE_URL)[1],
      "image_large" : imageLarge == null ? "" : imageLarge.split(APIRoute.BASE_URL)[1],
      "description" : description ?? "",
      "slug" : slug ?? "",
      "active" : active == null || active == false? "0" : "1",
    };
  }
}


class AppServices {

  List<AppService> list;

  AppServices({this.list});

  AppServices.fromJson(dynamic data) {

    list = List();

    if(data != null) {

      data.forEach((service) {

        list.add(AppService.fromJson(service));
      });
    }
  }
}